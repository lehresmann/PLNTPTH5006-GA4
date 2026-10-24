#!/bin/bash
set -euo pipefail

# TrimGalore container
CONTAINER=oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4

# Placeholder variables
R1file="$1"
R2file="$2"
outdir="$3"

# Initial logging
echo "Starting script trimgalore.sh"
date
echo

# Create output directory
mkdir -p "$outdir"

# Run TrimGalore
apptainer exec "$CONTAINER" trim_galore --paired --fastqc "$R1file" "$R2file" --output_dir "$outdir"

# Final logging
echo
echo "Successfully finished script trimgalore.sh"
date