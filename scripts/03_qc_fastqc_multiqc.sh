#!/bin/bash
# 03_qc_fastqc_multiqc.sh
#
# Description:
# Runs FastQC on all FASTQ files in data/raw_reads/fastq/ and summarizes results with MultiQC.
# Individual FastQC reports (.html, .zip) are saved in data/raw_reads/fastqc_reports/.
# MultiQC summary report is saved in data/raw_reads/multiqc_report/.
# Errors are logged to logs/fastqc_errors.log and logs/multiqc_errors.log.
#
# Required:
# - .fastq files from Step 2, located in data/raw_reads/fastq/
# - FastQC and MultiQC installed and available in PATH
#
# Modify:
# - PROJECT_DIR path if your folder structure is different

# Set the root project directory (customize this if needed)
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
RAW_DIR="$PROJECT_DIR/data/raw_reads"
FASTQ_DIR="$RAW_DIR/fastq"
LOG_DIR="$PROJECT_DIR/logs"
FASTQC_DIR="$RAW_DIR/fastqc_reports"
MULTIQC_DIR="$RAW_DIR/multiqc_report"

# Ensure required directories exist
mkdir -p "$LOG_DIR" "$FASTQ_DIR" "$FASTQC_DIR" "$MULTIQC_DIR"

# Check for FASTQ files
if ! ls "$FASTQ_DIR"/*.fastq 1> /dev/null 2>&1; then
    echo "No FASTQ files found in $FASTQ_DIR. Exiting."
    exit 1
fi

# Check for FastQC
if ! command -v fastqc &> /dev/null; then
    echo "Error: FastQC not found in PATH." >&2
    exit 1
fi

# Check for MultiQC
if ! command -v multiqc &> /dev/null; then
    echo "Error: MultiQC not found in PATH." >&2
    exit 1
fi

echo "Running FastQC on all FASTQ files in $FASTQ_DIR..."
for fq in "$FASTQ_DIR"/*.fastq; do
    fastqc "$fq" -o "$FASTQC_DIR" --threads 2 2>> "$LOG_DIR/fastqc_errors.log"
done

echo "Running MultiQC on FastQC results..."
multiqc "$FASTQC_DIR" -o "$MULTIQC_DIR" 2>> "$LOG_DIR/multiqc_errors.log"

echo "Done. FastQC reports saved to: $FASTQC_DIR"
echo "MultiQC summary saved to: $MULTIQC_DIR"