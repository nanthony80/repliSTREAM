# Creating Reference Databases with CRABS

This guide explains how to build curated reference databases for the Vert01 and Tele02 markers using the CRABS pipeline for comparing samples from the Ballini et al. (2024) study.

---

## Prerequisites

1. **CRABS installed**  
   - Install CRABS following the [official instructions](https://github.com/gjeunen/reference_database_creator).
   - CRABS v0.1.7 was used for the repliSTREAM project becasue v0.1.8 cited in Ballini et al., 2024 was not available for download at the time this project was completed.
   - Ensure `crabs` is available in your terminal (`which crabs` should return a path).
2. **Sufficient disk space and internet connection**  
   - Downloads from NCBI/BOLD can be large.

---

## How to Run the Pipeline

1. **Edit the script if needed**  
   - Open `scripts/05_CRABS_ref_db.sh`.
   - Set `USER_EMAIL` to your email address for NCBI queries.
   - Edit paths according to your project structure.

2. **Make the script executable**  
   ```bash
   chmod +x scripts/05_CRABS_ref_db.sh
   ```

3. **Activate your environment**  
   Before running, activate your conda environment with all dependencies (e.g., `replistream`):
   ```bash
   conda activate replistream
   ```

4. **Run the pipeline**  
   ```bash
   cd scripts
   ./05_CRABS_ref_db.sh
   ```

---
## Notes
For Amphibia, Archelosauria, and Mammalia, the queries include `mitochondrion[filter]` to reduce download size and avoid repeated NCBI connection errors. Ballini et al. (2024) did not use these filters.

## Custom Scripts Used

This pipeline uses three custom Python scripts from Ballini et al., 2024 (see https://github.com/giorgiastaffoni/STREAM) at key steps. 

- `length-filtering.py`: Filters amplicons by length after in-silico PCR, producing `.filtered.fasta` files for each marker.
- `dbrefinement_strict.py`: Curates the taxonomy-assigned database, removing doubtful records (e.g., with 'cf.', 'aff.', 'sp.', or 'nr.') and standardizing hybrid names.
- `idt2barque.py`: Converts the final IDT-formatted FASTA to a Barque-friendly format for downstream applications.

Ensure these scripts are present in `scripts/` and are executable.

---

## What the Script Does

- **Downloads** mitochondrial 12S rRNA sequences (100–25000 bp) from NCBI and BOLD for vertebrates
- **Merges** all downloaded data
- **Performs in-silico PCR** for Vert01 and Tele02 markers
- **Filters amplicons by length** using a custom script
- **Aligns** and trims primer regions
- **Assigns taxonomy** to sequences
- **Curates** the taxonomy-assigned database using a custom script
- **Dereplicates** to keep unique sequences
- **Filters** by length, ambiguous bases, and environmental records
- **Exports** the final reference databases in FASTA format
- **Converts** the final FASTA to a Barque-friendly format using a custom script
- **Compresses** the final FASTA to a Barque-friendly gzip format

---

## Output

- Barque-friendly, compressed FASTA files for Vert01 and Tele02 in `ref_db/`
- Visualizations of diversity and amplicon length

---

## Troubleshooting

- If you see errors about missing files, check that all taxonomy files are present in `ref_db/`.
- If you get permission errors, ensure the script is executable.
- If downloads are slow or incomplete, try lowering the `--batchsize` parameter in the script or check your internet connection.
- The script uses filters to avoid downloading irrelevant or excessively long/short sequences.
- For CRABS-specific errors, consult the [CRABS documentation](https://github.com/gjeunen/reference_database_creator).

---

## Next Step

Open [`06_barque.md`](06_barque.md) and follow the instructions to run the Barque pipeline.

---

## References

If you use the CRABS pipeline, please cite the original authors:
- Jeunen, G. J., Dowle, E., Edgecombe, J., von Ammon, U., Gemmell, N. J., & Cross, H. (2023). crabs-A software program to generate curated reference databases for metabarcoding sequencing data. Molecular ecology resources, 23(3), 725–738. https://doi.org/10.1111/1755-0998.13741

CRABS pipeline script for repliSTREAM adapted from:
- https://github.com/giorgiastaffoni/STREAM

Sample sequences from:
- Ballini, L., Staffoni, G., Nespoli, D. et al. Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. Hydrobiologia 852, 791–803 (2025). https://doi.org/10.1007/s10750-024-05723-y