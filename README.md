# GA4 answers - Lillian Ehresmann

------------------------------------------------------------------------

## Part A: Your project dir and Git repo

### 1: Create subdirs, and copy `CLAUDE.md` and a FastQC report

### 2: Initialize a Git repository, and commit your first files

------------------------------------------------------------------------

## Part B: A TrimGalore script --- without genAI

### 3: A TrimGalore container, its help info, and three options

*Answer*: The container link (URI) is:

Code to run `trim_galore --help` with the container:

```bash
# Your command:
apptainer exec oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4 trim_galore --help
```

*Answer*: The option to indicate that the reads are paired-end: --paired 

*Answer*: The option to set the output dir: -o or --output_dir 

*Answer*: The option to run FastQC on the trimmed FASTQ files: --fastqc

### 4: Default thresholds

*Answer*: A) The default base quality score threshold: 20

*Answer*: B) The default read length threshold: 20 

### 5: Write the `trimgalore.sh` script

### 6: Run the script for sample `S63`, and check the output files

Code to run the script:

```bash
# Your command:
bash scripts/trimgalore.sh ../garrigos/fastq/S63_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore
```

Code to list the output files:

```bash
# Your command:
ls results/trimgalore/
```

The output of the command was:

```
S63_R1.fastq.gz_trimming_report.json  S63_R2.fastq.gz_trimming_report.json
S63_R1.fastq.gz_trimming_report.txt   S63_R2.fastq.gz_trimming_report.txt
S63_R1_val_1_fastqc.html              S63_R2_val_2_fastqc.html
S63_R1_val_1_fastqc.zip               S63_R2_val_2_fastqc.zip
S63_R1_val_1.fq.gz                    S63_R2_val_2.fq.gz
```

*Answer*: What each type of output file contains: For each input file, there was two types of text files, .json and .txt, of TrimGalore reports as well as an .html file for the FastQC. Additionally, the compressed files for the validated reads. 

### 7: Trimming results

*Answer*: Which adapter sequence TrimGalore looked for, and how it decided on this: It used 'AGATCGGAAGAGC' for both reads. This is autodetected by TrimGalore if not specified. This specific one is for the Illumina universal adapter. TrimGalore `--help` states that this is "the auto-detect fallback".

*Answer*: Percentage of reads with adapters in R1 and R2: 13% and 10.1%, respectively.

*Answer*: In R1 and R2, were more bases removed by quality trimming or by adapter trimming? It looks like for both R1 and R2, more reads were removed by adapter trimming. 

*Answer*: Percentage of read pairs that were removed: 7.4%

### 8: Poly-G trimming

*Answer*: Did TrimGalore do poly-G trimming, and did you have to tell it to? Yes, this is performed as a default if it is detected by TrimGalore.

*Answer*: What TrimGalore concludes about the sequencing technology: It assumes that the data came from Illumina NextSeq or NovaSeq platforms (two-color chemistry).

*Answer*: Was more poly-G trimming done in R1 or R2? (Optional: any idea why?) There was more poly-G trimming in R2, with 2.4% and 8.7% in R1 and R2, respectively.

### 9: Compare the FastQC reports before and after trimming

*Answer*: At least two differences between the reports, and whether things look better in terms of pass/warn/fail status: Yes, the trimming increased the number of passing parameters. Specifically, per base N content and overrepresented sequences are now passing compared to the raw results. You can also see that the total sequences is lower in the trimmed results (500,000 vs 462,984; the difference is the same as the amount of sequences trimmed) and, accordingly, the number of total bases was also lower (35.4 Mbp vs 33.7 Mbp). The per base sequence quality looks better after trimming as well. 

*Answer*: Were the short reads with only `N`s removed? Yes, in the raw results the reads with `N`s were reported as overrepresented but that was not the case for the trimmed results. 
If so, was that due to the length threshold, or something else? There does appear to be an option for having removed sequences due to too many N bases but that percentage is 0. The sequences with `N` were 35 bp and the default threshold is 20. Therefore, I assume that they were quality trimmed as they likely have Phred less than 20. Accordingly, the per base N content passed for the trimmed results compared to a flag on the raw results.

*Answer*: Something you didn't expect or are confused about:  I would have assumed that it would be a higher percentage for the raw results since they had not been trimmed but the adapter content did not change (e.g. both figures show 0% adapter content).

------------------------------------------------------------------------

## Part C: Bring in genAI

<!-- Export the conversations for questions 10, 11, 13, and 14 to `doc/ai`. -->

### 10: Sonnet reviews your script

*Answer*: Your prompt:

*Answer*: Claude's suggestions, and for each, whether you agree, disagree,
or don't understand it, and why:

*Answer*: Was anything wrong, or in conflict with the course's practices?
Did Claude refer to your `CLAUDE.md` conventions?

*Answer*: The estimated cost of this conversation (from `/usage`):

### 11: Opus reviews your script

*Answer*: The estimated cost of this conversation (from `/usage`):

*Answer*: Which suggestions did only one of the two models make?

*Answer*: Did either model claim something that you know is wrong?

*Answer*: Did either model check its claims, for example by running commands?

*Answer*: Did Opus's review change your mind about any of your answers to question 10?

*Answer*: How did the costs compare? Which review would you trust more, and why?
Was the difference worth the difference in cost?

### 12: Run the script with a non-existent file

```bash
# Your command:
```

The output of the command was:

```
```

*Answer*: What happens, and at which point does the script stop?

### 13: Claude adds a check to your script

*Answer*: Your prompt:

```bash
# Your command to test the updated script:
```

The output of the command was:

```
```

*Answer*: Does it behave the way Claude claimed it would?

*Answer*: Given what you saw in question 12, how useful is this check?

### 14: Claude writes a loop

*Answer*: Your prompt:

The loop that Claude wrote:

```bash
# Paste Claude's loop here
```

*Answer*: Does it run the script once per sample?

*Answer*: Does it get the correct R2 file for each R1 file?

*Answer*: Does it only run for the 7 `S6` samples?

*Answer*: Did you change the loop? If so, what did you change and why?

### 15: Test and run the loop

The loop with `echo`, to test it:

```bash
# Your loop:
```

The output of the loop was:

```
```

<!-- You don't need to paste the output of the loop that ran TrimGalore -->

```bash
# Your command(s) to check the output files:
```

The output of the command(s) was:

```
```

*Answer*: Are all 7 samples represented?

### 16: A summary command

*Answer*: Your prompt:

```bash
# The command you got from Claude:
```

The output of the command was:

```
```

*Answer*: Did the output look right? If not, what did you do?

*Answer*: Does the value for `S63` match your answer to question 7?

*Answer*: In your own words, how does the command work?

### 17: Document your genAI use

<!-- No command/output needed here -- we check your `doc/ai` dir in the repo directly. -->

### 18: Update your `CLAUDE.md`

*Answer*: What you added to `CLAUDE.md`, and why:

*Answer*: Did Claude follow the new instruction?

### 19: Reflection

*Answer*:

------------------------------------------------------------------------

## Part D: Publish your repo on GitHub

### 20: Create a GitHub repository, push, and create an Issue

<!-- No command/output needed here -- we check your GitHub repo directly. -->
