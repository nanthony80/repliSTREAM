# APSCALE Analysis

This guide explains how to process eDNA metabarcoding samples from Ballini et al. (2024) using the APSCALE pipeline for taxonomic assignment with APSCALE-BLAST.  
Refer to the [APSCALE GitHub repository](https://github.com/DominikBuchner/apscale) and official documentation for installation and detailed usage instructions.

---

## Overview

APSCALE is an open-source pipeline for eDNA metabarcoding analysis.  
It automates steps including sequence merging, primer trimming, quality filtering, denoising, clustering, replicate merging, and negative control filtering.  
All pipeline steps are configured in a single Excel `Settings.xlsx` file and can be run individually or as a comprehensive workflow.

---

## Workflow

1. **Install APSCALE and dependencies**  
   Follow instructions in the [APSCALE GitHub repository](https://github.com/DominikBuchner/apscale).

2. **Create a project folder**  
   Initialize a new APSCALE project for each marker and copy the demultiplexed data in `.fastq.gz` format into the `02_demultiplaexing/data` directory.

3. **Configure pipeline settings in `Settings.xlsx`**  
   The following non-default settings were used for the repliSTREAM project. Non-default parameters were chosen to match as closely as possible the settings used in Barque by Ballini et al. (2024), including strict error filtering (maxEE=1), marker-specific length thresholds, and OTU clustering at 97% similarity (sequence group threshold=0.97).

---

### tele02 Marker Settings

**04_primer_trimming tab**
| P5 Primer (5'–3')            | P7 Primer (5'–3')           | anchoring |
|------------------------------|-----------------------------|-----------|
| AAACTCGTGCCAGCCACC           | GGTATCTAATCCCAGTTTG         | False     |

**05_quality_filtering tab**
| maxEE | min length | max length |
|-------|------------|------------|
| 1     | 109        | 229        |

**09_replicate_merging tab**
| perform replicate merging | replicate delimiter | minimum replicate presence |
|--------------------------|---------------------|---------------------------|
| FALSE                    | _                   | 2                         |

**10_nc_removal tab**
| perform nc removal | negative control prefix |
|--------------------|------------------------|
| FALSE              | NC_                    |

**11_read_table tab**
| generate read table | sequence group threshold |
|---------------------|-------------------------|
| True                | 0.97                    |

---

### vert01 Marker Settings

**04_primer_trimming tab**
| P5 Primer (5'–3')            | P7 Primer (5'–3')           | anchoring |
|------------------------------|-----------------------------|-----------|
| TTAGATACCCCACTATGC           | TAGAACAGGCTCCTCTAG          | False     |

**05_quality_filtering tab**
| min length | max length |
|------------|------------|
| 36         | 152        |

Other module settings for vert01 were identical to tele02.

---

4. **Run APSCALE**  
   Execute the pipeline using:
   ```bash
   apscale --run_apscale
   ```
   (See the APSCALE documentation for module-specific runs or troubleshooting.)

---

## Outputs

APSCALE will generate:
- Log files and project reports
- ESV/OTU tables for downstream analyses
- FASTA files for taxonomic assignment

These outputs are compatible with downstream tools such as BOLDigger3 and TaxonTableTools.

Downstream taxonomic assignment is performed with APSCALE-BLAST, which by default applies a species-level identity threshold of 98% (consistent with Ballini et al. 2024), along with genus- and family-level thresholds.

---

## Next Step

Open [`11_apscale_blast.md`](11_apscale_blast.md) and follow the instructions for performing taxonomic assignment with APSCALE-BLAST.

---

## References

- Ballini, L., Staffoni, G., Nespoli, D. et al. (2024) Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. *Hydrobiologia* 852, 791–803. https://doi.org/10.1007/s10750-024-05723-y
- Buchner, D., Macher, T. H., & Leese, F. (2022). APSCALE: advanced pipeline for simple yet comprehensive analyses of DNA metabarcoding data. Bioinformatics 38(20), 4817–4819. https://doi.org/10.1093/bioinformatics/btac588
- [APSCALE GitHub repository](https://github.com/DominikBuchner/apscale)

---