# CRABS to APSCALE Database Preparation

This guide explains how to convert CRABS reference databases for tele02 and vert01 markers into APSCALE-compatible BLAST and taxonomy formats for taxonomic assignment with APSCALE-BLAST following the APSCALE pipeline.  

---

## Overview

The CRABS to APSCALE step processes curated reference sequences for each marker and produces:
- A BLAST-ready nucleotide database (`db.*`) for APSCALE
- A Parquet-formatted taxonomy table with one record per marker sequence

You will use the script `09_CRABS_to_APSCALE.py` to automate this process for both tele02 and vert01.

---

## Requirements

- Cleaned TSV mapping files for each marker (e.g., `06-tele02_cleaned.tsv`, `06-vert01_cleaned.tsv`) from CRABS output
- Barque reference FASTA files for each marker (e.g., `07-tele02_barque.fasta`, `07-vert01_barque.fasta`) from CRABS output
- Python ≥ 3.6, with:
  - pandas
  - biopython
  - ete3
  - pyarrow
- BLAST+ (`makeblastdb` must be available in your PATH)

---

## Setup Instructions

### 1. Organize Input Files

Ensure you have the following files for each marker:
- `06-tele02_cleaned.tsv` and `07-tele02_barque.fasta`
- `06-vert01_cleaned.tsv` and `07-vert01_barque.fasta`

Place them in your working directory.

---

### 2. Install Dependencies

Recommended environment setup:

```bash
python3 -m pip install pandas biopython ete3 pyarrow
which makeblastdb
```

---

## Running CRABS to APSCALE Conversion

You can process both markers, or just one, using:

```bash
python 09_CRABS_to_APSCALE.py
```
- **Default:** Runs both tele02 and vert01.

To process only tele02:

```bash
python 09_CRABS_to_APSCALE.py tele02
```

To process only vert01:

```bash
python 09_CRABS_to_APSCALE.py vert01
```

To process both explicitly:

```bash
python 09_CRABS_to_APSCALE.py tele02 vert01
```

**Outputs** are written to:
- `crabs_to_apscale_db_tele02/`
- `crabs_to_apscale_db_vert01/`

Each contains:
- `db.fasta.gz`: FASTA file with processed accessions
- BLAST database files: `db.*`
- Taxonomy table: `db_taxonomy.parquet.snappy`
- Zipped archive of the output folder

---

## Output File Structure

Within each output directory:

- `db.fasta.gz` – marker sequences for BLAST, sanitized accessions
- `db_taxonomy.parquet.snappy` – taxonomy table (Parquet format)
- BLAST database files (`db.*`)
- Zipped output folder (`crabs_to_apscale_db_[marker].zip`)

---

## Downstream Use

These databases are ready for use with APSCALE-BLAST for taxonomic assigment.

---

## Next Step

Open [`10_apscale.md`](10_apscale.md) and follow the instructions to run the APSCALE-CLI pipeline.

---

## References

- [APSCALE GitHub repository](https://github.com/DominikBuchner/apscale)
- **Buchner, D., Macher, T. H., & Leese, F. (2022).** APSCALE: advanced pipeline for simple yet comprehensive analyses of DNA metabarcoding data. *Bioinformatics* 38(20), 4817–4819. [https://doi.org/10.1093/bioinformatics/btac588](https://doi.org/10.1093/bioinformatics/btac588)
