#!/bin/bash

# 05_CRABS_ref_db.sh
# Pipeline adapted from Ballini & Staffoni et al. (2024) to create curated reference databases for Vert01 and Tele02 markers using CRABS v0.1.7.

# Find the repliSTREAM root directory dynamically
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPLISTREAM_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Set up directory paths relative to repliSTREAM root
DATA_DIR="$REPLISTREAM_ROOT/ref_db"
SCRIPTS_DIR="$REPLISTREAM_ROOT/scripts"
LOGS_DIR="$REPLISTREAM_ROOT/logs"
CRABS_DIR="$REPLISTREAM_ROOT/reference_database_creator"

# Set your NCBI contact email here (required for NCBI downloads)
USER_EMAIL="your_email@example.com"

# Create necessary directories
mkdir -p "$DATA_DIR" "$LOGS_DIR"

# Redirect output to log file in logs directory
exec > >(tee -i "$LOGS_DIR/crabs_pipeline.log") 2>&1

# Step 1: Download sequences from NCBI and BOLD
echo "Step 1: Downloading sequences..."

"$CRABS_DIR/crabs" db_download --source ncbi --database nucleotide \
  --query '12S[All Fields] OR "small subunit ribosomal RNA"[All Fields] AND "Actinopterygii"[Organism]' \
  --output "$DATA_DIR/ncbi_actinopterygii_12svert_full.fasta" --email $USER_EMAIL --batchsize 5000

"$CRABS_DIR/crabs" db_download --source ncbi --database nucleotide \
  --query '12S[All Fields] OR "small subunit ribosomal RNA"[All Fields] AND "Amphibia"[Organism] AND mitochondrion[filter]' \
  --output "$DATA_DIR/ncbi_amphibia_12svert_mito_filter.fasta" --email $USER_EMAIL --batchsize 5000

"$CRABS_DIR/crabs" db_download --source ncbi --database nucleotide \
  --query '12S[All Fields] OR "small subunit ribosomal RNA"[All Fields] AND "Cyclostomata"[Organism]' \
  --output "$DATA_DIR/ncbi_cyclostomata_12svert_full.fasta" --email $USER_EMAIL --batchsize 5000

"$CRABS_DIR/crabs" db_download --source ncbi --database nucleotide \
  --query '12S[All Fields] OR "small subunit ribosomal RNA"[All Fields] AND "Lepidosauria"[Organism]' \
  --output "$DATA_DIR/ncbi_lepidosauria_12svert_full.fasta" --email $USER_EMAIL --batchsize 5000

"$CRABS_DIR/crabs" db_download --source ncbi --database nucleotide \
  --query '12S[All Fields] OR "small subunit ribosomal RNA"[All Fields] AND "Archelosauria"[Organism] AND mitochondrion[filter]' \
  --output "$DATA_DIR/ncbi_archelosauria_12svert_mito_filter.fasta" --email $USER_EMAIL --batchsize 5000

"$CRABS_DIR/crabs" db_download --source ncbi --database nucleotide \
  --query '12S[All Fields] OR "small subunit ribosomal RNA"[All Fields] AND "Mammalia"[Organism] AND mitochondrion[filter]' \
  --output "$DATA_DIR/ncbi_mammalia_12svert_mito_filter.fasta" --email $USER_EMAIL --batchsize 5000

for taxon in Actinopterygii Amphibia Aves Cephalaspidomorphi Mammalia Reptilia; do
  "$CRABS_DIR/crabs" db_download --source bold \
    --database "$taxon" \
    --output "$DATA_DIR/bold_${taxon}.fasta" \
    --marker '12S' --keep_original no --boldgap DISCARD
done

# Step 2: Download taxonomy files
echo "Step 2: Downloading taxonomy files..."
cd "$DATA_DIR"
"$CRABS_DIR/crabs" db_download --source taxonomy --output "$DATA_DIR"

