# Barque Analysis

This guide explains how to set up and run Barque for metabarcoding analysis on samples from the Ballini et al. (2024) study as part of the repliSTREAM pipeline.  
Refer to the [Barque GitHub repository](https://github.com/enormandeau/barque) and [STREAM settings](https://github.com/giorgiastaffoni/STREAM) for full details and the latest instructions.

---

## Overview

Barque analysis is performed in two steps for each marker:
1. **OTUs Creation** (`01_OTUs_creation`): Generates Operational Taxonomic Units (OTUs) from raw sequence data.
2. **OTUs Annotation** (`02_OTUs_annotation`): Annotates and assigns taxonomy to the OTUs.

The configuration and parameters follow those posted to [STREAM](https://github.com/giorgiastaffoni/STREAM).
Parameters for both runs were set in `02_info/barque_config.sh` and `02_info/primers.csv` and match those used in STREAM unless otherwise noted.

---

## Requirements

- Marker-specific reference databases (gzip format), placed in `03_databases/` of the cloned Barque repo
- Renamed FASTQ files from previous steps in the required format:
  ```
  SampleID_*_R1_001.fastq.gz
  SampleID_*_R2_001.fastq.gz
  ```
  (SampleID cannot contain underscores)
- Git installed and available in your PATH
- All Barque dependencies (see repo for details)
- Processed FASTQ files for each marker

---

## Setup Instructions

### 1. Clone Barque Repository

Navigate to your project directory and clone Barque:

```bash
git clone https://github.com/enormandeau/barque
```

#### Suggested Directory Structure

Create separate directories for each marker and run:

```bash
mkdir -p barque_vert01_01_OTUs_creation
mkdir -p barque_vert01_02_OTUs_annotation
mkdir -p barque_tele02_01_OTUs_creation
mkdir -p barque_tele02_02_OTUs_annotation

cp -r barque/* barque_vert01_01_OTUs_creation/
cp -r barque/* barque_vert01_02_OTUs_annotation/
cp -r barque/* barque_tele02_01_OTUs_creation/
cp -r barque/* barque_tele02_02_OTUs_annotation/

cp data/raw_reads/fastq_renamed/*Vert01*fastq.gz barque_vert01_01_OTUs_creation/04_data/
cp data/raw_reads/fastq_renamed/*Tele02*fastq.gz barque_tele02_01_OTUs_creation/04_data/
```

---

### 2. Install Dependencies

See [Barque repo instructions](https://github.com/enormandeau/barque) for details.

Recommended checks:

```bash
# Bash 4+
bash --version
# Python 3.5+
python3 --version
# R 3+
R --version
# Java
java -version
# GNU parallel
parallel --version
# FLASH v1.2.11+
flash --version
# VSEARCH v2.14.2+ (CRITICAL)
vsearch --version
```

---

## Running the Barque Pipeline

Each marker requires two runs:
1. From `01_OTUs_creation` directory for OTU creation
2. From `02_OTUs_annotation` directory for annotation

Launch from the relevant directory:

```bash
./barque 02_info/barque_config.sh
```

Refer to the Barque documentation for details on output files and formats.

---

## Downstream Analysis

After running Barque, proceed with downstream analysis (e.g. LULU, microDecon) for each marker as described in your workflow.

---

## BLAST Species Identification (if needed)

> **Note:** After review, this step was not necessary for this run.

If you need to identify frequent non-annotated sequences:
- Upload `most_frequent_non_annotated_sequences.fasta` to NCBI's BLASTn
- Download alignment results (e.g., `6X3V5KXV014-Alignment.txt`) for sequences found >10 times
- Use/modify the Barque script (`01_scripts/10_report_species_for_non_annotated_sequences.py`) to parse BLAST output and apply a 97% identity threshold

Example command:

```bash
python3 species_non_annotated_sequences.py \
    6X3V5KXV014-Alignment.txt \
    most_frequent_non_annotated_sequences_species_ncbi.csv 97 | \
    sort -u -k 2,3 | cut -c 2- | perl -pe 's/ /\t/' > missing_species_97_percent.txt
```

Outputs:
- `most_frequent_non_annotated_sequences_species_ncbi.csv`: Species names and sequence counts
- `missing_species_97_percent.txt`: Tab-delimited NCBI accession numbers for batch retrieval

---

## Skipped Database Depletion Step (`remove_species.py`)

Unlike Ballini et al. (2024), who removed “unwanted species” from the reference database using `remove_species.py`, we **skipped** this step for the following reasons:

- The original unwanted species list was not published.
- Our reference databases are independently curated and not directly comparable.
- Filtering without transparent criteria risks bias and reduces comparability.

Post-hoc filtering was only applied after taxonomic assignment, retaining species detections consistent with Ballini et al. (2024) or known to occur in the study area according to supplemental Table S1.

---

## Next Steps

Open [`07_lulu_barque.Rmd`](07_lulu_barque.Rmd) and run the script to perform LULU filtering for error reduction.
Open [`08_microdecon_barque.Rmd`](08_microdecon_barque.Rmd) and run the script to perform decontamination with microDecon.

---

## References

- [Barque GitHub repository](https://github.com/enormandeau/barque)
- [STREAM Barque settings](https://github.com/giorgiastaffoni/STREAM)
- Ballini, L., Staffoni, G., Nespoli, D. et al. Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. *Hydrobiologia* 852, 791–803 (2025). https://doi.org/10.1007/s10750-024-05723-y
