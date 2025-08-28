# Convert CRABS Barque Databases to QIIME2 Format for eDNA-Container App

This guide explains how to convert final CRABS Barque reference databases to the QIIME2 classifier format for use in the eDNA-Container App pipeline.  

Use this after completing the Barque pipeline and before running QIIME2 analyses via the eDNA-Container App.

---

## Prerequisites

- **CRABS Barque FASTA files**: `07-tele02_barque.fasta.gz` and `07-vert01_barque.fasta.gz` in your `eDNA_container_app` directory
- **QIIME2 v2023.2** installed and activated  
  > **Note:** This pipeline requires QIIME2 version **2023.2**.  
  > **Later versions are incompatible with eDNA-Container App.**  
  > See [QIIME2 installation docs](https://docs.qiime2.org/)
- **UNIX tools**: `awk`, `sed`, `paste`, `grep`, `gunzip`

---

## eDNA-Container App Database Input

The eDNA-Container App requires the QIIME2 classifier files as its database input:  
- `tele02_classifier.qza`
- `vert01_classifier.qza`

---

## How to Run

From your project root:

```bash
bash scripts/06_CRABS_to_QIIME2.sh
```

---

## What the Script Does

1. **Unzips** each Barque FASTA file
2. **Deduplicates** FASTA headers
3. **Imports** FASTA as QIIME2 `FeatureData[Sequence]`
4. **Extracts** sequence IDs and builds a dummy taxonomy file
5. **Cleans** taxonomy file for QIIME2 import
6. **Imports** taxonomy as QIIME2 `FeatureData[Taxonomy]`
7. **Trains** a naive Bayes classifier for each marker using the imported reference and taxonomy

All outputs are written to `eDNA_container_app/`:

- `tele02_sequences.qza`
- `tele02_taxonomy.qza`
- `tele02_classifier.qza`
- `vert01_sequences.qza`
- `vert01_taxonomy.qza`
- `vert01_classifier.qza`

---

## Step-by-Step Example

1. Ensure both `07-tele02_barque.fasta.gz` and `07-vert01_barque.fasta.gz` are present in `eDNA_container_app/`.
2. Activate QIIME2 v2023.2:
   ```bash
   conda activate qiime2-2023.2
   ```
3. Run the script:
   ```bash
   bash scripts/06_CRABS_to_QIIME2.sh
   ```
4. Output files will be created in `eDNA_container_app/`.

---

## Troubleshooting

- **QIIME2 not found**: Activate your QIIME2 v2023.2 environment.
- **Missing FASTA files**: Make sure Barque pipeline has completed and `.fasta.gz` files are present.
- **File permissions**: If you get permission errors, check that you have write access to `eDNA_container_app/`.
- **Classifier warnings**: If your taxonomy files have missing or empty entries, check for correct FASTA formatting.

---

## References

- Ballini, L., Staffoni, G., Nespoli, D. et al. Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. Hydrobiologia 852, 791–803 (2025). https://doi.org/10.1007/s10750-024-05723-y
- Jeunen, G. J., Dowle, E., Edgecombe, J., von Ammon, U., Gemmell, N. J., & Cross, H. (2023). crabs-A software program to generate curated reference databases for metabarcoding sequencing data. Molecular ecology resources, 23(3), 725–738. https://doi.org/10.1111/1755-0998.13741
- Wheeler, D., Brancalion, L., Kawasaki, A., & Rourke, M. L. (2024). The eDNA-Container App: A Simple-to-Use Cross-Platform Package for the Reproducible Analysis of eDNA Sequencing Data. Applied Sciences, 14(6), 2641. https://doi.org/10.3390/app14062641
- QIIME2 documentation: https://docs.qiime2.org/
- CRABS documentation: https://github.com/gjeunen/reference_database_creator
