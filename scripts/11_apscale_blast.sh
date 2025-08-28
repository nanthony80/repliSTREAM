#!/bin/bash
# Script to run APSCALE-BLAST taxonomic assignment for tele02 and vert01 markers

set -e

# Run CRABS-to-APSCALE database conversion (if not already done)
# For each marker, you should pass the correct arguments (check documentation for the script's usage)
python 09_CRABS_to_APSCALE.py --marker tele02 --output crabs_to_apscale_db_tele02
python 09_CRABS_to_APSCALE.py --marker vert01 --output crabs_to_apscale_db_vert01

# Run APSCALE-BLAST for tele02
apscale_blast \
  -db "$(pwd)/crabs_to_apscale_db_tele02" \
  -q "tele02/11_read_table/data/marker_sequences.fasta"

# Run APSCALE-BLAST for vert01
apscale_blast \
  -db "$(pwd)/crabs_to_apscale_db_vert01" \
  -q "vert01/11_read_table/data/marker_sequences.fasta"

echo "APSCALE-BLAST completed for both markers."