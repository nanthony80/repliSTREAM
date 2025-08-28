#!/bin/bash

# 06_CRABS_to_QIIME2.sh
# Convert CRABS Barque reference databases to QIIME2 format for eDNA-Container App
# Dependencies: QIIME2 v2023.2, awk, gzip, grep, sed, paste
# Usage: bash scripts/06_CRABS_to_QIIME2.sh
# All output files created in eDNA_container_app directory.

set -euo pipefail

# Set directory for reference databases
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPLISTREAM_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
REF_DB_DIR="$REPLISTREAM_ROOT/eDNA_container_app"

echo "=== Converting CRABS Barque databases to QIIME2 format ==="
echo "Working in: $REF_DB_DIR"

# Check for QIIME2
if ! command -v qiime &> /dev/null; then
  echo "Error: QIIME2 is not installed or not in PATH."
  exit 1
fi

cd "$REF_DB_DIR"

#####################################################################
# Step 1: tele02
echo "=== Processing tele02 ==="

if [ ! -f "07-tele02_barque.fasta.gz" ]; then
  echo "Error: 07-tele02_barque.fasta.gz not found in $REF_DB_DIR"
  exit 1
fi

gunzip -k 07-tele02_barque.fasta.gz

awk '/^>/ {header=$0; if(seen[header]++ == 0) print header} !/^>/ {if(seen[header]==1) print}' 07-tele02_barque.fasta > 07-tele02_barque_deduped.fasta

qiime tools import \
  --type 'FeatureData[Sequence]' \
  --input-path 07-tele02_barque_deduped.fasta \
  --output-path tele02_sequences.qza \
  --input-format DNAFASTAFormat

grep "^>" 07-tele02_barque_deduped.fasta | sed 's/^>//' > tele02_headers.txt
paste tele02_headers.txt tele02_headers.txt > tele02_taxonomy.txt

awk -F'\t' 'NF == 2 && $2 !~ /^[[:space:]]*$/' tele02_taxonomy.txt > tele02_taxonomy_cleaned.txt

qiime tools import \
  --type 'FeatureData[Taxonomy]' \
  --input-format HeaderlessTSVTaxonomyFormat \
  --input-path tele02_taxonomy_cleaned.txt \
  --output-path tele02_taxonomy.qza

qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads tele02_sequences.qza \
  --i-reference-taxonomy tele02_taxonomy.qza \
  --o-classifier tele02_classifier.qza

echo "=== tele02 processing complete! ==="

#####################################################################
# Step 2: vert01
echo "=== Processing vert01 ==="

if [ ! -f "07-vert01_barque.fasta.gz" ]; then
  echo "Error: 07-vert01_barque.fasta.gz not found in $REF_DB_DIR"
  exit 1
fi

gunzip -k 07-vert01_barque.fasta.gz

awk '/^>/ {header=$0; if(seen[header]++ == 0) print header} !/^>/ {if(seen[header]==1) print}' 07-vert01_barque.fasta > 07-vert01_barque_deduped.fasta

qiime tools import \
  --type 'FeatureData[Sequence]' \
  --input-path 07-vert01_barque_deduped.fasta \
  --output-path vert01_sequences.qza \
  --input-format DNAFASTAFormat

grep "^>" 07-vert01_barque_deduped.fasta | sed 's/^>//' > vert01_headers.txt
paste vert01_headers.txt vert01_headers.txt > vert01_taxonomy.txt

awk -F'\t' 'NF == 2 && $2 !~ /^[[:space:]]*$/' vert01_taxonomy.txt > vert01_taxonomy_cleaned.txt

qiime tools import \
  --type 'FeatureData[Taxonomy]' \
  --input-format HeaderlessTSVTaxonomyFormat \
  --input-path vert01_taxonomy_cleaned.txt \
  --output-path vert01_taxonomy.qza

qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads vert01_sequences.qza \
  --i-reference-taxonomy vert01_taxonomy.qza \
  --o-classifier vert01_classifier.qza

echo "=== vert01 processing complete! ==="

echo "=== All processing complete! QIIME2 databases and classifiers ready. ==="
echo "Output files created in: $REF_DB_DIR"
echo "  - tele02_sequences.qza"
echo "  - tele02_taxonomy.qza"
echo "  - tele02_classifier.qza"
echo "  - vert01_sequences.qza"
echo "  - vert01_taxonomy.qza"
echo "  - vert01_classifier.qza"