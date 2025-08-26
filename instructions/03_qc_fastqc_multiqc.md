# Quality Control: FastQC + MultiQC

This guide walks you through running FastQC and summarizing results with MultiQC for samples from the Ballini et al. (2024) study.

---

## Prerequisites

- You must have `.fastq` files from Step 2 located in `data/raw_reads/fastq/`
- Activate your environment where FastQC and MultiQC are installed

---

## Installing FastQC and MultiQC (if not installed)

```bash
conda create -n multiqc_env -c bioconda multiqc fastqc
conda activate multiqc_env
```

---

## How to Run

From your project root:

```bash
bash scripts/03_qc_fastqc_multiqc.sh
```

---

## Output

- Individual FastQC reports in `data/raw_reads/fastqc_reports/`
- MultiQC summary in `data/raw_reads/multiqc_report/`

---

## How to Check Your Results

After running the script, you should:

1. **Check for FastQC reports:**
   - Open the `data/raw_reads/fastqc_reports/` directory.
   - You should see one `.html` and one `.zip` file for each FASTQ file processed (e.g., `SRR31057072_1_fastqc.html`).
   - Open a `.html` report in your web browser to review quality metrics for each sample.

2. **Check for MultiQC summary:**
   - Open the `data/raw_reads/multiqc_report/` directory.
   - You should see a `multiqc_report.html` file.
   - Open this file in your web browser to view a summary of all FastQC results in one place.

3. **Check for errors:**
   - Review the log files in the `logs/` directory:
     - `logs/fastqc_errors.log`
     - `logs/multiqc_errors.log`
   - If these files are empty or only contain minor warnings, your run was likely successful.
   - If you see errors, review them and re-run the script if needed.

---

**Tip:**  
If any FastQC or MultiQC report is missing or incomplete, check the log files for errors and ensure all input FASTQ files are present and readable.

---

## How to Interpret Your Results

- Open each FastQC `.html` report and look for green “pass” indicators, especially for:
  - Per base sequence quality
  - Per sequence quality scores
  - Adapter content
- In MultiQC, check the summary table for any samples with warnings or failures.
- If you see red or orange flags in critical modules, consider trimming or filtering your FASTQ files before proceeding.
- For more details, consult the [FastQC documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/).

**A high-quality FASTQ file will have mostly green (pass) indicators and high per-base quality scores across the read length.**

---

## Next Step

Open [`04_rename_fastq.md`](04_rename_fastq.md) and follow the instructions to gzip and rename your FASTQ files for Barque.

---

## References

Sample sequences from:
- Ballini, L., Staffoni, G., Nespoli, D. et al. Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. Hydrobiologia 852, 791–803 (2025). https://doi.org/10.1007/s10750-024-05723-y