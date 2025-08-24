# 🧬repliSTREAM🐟

## Introduction

### Reproducibility and pipeline comparison using eDNA metabarcoding data from Italian freshwater rivers from Ballini et al., 2024.

repliSTREAM is a project aimed at reproducing and extending the environmental DNA (eDNA) metabarcoding analysis of Ballini et al. (2024), with emphasis on freshwater fish biodiversity. Although the original study also reported amphibians, birds, and mammals from its multi-marker approach, this project limits its scope to fish taxa to directly replicate the core biodiversity results of the original study.

Using the publicly available dataset of eDNA samples from six rivers in northwestern Italy, amplified with two 12S rRNA markers (Tele02: Taberlet et al., 2018; Vert01: Riaz et al., 2011), repliSTREAM evaluates the reproducibility of the Barque command-line interface (CLI) pipeline and compares it with two alternatives: APSCALE-CLI and the GUI-based eDNA-Container App. All scripts, instructions, and results are provided to enable full replication, cross-pipeline comparison, and visualization of fish community outputs, supporting transparent and reproducible research in eDNA metabarcoding.

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

<img width="700" height="474" alt="Screenshot 2025-08-24 at 3 18 49 PM" src="https://github.com/user-attachments/assets/3cf472b0-9f3e-4f56-894a-abd68ca9f343" />

*Figure 1. Overview of the repliSTREAM workflow comparing Barque, APSCALE, and eDNA-Container App pipelines (created with BioRender.com).*

---

## Notes

- Raw data were obtained from Ballini et al. (2024).
- Barque pipeline followed the original GitHub:  
  [https://github.com/giorgiastaffoni/STREAM](https://github.com/giorgiastaffoni/STREAM)
- All intermediate steps are documented for reproducibility.

---

## Author

**Nicole Anthony**  
GitHub: [@nanthony80](https://github.com/nanthony80)

---

## Acknowledgements

**Daniel Stratis**  
GitHub: [@dswede43](https://github.com/dswede43)

I am grateful to my project partner, Daniel Stratis, for his collaboration throughout this work, including identifying Ballini et al. (2024) as a suitable study for learning eDNA metabarcoding bioinformatics, supporting the curation of the CRABS reference database, advising on pipeline troubleshooting and analyses, and providing consistent feedback and encouragement along the way.

---

## License
 
*This project is for educational and research purposes. Original data belong to Ballini et al. (2024).*

---

## References

- **Ballini, L., Staffoni, G., Nespoli, D., et al. (2025).** Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. *Hydrobiologia, 852,* 791–803. [https://doi.org/10.1007/s10750-024-05723-y](https://doi.org/10.1007/s10750-024-05723-y)
- **Buchner, D., Macher, T. H., & Leese, F. (2022).** APSCALE: advanced pipeline for simple yet comprehensive analyses of DNA metabarcoding data. *Bioinformatics* 38(20), 4817–4819. [https://doi.org/10.1093/bioinformatics/btac588](https://doi.org/10.1093/bioinformatics/btac588)
- **Riaz, T., Shehzad, W., Viari, A., Pompanon, F., Taberlet, P., & Coissac, E. (2011).** ecoPrimers: inference of new DNA barcode markers from whole genome sequence analysis. *Nucleic Acids Research, 39*(21), e145. [https://doi.org/10.1093/nar/gkr732](https://doi.org/10.1093/nar/gkr732)
- **Taberlet, P., Bonin, A., Zinger, L., & Coissac, É. (2018).** *Environmental DNA: For Biodiversity Research and Monitoring.* Oxford University Press. [https://doi.org/10.1093/oso/9780198767220.001.0001](https://doi.org/10.1093/oso/9780198767220.001.0001) 
- **Wheeler, D., Brancalion, L., Kawasaki, A., & Rourke, M. L. (2024).** The eDNA-Container App: A Simple-to-Use Cross-Platform Package for the Reproducible Analysis of eDNA Sequencing Data. *Applied Sciences*, 14(6), 2641. [https://doi.org/10.3390/app14062641](https://doi.org/10.3390/app14062641)

---
