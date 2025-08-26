# 🧬repliSTREAM🐟

## Introduction

### Reproducibility and pipeline comparison using eDNA metabarcoding data from Italian freshwater rivers from Ballini et al. (2024).

repliSTREAM is a project aimed at reproducing and extending the environmental DNA (eDNA) metabarcoding analysis of Ballini et al. (2024), with emphasis on freshwater fish biodiversity. Although the original study also reported amphibians, birds, and mammals from its multi-marker approach, this project limits its scope to fish taxa as a learning exercise in replicating the core biodiversity results of the original study.

Using the publicly available dataset of eDNA samples from six rivers in northwestern Italy, amplified with two 12S rRNA markers (Tele02: Taberlet et al., 2018; Vert01: Riaz et al., 2011), repliSTREAM evaluates the reproducibility of the Barque (Mathon et al., 2021) command-line interface (CLI) pipeline and compares it with two alternatives: APSCALE-CLI (Buchner et al., 2022) and the GUI-based eDNA-Container App (Wheeler et al., 2024). Vertebrate reference database creation was performed using Creating Reference databases for Amplicon-Based Sequencing (CRABS) (Jeunen et al., 2023). Post-clustering curation and decontamination steps were performed with LULU (Frøslev et al., 2017) and microDecon (McKnight et al., 2019) to ensure error reduction and contamination control across pipelines. All scripts, instructions, and results are provided to enable full replication, cross-pipeline comparison, and visualization of fish community outputs, supporting transparent and reproducible research in eDNA metabarcoding.

This project is part of my personal learning journey in eDNA metabarcoding bioinformatics. I am not a professional researcher or bioinformatician, so errors or oversights may be present. Feedback and suggestions are welcome to help improve it.

---

## Pipelines Compared

| Pipeline | Description | Output Type |
|----------|-------------|-------------|
| **Barque > LULU > microDecon** | CLI pipeline used by Ballini et al. (2024); OTU-based; integrates Trimmomatic, FLASH, VSEARCH, and custom scripts. LULU and microDecon applied post-Barque. | **OTUs** |
| **APSCALE (LULU) > microDecon** | CLI pipeline integrating VSEARCH, cutadapt, and clustering/denoising steps. Produces both OTUs (clustering) and ESVs (UNOISE denoising). LULU built in; microDecon applied separately. | **OTUs + ESVs** |
| **eDNA-Container App > LULU > microDecon** | GUI pipeline built on QIIME2; uses cutadapt + DADA2 for denoising. Produces ASVs with taxonomy assignments. LULU and microDecon applied post-analysis. | **ASVs** |

**Note:**  
- **OTUs** = clustered sequences (similarity threshold, e.g. 97%).  
- **ESVs** = denoised exact sequence variants; APSCALE reports both OTUs and ESVs.  
- **ASVs** = amplicon sequence variants from DADA2; equivalent in concept to ESVs.  


---
## Bioinformatics Workflow

<img width="670" height="467" alt="bioinformatics_workflow" src="https://github.com/user-attachments/assets/84e7db44-1a45-40d0-9b4c-3a89cc79ea32" />

