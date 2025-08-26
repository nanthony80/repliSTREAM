# FASTQ Download and Preparation

This guide walks you through downloading `.sra` files from Ballini et al. (2024), converting them to `.fastq`, and preparing them for analysis. All commands are executed via script files located in `scripts/`, and configuration files live in `config/`. 

---

## 1. Create Your Accession List

Before downloading raw reads, create a list of SRR accession numbers from Ballini et al. (2024).

**How to Get the SRR Accessions:**
1. Go to the study’s BioProject page  
   [https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1175355](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1175355)
2. Under **Project Data**, click **“SRA Experiments (88)”**
3. Click **“Send results to Run selector.”**
4. In the Run Selector page, click **“Accession List”** to download a `.txt` file.
5. Save as `config/SRR_Acc_List.txt` in your project.

---

## 2. Install SRA Toolkit

Install SRA Toolkit to use `prefetch` and `fasterq-dump`.

**macOS Example:**
```bash
tar -xvzf sratoolkit.current-mac64.tar.gz
sudo mv sratoolkit.* /usr/local/sratoolkit
export PATH="/usr/local/sratoolkit/bin:$PATH"
source ~/.bash_profile    # or source ~/.zshrc
```
**Verify installation:**
```bash
prefetch --version
fasterq-dump --version
```

---

## 3. Download SRA Files

Run the script from your project root:
```bash
bash scripts/01_fastq_download.sh
```
- SRA files saved to `data/raw_reads/`
- Errors logged to `logs/prefetch_errors.log`

**Verify downloads:**
```bash
find data/raw_reads -name "*.sra" | wc -l
cat logs/prefetch_errors.log
```

---

## Next Step

After downloading, move to [02_convert_fastq.md](02_convert_fastq.md) to convert `.sra` files to paired `.fastq`.

---

## References

Sample sequences from:
- Ballini, L., Staffoni, G., Nespoli, D. et al. Environmental DNA metabarcoding as an efficient tool to monitor freshwater systems in northwestern Italy. Hydrobiologia 852, 791–803 (2025). https://doi.org/10.1007/s10750-024-05723-y