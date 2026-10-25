# Practice RNA-Seq project

Practice project for the course PLNTPTH 5006, using RNA-Seq data from
Garrigós et al. (2025) on *Culex pipiens* mosquitoes
infected with two avian *Plasmodium* species.

## Data

- The FASTQ files are in `../garrigos/fastq`:
  paired-end, ~75-bp Illumina reads for 22 samples,
  subsampled to 500,000 reads per file, with names like `S63_R1.fastq.gz`
- Sample metadata is in `../garrigos/meta/metadata.tsv`
- Never modify, move, or delete anything in `../garrigos`

## Dirs

- `scripts/`: shell scripts
- `results/`: all output, in a separate subdir for each step (e.g. `results/fastqc`)

## Software

- We work at the Ohio Supercomputer Center (OSC)
- Run programs with Apptainer containers from Seqera Containers (`oras://` URLs),
  not with `module load` or by installing them
- Don't use multi-threading options unless asked

## Shell script conventions

- Start scripts with `#!/bin/bash` and `set -euo pipefail` which will stop and report an error if a command fails, a non-existent variable is referenced or if any command in a pipeline fails
- Below that, add a comment block with the script's purpose and a usage line
  (e.g. `# Usage: bash scripts/fastqc.sh <FASTQ file> <output dir>`)
- Before starting, check that the inputs  provided actually exist and provide an error as well as stop the script if one or more inputs do not exist
- Copy arguments to descriptively named, lowercase variables (e.g. `fastq="$1"`);
  use uppercase only for constants (e.g. `CONTAINER=...`)
- If descriptively named, lowercase variables are used such that the inputs are specified in the command line passed as arguments, any arguments that are passed are automatically assigned to variables according to their position in the command line
- At the start, report the script name, the date, and the inputs;
  at the end, report the program version, a success message, and the date
- Create output dirs with `mkdir -p` before writing to them

## AI diary

- After completing a task, add an entry at the bottom of `doc/ai/ai-diary.md`
  with the date, what I asked for, which files you created or changed,
  and any key findings and decisions (including alternatives that were rejected)
- Keep entries short
