#!/bin/bash
# 04_rename_fastq.sh
#
# Description:
# Compresses and renames paired-end FASTQ files using metadata.csv for Barque pipeline input.
# Output files are named as required by Barque and saved in data/raw_reads/fastq_renamed/.
# Files are also organized by primer type into tele02/ and vert01/ subdirectories.
#
# Required:
# - metadata.csv in data/ (see 04_rename_fastq.md for instructions)
# - FASTQ files from Step 3 in data/raw_reads/fastq/
#
# Modify:
# - PROJECT_DIR path if your folder structure is different

set -euo pipefail

# Set the root project directory (customize this if needed)
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
FASTQ_DIR="$PROJECT_DIR/data/raw_reads/fastq"
RENAMED_DIR="$PROJECT_DIR/data/raw_reads/fastq_renamed"
METADATA_CSV="$PROJECT_DIR/data/metadata.csv"

mkdir -p "$RENAMED_DIR"

echo "Compressing and renaming FASTQ files using metadata.csv..."
tail -n +2 "$METADATA_CSV" | while IFS=, read -r biosample sample_name srs fastq river replicate primer latitude longitude; do
    for read in 1 2; do
        old="${fastq}_${read}.fastq"
        new="${fastq}-${river}-${replicate}-${primer}_R${read}_001.fastq.gz"
        if [[ -f "$FASTQ_DIR/$old" ]]; then
            gzip -c "$FASTQ_DIR/$old" > "$RENAMED_DIR/$new"
            echo "Created $RENAMED_DIR/$new"
        else
            echo "Warning: $old not found."
        fi
    done
done

echo "All FASTQ files compressed and renamed for Barque in $RENAMED_DIR."

# Organize files by primer type
echo "Organizing files by primer type..."
cd "$RENAMED_DIR"

mkdir -p tele02 vert01
mv *Tele02*.fastq.gz tele02/ 2>/dev/null || echo "No Tele02 files found"
mv *Vert01*.fastq.gz vert01/ 2>/dev/null || echo "No Vert01 files found"

echo "Files organized into primer-specific directories."