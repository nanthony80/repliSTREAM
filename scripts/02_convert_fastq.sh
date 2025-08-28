#!/bin/bash
# 02_convert_fastq.sh
#
# Description:
# Converts all .sra files under data/raw_reads/ to paired-end .fastq files using SRA Toolkit (fasterq-dump).
# Output .fastq files are saved in data/raw_reads/fastq/.
# Original .sra files are moved to data/raw_reads/sra/.
# Any errors during conversion are logged to logs/fasterq_errors.log.
#
# Required:
# - SRA Toolkit installed and available in PATH
# - .sra files downloaded and located under data/raw_reads/ (see 01_fastq_download.sh)
#
# Project structure:
# - scripts/02_convert_fastq.sh
# - config/
# - data/raw_reads/
#     - fastq/   # output .fastq files
#     - sra/     # original .sra files after conversion
# - logs/
#
# Modify:
# - PROJECT_DIR path if your folder structure is different

# Set the root project directory (customize this if needed)
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
RAW_DIR="$PROJECT_DIR/data/raw_reads"
FASTQ_DIR="$RAW_DIR/fastq"
SRA_DIR="$RAW_DIR/sra"
LOG_DIR="$PROJECT_DIR/logs"

# Create folders if they don't exist
mkdir -p "$FASTQ_DIR" "$SRA_DIR" "$LOG_DIR"

# Check for SRA Toolkit
if ! command -v fasterq-dump &> /dev/null; then
    echo "Error: fasterq-dump not found in PATH." >&2
    exit 1
fi

echo "🔍 Finding and converting all .sra files under $RAW_DIR..."

find "$RAW_DIR" -type f -name "*.sra" | while read -r sra_path; do
    sra_id=$(basename "$sra_path" .sra)
    echo "➡️ Converting: $sra_id ($sra_path)"

    if fasterq-dump --split-files "$sra_path" --outdir "$FASTQ_DIR" 2>> "$LOG_DIR/fasterq_errors.log"; then
        echo "✔ Success: $sra_id"
        if mv -n "$sra_path" "$SRA_DIR/"; then
            echo "Moved $sra_path to $SRA_DIR/"
        else
            echo "⚠️ Failed to move $sra_path"
        fi
    else
        echo "✖ Failed: $sra_id — see $LOG_DIR/fasterq_errors.log"
    fi
done

echo "🧹 Removing empty directories under $RAW_DIR..."
find "$RAW_DIR" -type d -empty -delete

echo "✅ Done. FASTQ files are in: $FASTQ_DIR"
echo "   SRA files moved to:        $SRA_DIR"