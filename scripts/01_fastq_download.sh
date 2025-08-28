#!/bin/bash
# 01_fastq_download.sh
#
# Download .sra files from NCBI using accession IDs listed in config/SRR_Acc_List.txt.
# Files are saved to data/raw_reads, and any download errors are logged to logs/prefetch_errors.log.
#
# Usage:
#   bash scripts/01_fastq_download.sh
#
# Requirements:
#   - SRA Toolkit installed (prefetch)
#   - config/SRR_Acc_List.txt (one SRA Run ID per line)
#
# Modify PROJECT_DIR if you want to run outside the project root.

# Set root project directory (default: current directory)
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
RAW_DIR="$PROJECT_DIR/data/raw_reads"
LOG_DIR="$PROJECT_DIR/logs"
ACCESSIONS="$PROJECT_DIR/config/SRR_Acc_List.txt"

# Create folders if they don't exist
mkdir -p "$RAW_DIR" "$LOG_DIR"

# Check for SRA Toolkit
if ! command -v prefetch &> /dev/null; then
    echo "Error: SRA Toolkit (prefetch) not found in PATH." >&2
    exit 1
fi

# Check for accession list
if [ ! -f "$ACCESSIONS" ]; then
    echo "Error: Accession list file not found at $ACCESSIONS" >&2
    exit 1
fi

# Read accession IDs into array
mapfile -t sra_ids < "$ACCESSIONS"

# Loop and download
for sra_id in "${sra_ids[@]}"; do
    echo "Downloading $sra_id..."
    prefetch "$sra_id" --output-directory "$RAW_DIR" 2>> "$LOG_DIR/prefetch_errors.log"
    if [ $? -eq 0 ]; then
        echo "$sra_id downloaded successfully."
    else
        echo "Error downloading $sra_id. See $LOG_DIR/prefetch_errors.log"
    fi
done