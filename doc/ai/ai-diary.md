# AI diary

## 2026-10-25

Asked Claude to add a check in `scripts/trimgalore.sh` that both input FASTQ
files exist, with an informative error message if not.

Files changed:
- `scripts/trimgalore.sh`: added existence checks for R1 and R2 FASTQ files
  right after argument assignment, exiting with an error message to stderr
  (exit code 1) if either file is missing.
