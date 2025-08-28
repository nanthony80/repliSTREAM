# APSCALE-BLAST Taxonomic Assignment

This guide explains how to perform taxonomic assignment using APSCALE-BLAST for tele02 and vert01 markers on samples from Ballini et al. (2024).

---

## Overview

APSCALE-BLAST is a command-line tool within the APSCALE pipeline for taxonomic assignment of OTUs or ESVs.  
It uses BLAST+ (blastn) to match denoised sequence variants from metabarcoding datasets against curated or custom reference databases and outputs a filtered taxonomy table for downstream analysis.

---

## Requirements

- **BLAST+** must be installed and accessible in your system PATH.
- **APSCALE-BLAST** requires Python 3.10 or higher and can be installed via pip:
  ```
  pip install apscale_blast
  ```
- All dependencies and usage instructions are available at the [APSCALE-BLAST GitHub repository](https://github.com/TillMacher/apscale_blast).

---

## Workflow

1. **Prepare APSCALE BLAST databases**  
   Use the CRABS to APSCALE conversion script to generate APSCALE-compatible BLAST databases for each marker:
   ```bash
   python 09_CRABS_to_APSCALE.py
   ```

2. **Locate FASTA files for query sequences**  
   After running APSCALE, the denoised sequence FASTA files for each marker will be in:
   ```
   11_read_table/data/marker_sequences.fasta
   ```
   within each APSCALE project output directory (e.g., `tele02/11_read_table/data/marker_sequences.fasta`, `vert01/11_read_table/data/marker_sequences.fasta`).

3. **Run APSCALE-BLAST**
   - For **tele02**:
     ```bash
     apscale_blast \
       -db path/to/crabs_to_apscale_db_tele02 \
       -q tele02/11_read_table/data/marker_sequences.fasta
     ```
   - For **vert01**:
     ```bash
     apscale_blast \
       -db path/to/crabs_to_apscale_db_vert01 \
       -q vert01/11_read_table/data/marker_sequences.fasta
     ```
Note: update the -q path according to your own APSCALE project structure. Each marker will have its representative sequences FASTA inside the APSCALE 11_read_table/data/ directory.


4. **Outputs**
   - The main output is a `taxonomy.xlsx` file containing taxonomic assignments for each unique sequence.
   - This file is used together with the APSCALE read table for downstream analysis in TaxonTableTools2, which merges the taxonomy and read table to generate a final species table.

---

## Next Step

- Open[`12_ttt2.md`](12_ttt2.md) and follow the instructions for using TaxonTableTools2 to merge the read table and taxonomy table.

---

## References

- Ballini, L., Staffoni, G., Nespoli, D. et al. (2024) Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. *Hydrobiologia* 852, 791–803. https://doi.org/10.1007/s10750-024-05723-y
- Buchner, D., Macher, T. H., & Leese, F. (2022). APSCALE: advanced pipeline for simple yet comprehensive analyses of DNA metabarcoding data. Bioinformatics 38(20), 4817–4819. https://doi.org/10.1093/bioinformatics/btac588
- Camacho, C., Coulouris, G., Avagyan, V., Ma, N., Papadopoulos, J., Bealer, K., & Madden, T. L. (2009). BLAST+: Architecture and applications. BMC Bioinformatics, 10, 421. https://doi.org/10.1186/1471-2105-10-421
- [APSCALE GitHub repository](https://github.com/DominikBuchner/apscale)
- [APSCALE-BLAST GitHub repository](https://github.com/TillMacher/apscale_blast)

---