# Step 3: Merge all FASTA files
echo "Step 3: Merging FASTA files..."
"$CRABS_DIR/crabs" db_merge \
  --output "$DATA_DIR/merged_db.fasta" --uniq yes \
  --input \
    "$DATA_DIR/ncbi_actinopterygii_12svert_full.fasta" \
    "$DATA_DIR/ncbi_amphibia_12svert_mito_filter.fasta" \
    "$DATA_DIR/ncbi_cyclostomata_12svert_full.fasta" \
    "$DATA_DIR/ncbi_lepidosauria_12svert_full.fasta" \
    "$DATA_DIR/ncbi_archelosauria_12svert_mito_filter.fasta" \
    "$DATA_DIR/ncbi_mammalia_12svert_mito_filter.fasta" \
    "$DATA_DIR/bold_Actinopterygii.fasta" \
    "$DATA_DIR/bold_Amphibia.fasta" \
    "$DATA_DIR/bold_Aves.fasta" \
    "$DATA_DIR/bold_Cephalaspidomorphi.fasta" \
    "$DATA_DIR/bold_Mammalia.fasta" \
    "$DATA_DIR/bold_Reptilia.fasta"

# Step 4: Pre-filter merged file to remove extremely long sequences
echo "Step 4: Filtering merged DB to remove sequences over 500,000 bp..."
cd "$DATA_DIR"
python3 "$SCRIPTS_DIR/length-filtering.py" "$DATA_DIR/merged_db.fasta" --max_length 500000
mv "./merged_db_filtered_reads.fasta" "$DATA_DIR/ref_filtered_reads_nogap.fasta"
mv "./merged_db_discarded_reads.fasta" "$DATA_DIR/ref_discarded_reads_over500000.fasta"

# Remove gap characters and other problematic characters from sequences
echo "Removing gap characters from sequences..."
sed '/^>/! s/-//g; /^>/! s/\.//g; /^>/! s/ //g' "$DATA_DIR/ref_filtered_reads_nogap.fasta" > "$DATA_DIR/ref_filtered_reads_temp.fasta"
mv "$DATA_DIR/ref_filtered_reads_temp.fasta" "$DATA_DIR/ref_filtered_reads_nogap.fasta"

# Step 5: In silico PCR
echo "Step 5: In silico PCR..."
"$CRABS_DIR/crabs" insilico_pcr \
  --input "$DATA_DIR/ref_filtered_reads_nogap.fasta" \
  --output "$DATA_DIR/01-vert01_insilico-pcr.fasta" \
  --fwd TTAGATACCCCACTATGC --rev TAGAACAGGCTCCTCTAG --error 2

"$CRABS_DIR/crabs" insilico_pcr \
  --input "$DATA_DIR/ref_filtered_reads_nogap.fasta" \
  --output "$DATA_DIR/01-tele02_insilico-pcr.fasta" \
  --fwd AAACTCGTGCCAGCCACC --rev GGTATCTAATCCCAGTTTG --error 2

# Step 6: Length filtering (marker-specific)
echo "Step 6: Filtering amplicons by expected length..."
cd "$DATA_DIR"

# Process vert01
python3 "$SCRIPTS_DIR/length-filtering.py" "$DATA_DIR/01-vert01_insilico-pcr.fasta" --max_length 150
mv "./01-vert01_insilico-pcr_filtered_reads.fasta" "$DATA_DIR/01-vert01_insilico-pcr_filtered_reads.fasta"
mv "./01-vert01_insilico-pcr_discarded_reads.fasta" "$DATA_DIR/01-vert01_insilico-pcr_discarded_reads.fasta"

# Process tele02
python3 "$SCRIPTS_DIR/length-filtering.py" "$DATA_DIR/01-tele02_insilico-pcr.fasta" --max_length 250
mv "./01-tele02_insilico-pcr_filtered_reads.fasta" "$DATA_DIR/01-tele02_insilico-pcr_filtered_reads.fasta"
mv "./01-tele02_insilico-pcr_discarded_reads.fasta" "$DATA_DIR/01-tele02_insilico-pcr_discarded_reads.fasta"

# Step 7: Pairwise Global Alignment
echo "Step 7: Pairwise Global Alignment..."
"$CRABS_DIR/crabs" pga \
  --input "$DATA_DIR/ref_filtered_reads_nogap.fasta" \
  --output "$DATA_DIR/02-vert01_pga.fasta" \
  --database "$DATA_DIR/01-vert01_insilico-pcr_filtered_reads.fasta" \
  --fwd TTAGATACCCCACTATGC --rev TAGAACAGGCTCCTCTAG \
  --speed medium --percid 0.90 --coverage 0.90 --filter_method strict

