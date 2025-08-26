# Renaming FASTQ Files

This guide walks you through preparing a metadata file, compressing, and renaming paired-end `.fastq` files to match the format required by the Barque pipeline for samples from the Ballini et al. (2024) study.

All commands are run via `scripts/04_rename_fastq.sh`.

---

## Step 4: Prepare and Use the Metadata File

1. **Download the SRA Run Table:**
   - Go to the [BioProject page](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1175355)
   - Under **Project Data**, click **“SRA Experiments (88)”**
   - Click **“Send results to Run selector”** at the top of the table
   - In the Run Selector page, click **“Metadata”** to download `SraRunTable.csv`

2. **Complete the Metadata:**
   - Open `SraRunTable.csv` in a spreadsheet editor
   - Add or fill in these columns:  
     - `replicate` (e.g., r1, r2, neg, etc.)
     - `river` (e.g., ARGENTINA, TANARO, etc.)
     - `primer` (e.g., Tele02, Vert01)
     - `latitude`, `longitude` (look up and fill as needed)
   - Save as `data/metadata.csv`

---

## How to Run

```bash
bash scripts/04_rename_fastq.sh
```

---

## Output

After running:
- `metadata.csv` will be in `data/`
- Files like `SRR31057072_1.fastq` and `_2.fastq` will be compressed and renamed to:
  - `SRR31057072-ARGENTINA-r1-Tele02_R1_001.fastq.gz`
  - `SRR31057072-ARGENTINA-r1-Tele02_R2_001.fastq.gz`
- Renamed and compressed files will be in `data/raw_reads/fastq_renamed/`
- Files are organized by primer type into `tele02/` and `vert01/` subdirectories

---

## Barque File Naming Requirements

> **IMPORTANT:**  
> Barque requires sample files to follow this format:
>
> ```
> SampleID_*_R1_001.fastq.gz  
> SampleID_*_R2_001.fastq.gz
> ```
> - `SampleID` must **not contain underscores** and must be followed by an underscore.
> - The `*` can be any string (use dashes `-` to separate parts, not spaces).
> - Example: `PopA-sample001_ANYTHING_R1_001.fastq.gz`
>
> See [Barque GitHub](https://github.com/enormandeau/barque) for full details.

---

## Software Requirements

Before running this script, make sure you have the following installed:

- Python 3.8 or newer
- [pandas](https://pandas.pydata.org/)

---

## Next Step

Open [`05_CRABS_ref_db.md`](05_CRABS_ref_db.md) and follow the instructions to create the vertebrate reference database using CRABS.

---
## References

Sample sequences from:
- Ballini, L., Staffoni, G., Nespoli, D. et al. Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. Hydrobiologia 852, 791–803 (2025). https://doi.org/10.1007/s10750-024-05723-y