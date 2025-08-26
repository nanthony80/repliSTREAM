#!/usr/bin/env python3
# 09_CRABS_to_APSCALE.py
# Convert CRABS tele02 and vert01 databases to APSCALE BLAST/taxonomy format for APSCALE pipeline.
#
# Inputs:
#   - 06-tele02_cleaned.tsv   # tele02 sequence-to-accession/taxid map
#   - 07-tele02_barque.fasta  # tele02 reference marker fasta
#   - 06-vert01_cleaned.tsv   # vert01 sequence-to-accession/taxid map
#   - 07-vert01_barque.fasta  # vert01 reference marker fasta
#
# Outputs:
#   - crabs_to_apscale_db_tele02/ and crabs_to_apscale_db_vert01/ folders
#     (each with db.fasta.gz, db_taxonomy.parquet.snappy, BLAST db files, zipped archive)
#
# Dependencies:
#   - Python >= 3.6
#   - pandas, biopython, ete3, pyarrow
#   - BLAST+ (makeblastdb in PATH)
#
# See 09_CRABS_to_APSCALE.md for usage and details.

import re, sys, gzip, shutil, subprocess, hashlib, textwrap
from pathlib import Path
import pandas as pd
from Bio import SeqIO
from ete3 import NCBITaxa

DB_PREFIX = "db"

def norm_seq(s: str) -> str:
    return re.sub(r"[^ACGTN]", "N", s.upper())

def safe_acc(a: str) -> str:
    return re.sub(r"[^\w.\-]", "_", a)[:50]

def md5_short(s: str, n=10) -> str:
    return hashlib.md5(s.encode("utf-8")).hexdigest()[:n]

def load_tsv_map(tsv: Path):
    df = pd.read_csv(tsv, sep="\t", header=None, dtype=str, engine="python")
    df = df.map(lambda x: x.strip() if isinstance(x, str) else x)
    if df.shape[1] < 3:
        sys.exit(f"[error] unexpected TSV format with {df.shape[1]} columns")
    col_acc, col_taxid, col_seq = 0, 1, df.shape[1] - 1
    genus_col = col_seq - 2 if df.shape[1] >= 5 else None
    species_col = col_seq - 1 if df.shape[1] >= 4 else None
    seqmap = {}
    for _, r in df.iterrows():
        seqN = norm_seq(str(r.iloc[col_seq]))
        seqmap[seqN] = {
            "Accession": str(r.iloc[col_acc]),
            "TaxID": str(r.iloc[col_taxid]),
            "genus_hint": (str(r.iloc[genus_col]) if genus_col and genus_col > 1 else ""),
            "species_hint": (str(r.iloc[species_col]) if species_col and species_col > 1 else "")
        }
    return seqmap

def parse_header_binomial(header: str):
    p = header.split("_")
    genus = p[-2] if len(p) >= 2 else ""
    species = p[-1] if len(p) >= 1 else ""
    genus = genus.replace("_", " ").strip()
    species = species.replace("_", " ").strip()
    binom = (genus + " " + species).strip()
    return genus, species, binom

def ete_lineage_for_taxid(ncbi: NCBITaxa, tid: str):
    try:
        lin = ncbi.get_lineage(int(tid))
        ranks = ncbi.get_rank(lin)
        names = ncbi.get_taxid_translator(lin)
        return lin, ranks, names
    except Exception:
        return None, {}, {}

def ete_lineage_for_name(ncbi: NCBITaxa, name: str):
    try:
        hits = ncbi.get_name_translator([name])
        if not hits:
            return None, {}, {}
        tid = list(hits.values())[0][0]
        return ete_lineage_for_taxid(ncbi, str(tid))
    except Exception:
        return None, {}, {}

def extract_ranks(lin, ranks, names):
    wanted = ["superkingdom", "phylum", "class", "order", "family", "genus", "species"]
    out = {k: "" for k in wanted}
    if not lin:
        return out
    for r in wanted:
        ts = [t for t in lin if ranks.get(t, "").lower() == r]
        if ts:
            out[r] = names[ts[0]]
    return out

def write_fasta(rows, recs, out_gz: Path):
    with gzip.open(out_gz, "wt") as out:
        for rec_idx, acc in rows:
            rec = recs[rec_idx]
            seq = norm_seq(str(rec.seq))
            out.write(f">{safe_acc(acc)}\n")
            out.write("\n".join(textwrap.wrap(seq, 80)) + "\n")

