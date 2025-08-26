# FASTQ Conversion

This guide explains how to convert `.sra` files from the Ballini et al. (2024) study to paired-end `.fastq` files using the SRA Toolkit.   
All commands are run via `scripts/02_convert_fastq.sh`.

---

## Convert SRA to FASTQ

The conversion script will:
- Recursively find all `.sra` files in `data/raw_reads/` (including subfolders)
- Convert each to paired-end `.fastq` using `fasterq-dump`
- Output all `.fastq` files to `data/raw_reads/fastq/`
- Move all `.sra` files to `data/raw_reads/sra/`
- Remove any empty subdirectories left in `data/raw_reads/`
- Log any errors to `logs/fasterq_errors.log`

---

### Requirements

- Step 1 (`01_fastq_download.sh`) must be completed
- SRA Toolkit must be installed and available in your PATH

---

## How to Run

From your project root:

```bash
bash scripts/02_convert_fastq.sh
```

---

## Output

After this step:
- All paired `.fastq` files will be in `data/raw_reads/fastq/`
- All `.sra` files will be in `data/raw_reads/sra/`
- Any empty subfolders in `data/raw_reads/` will be deleted
- Errors (if any) will appear in `logs/fasterq_errors.log`

---

## Next Step

Proceed to quality control and file validation:  
Open [`03_qc_fastqc_multiqc.md`](03_qc_fastqc_multiqc.md) for instructions on assessing FASTQ file quality with FastQC and MultiQC.

---

## References

Sample sequences from:
- Ballini, L., Staffoni, G., Nespoli, D. et al. Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. Hydrobiologia 852, 791–803 (2025). https://doi.org/10.1007/s10750-024-05723-y