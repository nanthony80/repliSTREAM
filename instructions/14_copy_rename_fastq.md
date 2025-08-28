## Preparing FASTQ Files for the eDNA-Container App

To use the eDNA-Container App, your FASTQ files must be named in a format that removes all hyphens and underscores from the sample name portion, and only retains the read direction (_R1_001.fastq.gz or _R2_001.fastq.gz) at the end. The final filenames should look like this:

```
SRR31057074NAPCRposTele02_R1_001.fastq.gz
SRR31057074NAPCRposTele02_R2_001.fastq.gz
SRR31057076NERVIAr1Tele02_R1_001.fastq.gz
SRR31057076NERVIAr1Tele02_R2_001.fastq.gz
...
```
where **SAMPLENAME** is the original filename with all hyphens and underscores removed from the portion before `_R1_001.fastq.gz` or `_R2_001.fastq.gz`.

---

### Step-by-Step Instructions

1. **Create a destination directory for your samples:**

For Tele02 samples:
```bash
mkdir -p ~/edna_container_app/data/renamed_tele02
```
For Vert01 samples:
```bash
mkdir -p ~/edna_container_app/data/renamed_vert01
```

2. **Copy your FASTQ files into the new directory:**

For Tele02:
```bash
cp ~/eDNA_projects/repliSTREAM/data/raw_reads/fastq_renamed/tele02/*.fastq.gz ~/edna_container_app/data/renamed_tele02/
```
For Vert01:
```bash
cp ~/eDNA_projects/repliSTREAM/data/raw_reads/fastq_renamed/vert01/*.fastq.gz ~/edna_container_app/data/renamed_vert01/
```

3. **Rename your FASTQ files to the correct format:**

Run the following script inside your target directory (e.g., `~/edna_container_app/data/renamed_tele02`):

```bash
cd ~/edna_container_app/data/renamed_tele02  # Or renamed_vert01

for f in *.fastq.gz; do
  # Get the portion before _R1_001.fastq.gz or _R2_001.fastq.gz
  prefix=$(echo "$f" | sed -E 's/_R[12]_001\.fastq\.gz$//')
  # Remove all hyphens and underscores in the prefix
  samplename=$(echo "$prefix" | tr -d '-_')
  # Determine if file is R1 or R2
  if [[ "$f" == *_R1_001.fastq.gz ]]; then
    newname="${samplename}_R1_001.fastq.gz"
  elif [[ "$f" == *_R2_001.fastq.gz ]]; then
    newname="${samplename}_R2_001.fastq.gz"
  fi
  # Rename file
  mv "$f" "$newname"
done
```

After running this script, your files will match the required format for the eDNA-Container App.

4. **Confirm your files have been renamed:**

```bash
ls ~/edna_container_app/data/renamed_tele02/
ls ~/edna_container_app/data/renamed_vert01/
```

Your FASTQ files are now correctly named and ready for use with the eDNA-Container App.