"$CRABS_DIR/crabs" pga \
  --input "$DATA_DIR/ref_filtered_reads_nogap.fasta" \
  --output "$DATA_DIR/02-tele02_pga.fasta" \
  --database "$DATA_DIR/01-tele02_insilico-pcr_filtered_reads.fasta" \
  --fwd AAACTCGTGCCAGCCACC --rev GGTATCTAATCCCAGTTTG \
  --speed medium --percid 0.90 --coverage 0.90 --filter_method strict

# Step 8: Taxonomy assignment
echo "Step 8: Assigning taxonomy..."
"$CRABS_DIR/crabs" assign_tax \
  --input "$DATA_DIR/02-vert01_pga.fasta" \
  --output "$DATA_DIR/03-vert01_taxonomy.tsv" \
  --acc2tax "$DATA_DIR/nucl_gb.accession2taxid" \
  --taxid "$DATA_DIR/nodes.dmp" \
  --name "$DATA_DIR/names.dmp" \
  --missing "$DATA_DIR/03-vert01_missing_taxa.tsv"

"$CRABS_DIR/crabs" assign_tax \
  --input "$DATA_DIR/02-tele02_pga.fasta" \
  --output "$DATA_DIR/03-tele02_taxonomy.tsv" \
  --acc2tax "$DATA_DIR/nucl_gb.accession2taxid" \
  --taxid "$DATA_DIR/nodes.dmp" \
  --name "$DATA_DIR/names.dmp" \
  --missing "$DATA_DIR/03-tele02_missing_taxa.tsv"

# Step 9: Curation
python3 "$SCRIPTS_DIR/dbrefinement_strict.py" "$DATA_DIR/03-vert01_taxonomy.tsv" "$DATA_DIR/04-vert01_taxonomy-curated.tsv"
python3 "$SCRIPTS_DIR/dbrefinement_strict.py" "$DATA_DIR/03-tele02_taxonomy.tsv" "$DATA_DIR/04-tele02_taxonomy-curated.tsv"

# Step 10: Dereplication
"$CRABS_DIR/crabs" dereplicate --input "$DATA_DIR/04-vert01_taxonomy-curated.tsv" --output "$DATA_DIR/05-vert01_dereplicated.tsv" --method uniq_species
"$CRABS_DIR/crabs" dereplicate --input "$DATA_DIR/04-tele02_taxonomy-curated.tsv" --output "$DATA_DIR/05-tele02_dereplicated.tsv" --method uniq_species

# Step 11: Cleanup and FASTA formatting
"$CRABS_DIR/crabs" seq_cleanup --input "$DATA_DIR/05-vert01_dereplicated.tsv" --output "$DATA_DIR/06-vert01_cleaned.tsv" --minlen 30 --maxlen 150 --maxns 2 --enviro yes --species yes --nans 2
"$CRABS_DIR/crabs" seq_cleanup --input "$DATA_DIR/05-tele02_dereplicated.tsv" --output "$DATA_DIR/06-tele02_cleaned.tsv" --minlen 100 --maxlen 250 --maxns 2 --enviro yes --species yes --nans 2

"$CRABS_DIR/crabs" tax_format --input "$DATA_DIR/06-vert01_cleaned.tsv" --output "$DATA_DIR/07-vert01_idt.fasta" --format idt
"$CRABS_DIR/crabs" tax_format --input "$DATA_DIR/06-tele02_cleaned.tsv" --output "$DATA_DIR/07-tele02_idt.fasta" --format idt

python3 "$SCRIPTS_DIR/idt2barque.py" "$DATA_DIR/07-vert01_idt.fasta" "$DATA_DIR/07-vert01_barque.fasta"
python3 "$SCRIPTS_DIR/idt2barque.py" "$DATA_DIR/07-tele02_idt.fasta" "$DATA_DIR/07-tele02_barque.fasta"

# Step 12: Compress final Barque FASTA files
echo "Step 12: Compressing Barque FASTA outputs..."
gzip -kf "$DATA_DIR/07-vert01_barque.fasta"
gzip -kf "$DATA_DIR/07-tele02_barque.fasta"

# Step 13: Report number of sequences in final Barque FASTA files
echo "Step 13: Reporting sequence counts..."
echo -n "07-vert01_barque.fasta contains: "
grep -c '^>' "$DATA_DIR/07-vert01_barque.fasta"

echo -n "07-tele02_barque.fasta contains: "
grep -c '^>' "$DATA_DIR/07-tele02_barque.fasta"

echo "CRABS reference database pipeline complete."
echo "You can now use the .barque.fasta.gz files for Barque or other downstream tools."