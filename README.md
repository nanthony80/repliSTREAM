## Introduction

**Reproducibility and pipeline comparison using eDNA metabarcoding data from Italian freshwater rivers by Ballini et al. (2024).**

repliSTREAM is a project aimed at replicating and extending the environmental DNA (eDNA) metabarcoding analysis of Ballini et al. (2024), evaluating the reproducibility of their use of the command-line interface (CLI)-based Barque pipeline and comparing it with two other pipelines: APSCALE-CLI and the eDNA-Container App, a graphical user interface (GUI) pipeline. The publicly available dataset includes eDNA samples from six river systems in northwestern Italy, amplified with two 12S rRNA markers: tele02 and vert01. All scripts, instructions, and results provided here enable full replication, comparison, and visualization of pipeline outputs, facilitating transparent and reproducible research in eDNA metabarcoding.

---

### Citations  
Ballini, L., Staffoni, G., Nespoli, D. et al. Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. Hydrobiologia 852, 791–803 (2025). https://doi.org/10.1007/s10750-024-05723-y

Buchner, D., Macher, T. H., & Leese, F. (2022). APSCALE: advanced pipeline for simple yet comprehensive analyses of DNA metabarcoding data. Bioinformatics (Oxford, England), 38(20), 4817–4819. https://doi.org/10.1093/bioinformatics/btac588

Wheeler, D., Brancalion, L., Kawasaki, A., & Rourke, M. L. (2024). The eDNA-Container App: A Simple-to-Use Cross-Platform Package for the Reproducible Analysis of eDNA Sequencing Data. Applied Sciences, 14(6), 2641. https://doi.org/10.3390/app14062641


---

### Pipelines Compared

| Pipeline            | Description                                                                                 |
|---------------------|---------------------------------------------------------------------------------------------|
| Barque              | CLI pipeline for DNA metabarcoding originally used by Ballini et al. (2024); OTU-based; integrates Trimmomatic, FLASH, custom Python scripts, and VSEARCH. LULU and microDecon were run separately after Barque. |
| APSCALE + LULU      | CLI pipeline for DNA metabarcoding; OTU-based; integrates VSEARCH, cutadapt, and LULU. microDecon was run after APSCALE. |
| eDNA-Container App  | Graphical user interface (GUI) pipeline for DNA metabarcoding; ASV-based; runs on QIIME2. LULU and microDecon were run separately after the main analysis. |

---

### Notes

- All intermediate steps are documented for reproducibility.  
- Raw data were obtained from Ballini et al. (2024).  
- Curated reference database and naming conventions follow the original GitHub:  
  [https://github.com/giorgiastaffoni/STREAM](https://github.com/giorgiastaffoni/STREAM)

---

### Author  
**Nicole Anthony**  
GitHub: [@nanthony80](https://github.com/nanthony80)

---

### Acknowledgements
**Daniel Stratis**

GitHub: [@dswede43](https://github.com/dswede43)

---

### License  
This project is for educational and research purposes.  
See Ballini et al. (2024) for original data.