*Figure 1. Overview of the repliSTREAM workflow comparing Barque, APSCALE, and eDNA-Container App pipelines [created in BioRender.com](https://BioRender.com).*

---

## Notes

- Raw, demiltiplexed, paired-end Illumina data were obtained from [Ballini et al. (2024)](https://doi.org/10.1007/s10750-024-05723-y) and replication of the Barque>LULU>microDecon pipeline followed the original GitHub by [@giorgiastaffoni](https://github.com/giorgiastaffoni/STREAM) with some modifications.
- APSCALE and eDNA-Container App pipelines were configured with settings as similar as possible to Barque; any differences are noted in the relevant sections.
- For documentation and installation instructions, see:  
  - **Reference Database Creation**: [CRABS](https://github.com/gjeunen/reference_database_creator)  
  - **Pipelines**: [Barque](https://github.com/enormandeau/barque), [APSCALE](https://github.com/DominikBuchner/apscale), [eDNA-Container App](https://github.com/dwheelerau/edna-container)  
  - **Taxonomic Assignment for APSCALE**: [APSCALE-BLAST](https://github.com/TillMacher/apscale_blast), [TaxonTableTools2](https://github.com/TillMacher/TaxonTableTools2)
  - **Post-processing tools**: [LULU](https://github.com/tobiasgf/lulu), [microDecon](https://github.com/donaldtmcknight/microDecon)  

---
## Step-by-Step Workflow by Pipeline

### 1. Barque Pipeline

**Overview:**  
Replication of Barque > LULU > microDecon pipeline as used in Ballini et al. (2024), with modifications. Below are instructions with additional notes. Scripts available in the `scripts` folder of this repository.

**Steps:**  
1. **Data Download & Preparation**  
   - [Download sample files from the Sequence Read Archive (SRA)](instructions/01_fastq_download.md)
   - [Convert `.sra` files to paired-end `.fastq` files](instructions/02_convert_fastq.md)
   - [Run samples through quality control](instructions/03_qc_fastqc_multiqc.md)
   - [Rename sample files to Barque compatible format](instructions/04_rename_fastq.md)
2. **Reference Database Creation**  
   - [CRABS curation for 12S rRNA vertebrate reference database](instructions/05_CRABS_ref_db.md)
3. **Barque Analysis**  
   - [Setup and run Barque pipeline](instructions/06_barque.md)
4. **Post-Clustering Curation and Decontamination**  
   - [Apply LULU](scripts/07_lulu_barque.Rmd)
   - [Apply microDecon](scripts/08_microdecon_barque.Rmd)

---

### 2. APSCALE Pipeline

**Overview:**  
CLI pipeline run with settings matched to Barque where possible.

**Steps:**  
1. **APSCALE Analysis**  
   - [Run APSCALE pipeline](step04_apscale_pipeline.sh)
2. **Reference Database Conversion**  
   - [Convert CRABS database to APSCALE-BLAST compatible format](step04_apscale_pipeline.sh)
3. **Taxonomic Assignment & Table Merging**  
   - [APSCALE-BLAST assignment](step07_apscale_blast.md)
   - [Merge tables with TaxonTableTools2](step07_taxontabletools2.md)
4. **Decontamination**
   Note: LULU is integrated in APSCALE.
   - [Apply microDecon](step06_microdecon_apscale.sh)

---

### 3. eDNA-Container App Pipeline

**Overview:**  
GUI pipeline run with settings matched to Barque where possible.

**Steps:**  
1. **Data Preparation**  
   - [Rename sample files to eDNA-Container App-compatible format]](step01_data_download.md)
2. **Reference Database Conversion**  
   - [Convert CRABS database to QIIME2 format](step02_reference_db.md)
3. **eDNA-Container App Analysis**  
   - [Run eDNA-Container App pipeline](step05_edna_container_app.md)
4. **Post-Clustering Curation and Decontamination**  
   - [Apply LULU](step06_lulu_edna_container.sh)
   - [Apply microDecon](step06_microdecon_edna_container.sh)
  
---

### 4. Downstream Analyses & Results

**Overview:**  
Filter species tables and run diversity metrics, PERMANOVA and PERMDISP

**Steps:**
1. **Filtering Species Tables**  
   - [Filter ASV table for target species](step07_filter_edna_container.md)
2. **Downstream Analyses**  
   - [Diversity metrics, PERMANOVA, PERMDISP](step08_downstream_analyses.md)

---

## Acknowledgements

**Daniel Stratis**  
GitHub: [@dswede43](https://github.com/dswede43)

I am grateful to my project partner, Daniel Stratis, for his collaboration throughout this work, including identifying Ballini et al. (2024) as a suitable study for learning eDNA metabarcoding bioinformatics, supporting the curation of the CRABS reference database, advising on pipeline troubleshooting and analyses, and providing consistent feedback and encouragement along the way. His contributions were instrumental to the progress of this project and to my own learning journey.

---

## License
 
This project is for educational and research purposes. Original data belong to Ballini et al. (2024).

---

## References

- **Ballini, L., Staffoni, G., Nespoli, D., et al. (2025).** Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. *Hydrobiologia, 852,* 791–803. [https://doi.org/10.1007/s10750-024-05723-y](https://doi.org/10.1007/s10750-024-05723-y)
- **Buchner, D., Macher, T. H., & Leese, F. (2022).** APSCALE: advanced pipeline for simple yet comprehensive analyses of DNA metabarcoding data. *Bioinformatics* 38(20), 4817–4819. [https://doi.org/10.1093/bioinformatics/btac588](https://doi.org/10.1093/bioinformatics/btac588)
- **Frøslev, T. G., Kjøller, R., Bruun, H. H., Ejrnæs, R., Brunbjerg, A. K., Pietroni, C., & Hansen, A. J. (2017).** Algorithm for post-clustering curation of DNA amplicon data yields reliable biodiversity estimates. *Nature communications*, 8(1), 1188. https://doi.org/10.1038/s41467-017-01312-x
- **Jeunen, G. J., Dowle, E., Edgecombe, J., von Ammon, U., Gemmell, N. J., & Cross, H. (2023).** crabs-A software program to generate curated reference databases for metabarcoding sequencing data. *Molecular ecology resources*, 23(3), 725–738. https://doi.org/10.1111/1755-0998.13741
- **Mathon, L., Valentini, A., Guérin, P.-E., Normandeau, E., Noel, C., Lionnet, C., Boulanger, E., Thuiller, W., Bernatchez, L., Mouillot, D., Dejean, T., & Manel, S. (2021).** Benchmarking bioinformatic tools for fast and accurate eDNA metabarcoding species identification. *Molecular Ecology Resources, 21,* 2565–2579. [https://doi.org/10.1111/1755-0998.13430](https://doi.org/10.1111/1755-0998.13430)
- **McKnight, D. T., Huerlimann, R., Bower, D. S., Schwarzkopf, L., Alford, R. A., & Zenger, K. R. (2019).** microDecon: A highly accurate read-subtraction tool for the post-sequencing removal of contamination in metabarcoding studies. *Environmental DNA, 1*(1), 14–25. [https://doi.org/10.1002/edn3.11](https://doi.org/10.1002/edn3.11)
- **Riaz, T., Shehzad, W., Viari, A., Pompanon, F., Taberlet, P., & Coissac, E. (2011).** ecoPrimers: inference of new DNA barcode markers from whole genome sequence analysis. *Nucleic Acids Research, 39*(21), e145. [https://doi.org/10.1093/nar/gkr732](https://doi.org/10.1093/nar/gkr732)
- **Taberlet, P., Bonin, A., Zinger, L., & Coissac, É. (2018).** *Environmental DNA: For Biodiversity Research and Monitoring.* Oxford University Press. [https://doi.org/10.1093/oso/9780198767220.001.0001](https://doi.org/10.1093/oso/9780198767220.001.0001) 
- **Wheeler, D., Brancalion, L., Kawasaki, A., & Rourke, M. L. (2024).** The eDNA-Container App: A Simple-to-Use Cross-Platform Package for the Reproducible Analysis of eDNA Sequencing Data. *Applied Sciences*, 14(6), 2641. [https://doi.org/10.3390/app14062641](https://doi.org/10.3390/app14062641)

---
