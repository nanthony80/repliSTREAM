# Running the eDNA-Container App

This guide will walk you through running the eDNA-Container App for metabarcoding analysis. For full details, refer to the instructions at [@dwheelerau/edna-container](https://github.com/dwheelerau/edna-container).

## Prerequisites

- **Docker** must be installed and running on your computer.
- Your FASTQ files must be renamed and stored in a folder (see previous instructions). Files should follow the eDNA-Container App naming convention (e.g., `SAMPLENAME_R1_001.fastq.gz`, `SAMPLENAME_R2_001.fastq.gz`).  
  *There should be exactly 88 files per run (44 R1 and 44 R2 pairs).*

---

## Step-by-Step Instructions

### 1. Launch the eDNA-Container App

- Follow the launch instructions at [@dwheelerau/edna-container](https://github.com/dwheelerau/edna-container).
- Start the app using Docker as described in the repository documentation.

### 2. Select Input Files

- In the app, select the folder containing your renamed FASTQ files.
- **Important:** Files should be named in the eDNA-Container App compatible format, as described above.

### 3. Configure Pipeline Settings

- Run each marker separately (e.g., Tele02 and Vert01).
- Enter the forward and reverse primer sequences for each respective marker in the "Primer information" field.

#### DADA2 Settings (default):

| Setting          | Value      |
|------------------|-----------|
| trunc-len-f      | 0         |
| trunc-len-r      | 0         |
| max-ee-f         | 2         |
| max-ee-r         | 4         |
| trunc-q          | 2         |
| chimera-method   | consensus |

- Select the `marker_classifier.qza` file for the reference database. This file was created in a previous step using the 15_CRABS_to_QIIME2.sh script.

### 4. Run the Pipeline

- Click **"Run pipeline!"**
- The analysis will take several minutes to complete.

---

## Output Files

After the pipeline has completed, you will find your results in the `final_results/asvs/` directory. The key outputs are:

- `asv_count_tax_seqs.csv`: ASV table with counts and taxonomy.
- `dna-sequences.fasta`: Representative sequences for ASVs.

---

## Preparing Files for LULU

Copy the following files from the eDNA-Container App output (`final_results/asvs/`) into a new directory called `lulu/`, renaming them as follows:

- For **Tele02** marker:
  - `asv_count_tax_seqs.csv` → `tele02_asv_count_tax_seqs.csv`
- For **Vert01** marker:
  - `asv_count_tax_seqs.csv` → `vert01_asv_count_tax_seqs.csv`

Example commands:
```bash
mkdir -p lulu
cp final_results/asvs/asv_count_tax_seqs.csv lulu/tele02_asv_count_tax_seqs.csv
```

Repeat for each marker.

---

Your ASV tables are now ready for input into the next analysis step (LULU).

---

## Next Steps

Open [`17_lulu_edna_container_app.Rmd`](17_lulu_edna_container_app.Rmd) and run the script to perform LULU filtering for error reduction.
Open [`18_microdecon_edna_container_app.Rmd`](18_microdecon_edna_container_app.Rmd) and run the script to perform decontamination with microDecon.

---

## References

- Wheeler, D., Brancalion, L., Kawasaki, A., & Rourke, M. L. (2024). The eDNA-Container App: A Simple-to-Use Cross-Platform Package for the Reproducible Analysis of eDNA Sequencing Data. Applied Sciences, 14(6), 2641. https://doi.org/10.3390/app14062641
- eDNA-Container App documentation: https://github.com/dwheelerau/edna-container