def make_blastdb_v5(fa_gz: Path, out_prefix: Path):
    cmd = (
        f'zcat < "{fa_gz}" | '
        f'makeblastdb -in - -dbtype nucl -title {out_prefix.name} -blastdb_version 5 -out "{out_prefix}"'
    )
    print(f"[INFO] Running: {cmd}")
    rc = subprocess.run(cmd, shell=True).returncode
    if rc != 0:
        sys.exit("[ERROR] makeblastdb failed")

def process_marker(marker):
    print("========================================")
    print(f"  CRABS to APSCALE BLAST Conversion: {marker}")
    print("========================================")
    CLEANED_TSV = Path(f"06-{marker}_cleaned.tsv")
    BARQUE_FASTA = Path(f"07-{marker}_barque.fasta")
    OUT_ROOT = Path(f"crabs_to_apscale_db_{marker}")
    print(f"[INFO] Input TSV:    {CLEANED_TSV}")
    print(f"[INFO] Input FASTA:  {BARQUE_FASTA}")
    print(f"[INFO] Output Dir:   {OUT_ROOT}")
    print("----------------------------------------")

    OUT_ROOT.mkdir(parents=True, exist_ok=True)
    print("[INFO] Loading cleaned TSV map ...")
    seqmap = load_tsv_map(CLEANED_TSV)
    print("[INFO] Reading Barque FASTA ...")
    recs = list(SeqIO.parse(str(BARQUE_FASTA), "fasta"))
    ncbi = NCBITaxa()
    taxa_rows = []
    fasta_rows = []
    print("[INFO] Building output records ...")
    for i, rec in enumerate(recs):
        seqN = norm_seq(str(rec.seq))
        hdr = rec.description.split()[0]
        genus, species, binom = parse_header_binomial(hdr)
        if seqN in seqmap:
            acc = seqmap[seqN]["Accession"]
            tid = seqmap[seqN]["TaxID"]
            lin, ranks, names = ete_lineage_for_taxid(ncbi, tid)
            tx = extract_ranks(lin, ranks, names)
            if not tx["genus"]:
                tx["genus"] = seqmap[seqN]["genus_hint"].replace("_", " ")
            if not tx["species"]:
                tx["species"] = seqmap[seqN]["species_hint"].replace("_", " ")
        else:
            acc = f"BARQUE_{md5_short(seqN)}"
            lin, ranks, names = ete_lineage_for_name(ncbi, binom)
            if not lin:
                lin, ranks, names = ete_lineage_for_name(ncbi, genus)
            tx = extract_ranks(lin, ranks, names)
            if not tx["genus"]:
                tx["genus"] = genus
            if not tx["species"]:
                tx["species"] = (genus + " " + species).strip()
        taxa_rows.append({
            "Accession": safe_acc(acc),
            "superkingdom": tx["superkingdom"],
            "phylum": tx["phylum"],
            "class": tx["class"],
            "order": tx["order"],
            "family": tx["family"],
            "genus": tx["genus"],
            "species": tx["species"],
        })
        fasta_rows.append((i, acc))
    tax_df = pd.DataFrame(taxa_rows, dtype=str)
    tax_pq = OUT_ROOT / "db_taxonomy.parquet.snappy"
    print(f"[INFO] Saving taxonomy → {tax_pq}")
    tax_df.to_parquet(tax_pq, compression="snappy", index=False, engine="pyarrow")
    fa_gz = OUT_ROOT / f"{DB_PREFIX}.fasta.gz"
    print(f"[INFO] Writing FASTA → {fa_gz}")
    write_fasta(fasta_rows, recs, fa_gz)
    db_prefix_path = OUT_ROOT / DB_PREFIX
    print("[INFO] Building BLAST database (v5) ...")
    make_blastdb_v5(fa_gz, db_prefix_path)
    print(f"[INFO] Zipping output folder → {OUT_ROOT}.zip")
    shutil.make_archive(str(OUT_ROOT), "zip", root_dir=str(OUT_ROOT))
    print("========================================")
    print(f"[COMPLETE] {marker.upper()} APSCALE BLAST & taxonomy files ready!")
    print(f"  - {fa_gz}")
    print(f"  - {tax_pq}")
    print(f"  - BLAST db files: {db_prefix_path}.*")
    print(f"  - zipped archive: {OUT_ROOT}.zip")
    print("========================================")

if __name__ == "__main__":
    markers = ["tele02", "vert01"]
    if len(sys.argv) > 1:
        markers = sys.argv[1:]
    for marker in markers:
        process_marker(marker)