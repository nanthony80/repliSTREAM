# repliSTREAM

## Introduction

**Reproducibility and pipeline comparison using eDNA metabarcoding data from Italian freshwater rivers by Ballini et al. (2024).**

repliSTREAM is a project aimed at reproducing and extending the environmental DNA (eDNA) metabarcoding analysis of Ballini et al. (2024), with emphasis on freshwater fish biodiversity. Although the original study also reported amphibians, birds, and mammals from its multi-marker approach, this project limits its scope to fish taxa to directly replicate the core biodiversity results of the original study.

Using the publicly available dataset of eDNA samples from six rivers in northwestern Italy, amplified with two 12S rRNA markers (Tele02: Taberlet et al., 2018; Vert01: Riaz et al., 2011), repliSTREAM evaluates the reproducibility of the Barque command-line interface (CLI) pipeline and compares it with two alternatives: APSCALE-CLI and the GUI-based eDNA-Container App. All scripts, instructions, and results are provided to enable full replication, cross-pipeline comparison, and visualization of fish community outputs, supporting transparent and reproducible research in eDNA metabarcoding.

---

## Citations

- **Ballini, L., Staffoni, G., Nespoli, D. et al.** Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. *Hydrobiologia* 852, 791–803 (2025). [https://doi.org/10.1007/s10750-024-05723-y](https://doi.org/10.1007/s10750-024-05723-y)
- **Buchner, D., Macher, T. H., & Leese, F. (2022).** APSCALE: advanced pipeline for simple yet comprehensive analyses of DNA metabarcoding data. *Bioinformatics* 38(20), 4817–4819. [https://doi.org/10.1093/bioinformatics/btac588](https://doi.org/10.1093/bioinformatics/btac588)
- **Wheeler, D., Brancalion, L., Kawasaki, A., & Rourke, M. L. (2024).** The eDNA-Container App: A Simple-to-Use Cross-Platform Package for the Reproducible Analysis of eDNA Sequencing Data. *Applied Sciences*, 14(6), 2641. [https://doi.org/10.3390/app14062641](https://doi.org/10.3390/app14062641)

---

## Pipelines Compared

| Pipeline                       | Description                                                                                 |
|--------------------------------|---------------------------------------------------------------------------------------------|
| **Barque>LULU>microDecon**              | CLI pipeline used by Ballini et al. (2024); OTU-based; integrates Trimmomatic, FLASH, VSEARCH, and custom scripts. LULU and microDecon applied post-Barque. |
| **APSCALE(LULU)>microDecon**      | CLI pipeline integrating VSEARCH, cutadapt, and clustering/denoising steps. Produces both OTUs (clustering) and ESVs (UNOISE denoising). LULU built in; microDecon applied separately. |
| **eDNA-Container App>LULU>microDecon**  | GUI pipeline built on QIIME2; uses cutadapt + DADA2 for denoising. Produces ASVs with taxonomy assignments. LULU and microDecon applied post-analysis. |

---
## Bioinformatics Workflow

<img width="576" height="380" alt="Screenshot 2025-08-22 at 6 43 49 PM" src="https://github.com/user-attachments/assets/da668b75-efcb-42c5-9817-6de3f037e41b" />

---

## Notes

- All intermediate steps are documented for reproducibility.
- Raw data were obtained from Ballini et al. (2024).
- Curated reference database and naming conventions follow the original GitHub:  
  [https://github.com/giorgiastaffoni/STREAM](https://github.com/giorgiastaffoni/STREAM)

---

## Author

**Nicole Anthony**  
GitHub: [@nanthony80](https://github.com/nanthony80)

---

## Acknowledgements

**Daniel Stratis**  
GitHub: [@dswede43](https://github.com/dswede43)

---

## License

This project is for educational and research purposes.  
See Ballini et al. (2024) for original data.
