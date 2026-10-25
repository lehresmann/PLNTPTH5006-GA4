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

### 10: Sonnet reviews your script

*Answer*: Your prompt: Review this shell script. List the 5 most important problems or improvements, most important first, with a one-sentence reason for each. Don’t change it yet.

*Answer*: Claude's suggestions, and for each, whether you agree, disagree,
or don't understand it, and why:

1) Claude says there is no usage or input logging. I do recognize now that the script I wrote does not explain its purpose (`# Usage: ...`). For no input logging, I don't think I agree because the script is specifically set up to accomodate any file as the input (e.g. using variables) rather than hard-coded specific file(s). That is, the script's inputs are specified in the command line when performing the bash command with options followed by arguments.

2) Claude suggested changes to the variable names to more conventional options like "r1_fastqc" rather than "R1file" like I have written (e.g. don't use uppercase). This makes sense to me and I agree that besides the capitalization conventions (which we did learn about in week 7 and I forgot), something like "R1file" for the variable might not be descriptive enough.

3) Claude says to have the script print/report the program version. Typically, we would have it echo the version at the end but the instructions for GA4 stated this was not required (automatically printed for TrimGalore). Ultimately, this was a choice on our part and not necessarily correct or incorrect.

4) Claude states there is no success/failure check for the trim_galore apptainer, specifically referencing that `set -e` would not work when you set up a pipeline. I am not sure this is correct as the safe settings apply to all following lines of script (that is why we place it at the top of the script). This includes a stop and error message if any command in the pipeline fails (`set -o pipeline`).

5) Claude states there is apparently a lack of descriptive error messages are outlined if too few arguments are passed (`set -u` in safe settings). I agree that stating "unbound variable" does not tell you exactly what happened but I don't think that it is entirely unhelpful as it does indicate specifically which variable (e.g. $2) that is causing the error and should be enough to know where to look back in the script. We have not learned about any other way to write a script that describes in greater detail what the error is.

*Answer*: Was anything wrong, or in conflict with the course's practices? Did Claude refer to your `CLAUDE.md` conventions? As noted above, the only thing that was intentionally left out of the trimgalore.sh was the version logging as indicated by the GA4 instructions. Otherwise, the Claude output does largely focus on the CLAUDE.md for the comments related to usage logging, variable naming conventions, and program version logging.In those cases, I did go against some of the things that were specified in CLAUDE.md.

*Answer*: The estimated cost of this conversation (from `/usage`): $0.1474

### 11: Opus reviews your script

*Answer*: The estimated cost of this conversation (from `/usage`): $0.2303

*Answer*: Which suggestions did only one of the two models make? Both models gave essentially the exsct same answers but in a slightly different order. Minor differences from Opus includes greater detail in how to "fix" the issues it detected. For example, it suggests `# Copy arguments to named variables` is better than `# Placeholder variables`. Sonnet did not give such suggestions and rather only pointed out what was wrong.

*Answer*: Did either model claim something that you know is wrong? The only thing that it perhaps did not catch or know is that TrimGalore prints the version at the very beginning. So it is correct that the version is not reported at the end (like the CLAUDE.md conventions state) but it is in fact reported elsewhere.

*Answer*: Did either model check its claims, for example by running commands? Neither Sonnet or Opus did for me.

*Answer*: Did Opus's review change your mind about any of your answers to question 10? No.

*Answer*: How did the costs compare? Which review would you trust more, and why? Was the difference worth the difference in cost? Overall, I appreciated the greater detail in the suggestions from Opus but I think that because they provided essentially the same suggestions, the Sonnet provided enough context (e.g. I knew to look at CLAUDE.md) to figure out what it was stating I change. Therefore, for me, the difference in price is not justified. However, for a more complicated ask, I might want a more thorough response such as from Opus.

### 12: Run the script with a non-existent file

```bash
# Your command: 
bash scripts/trimgalore.sh ../garrigos/fastq/S1_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore
```

The output of the command was:

```
Starting script trimgalore.sh
Sun Oct 25 03:00:10 PM EDT 2026

INFO:    Using cached SIF image
INFO:    gocryptfs not found, will not be able to use gocryptfs
Error: Input file not found: ../garrigos/fastq/S1_R1.fastq.gz
```

*Answer*: What happens, and at which point does the script stop? It correctly starts with the initial logging and presumably calls the correct apptainer but fails to find the input file and the script does not continue. That is, there is no output (I double-checked the results/trimgalore) other than an error message. 

### 13: Claude adds a check to your script

*Answer*: Your prompt: In scripts/trimgalore.sh, add a check in the script that both the input FASTQ files exist, and have it provide an informative error message if they don’t.

```bash
# Your command to test the updated script: 
bash scripts/trimgalore.sh ../garrigos/fastq/S1_R1.fastq.gz ../garrigos/fastq/S63_R2.fastq.gz results/trimgalore

# My command to also test the updated script to check if the R2 file does not exist
bash scripts/trimgalore.sh ../garrigos/fastq/S63_R1.fastq.gz ../garrigos/fastq/S1_R2.fastq.gz results/trimgalore
```

The output of the command was:

```
# Output to test the updated script:
Error: R1 FASTQ file not found: ../garrigos/fastq/S1_R1.fastq.gz

# Output to also test the updated script if the R2 file does not exist:
Error: R2 FASTQ file not found: ../garrigos/fastq/S1_R2.fastq.gz
```

*Answer*: Does it behave the way Claude claimed it would? Yes, before even attempting to initiate the script (e.g. before even initial logging) it checks that the inputs files exist. In the separate tests (above), neither S1_R1 or S1_R2 exist therefore all that is printed is the respective error as specified. In any case, if one or both of the inputs are not correct, the script will not continue.

*Answer*: Given what you saw in question 12, how useful is this check? It adds an extra detail that it is specifically the R1 or R2 FASTQ input file that is not found rather than just listing the non-existent path. 

### 14: Claude writes a loop

*Answer*: Your prompt: Write a loop that will run scripts/trimgalore.sh for the 7 samples whose IDs start with S6, with output dir results/trimgalore. I will run the loop from the GA4 dir. Only show me the loop. Don’t add it to a file, and don’t run it.

The loop that Claude wrote: for r1 in ../garrigos/fastq/S6*_R1.fastq.gz; do
    r2="${r1/_R1/_R2}"
    bash scripts/trimgalore.sh "$r1" "$r2" results/trimgalore
done

```bash
# Paste Claude's loop here
for r1 in ../garrigos/fastq/S6*_R1.fastq.gz; do
    r2="${r1/_R1/_R2}"
    bash scripts/trimgalore.sh "$r1" "$r2" results/trimgalore
done
```

*Answer*: Does it run the script once per sample? Yes

*Answer*: Does it get the correct R2 file for each R1 file? Yes

*Answer*: Does it only run for the 7 `S6` samples? Yes (`S6*_R1.fastq.gz` is globbing for samples starting with "S6"). 

*Answer*: Did you change the loop? If so, what did you change and why? I did not. At first I was a little confused on how it would only do the seven S6 samples and thought I had to change the loop but I realized that there were only seven anyways. So, what Claude gave me was accurate.

### 15: Test and run the loop

The loop with `echo`, to test it:

```bash
# Your loop:
echo "for r1 in ../garrigos/fastq/S6*_R1.fastq.gz; do
    r2="${r1/_R1/_R2}"
    bash scripts/trimgalore.sh "$r1" "$r2" results/trimgalore
done"
```

The output of the loop was:

```
for r1 in ../garrigos/fastq/S6*_R1.fastq.gz; do
    r2=../garrigos/fastq/S69_R2.fastq.gz
    bash scripts/trimgalore.sh ../garrigos/fastq/S69_R1.fastq.gz ../garrigos/fastq/S69_R2.fastq.gz results/trimgalore
done
```

```bash
# Your command(s) to check the output files:
ls results/trimgalore/
```

The output of the command(s) was:

```
S63_R1.fastq.gz_trimming_report.json  S66_R2.fastq.gz_trimming_report.json
S63_R1.fastq.gz_trimming_report.txt   S66_R2.fastq.gz_trimming_report.txt
S63_R1_val_1_fastqc.html              S66_R2_val_2_fastqc.html
S63_R1_val_1_fastqc.zip               S66_R2_val_2_fastqc.zip
S63_R1_val_1.fq.gz                    S66_R2_val_2.fq.gz
S63_R2.fastq.gz_trimming_report.json  S67_R1.fastq.gz_trimming_report.json
S63_R2.fastq.gz_trimming_report.txt   S67_R1.fastq.gz_trimming_report.txt
S63_R2_val_2_fastqc.html              S67_R1_val_1_fastqc.html
S63_R2_val_2_fastqc.zip               S67_R1_val_1_fastqc.zip
S63_R2_val_2.fq.gz                    S67_R1_val_1.fq.gz
S64_R1.fastq.gz_trimming_report.json  S67_R2.fastq.gz_trimming_report.json
S64_R1.fastq.gz_trimming_report.txt   S67_R2.fastq.gz_trimming_report.txt
S64_R1_val_1_fastqc.html              S67_R2_val_2_fastqc.html
S64_R1_val_1_fastqc.zip               S67_R2_val_2_fastqc.zip
S64_R1_val_1.fq.gz                    S67_R2_val_2.fq.gz
S64_R2.fastq.gz_trimming_report.json  S68_R1.fastq.gz_trimming_report.json
S64_R2.fastq.gz_trimming_report.txt   S68_R1.fastq.gz_trimming_report.txt
S64_R2_val_2_fastqc.html              S68_R1_val_1_fastqc.html
S64_R2_val_2_fastqc.zip               S68_R1_val_1_fastqc.zip
S64_R2_val_2.fq.gz                    S68_R1_val_1.fq.gz
S65_R1.fastq.gz_trimming_report.json  S68_R2.fastq.gz_trimming_report.json
S65_R1.fastq.gz_trimming_report.txt   S68_R2.fastq.gz_trimming_report.txt
S65_R1_val_1_fastqc.html              S68_R2_val_2_fastqc.html
S65_R1_val_1_fastqc.zip               S68_R2_val_2_fastqc.zip
S65_R1_val_1.fq.gz                    S68_R2_val_2.fq.gz
S65_R2.fastq.gz_trimming_report.json  S69_R1.fastq.gz_trimming_report.json
S65_R2.fastq.gz_trimming_report.txt   S69_R1.fastq.gz_trimming_report.txt
S65_R2_val_2_fastqc.html              S69_R1_val_1_fastqc.html
S65_R2_val_2_fastqc.zip               S69_R1_val_1_fastqc.zip
S65_R2_val_2.fq.gz                    S69_R1_val_1.fq.gz
S66_R1.fastq.gz_trimming_report.json  S69_R2.fastq.gz_trimming_report.json
S66_R1.fastq.gz_trimming_report.txt   S69_R2.fastq.gz_trimming_report.txt
S66_R1_val_1_fastqc.html              S69_R2_val_2_fastqc.html
S66_R1_val_1_fastqc.zip               S69_R2_val_2_fastqc.zip
S66_R1_val_1.fq.gz                    S69_R2_val_2.fq.gz
```

*Answer*: Are all 7 samples represented? Yes, I checked the results/trimgalore and all seven samples S63-S69 were represented.

### 16: A summary command

*Answer*: Your prompt: Write a simple command that prints the percentage of read pairs that TrimGalore removed for each sample, based on the output files in results/trimgalore. Use only basic commands like grep, cut, and for loops.

```bash
# The command you got from Claude:
for f in results/trimgalore/*_R1.fastq.gz_trimming_report.txt; do
  sample=$(basename "$f" _R1.fastq.gz_trimming_report.txt)
  pct=$(grep "shorter than the length cutoff" "$f" | cut -f2 | tr -d '()')
  echo "$sample: $pct"
done
```

The output of the command was:

```
S63: 37016 7.4%
S64: 16772 3.4%
S65: 9709 1.9%
S66: 18565 3.7%
S67: 8915 1.8%
S68: 12820 2.6%
S69: 24027 4.8%
```

*Answer*: Did the output look right? If not, what did you do? Yes, I confirmed that the values match what is listed in each file. In fact, the loop I got from Claude not only lists the percentage but also the total number of sequences removed.

*Answer*: Does the value for `S63` match your answer to question 7? Yes, it is 37016 total sequences or 7.4%.

*Answer*: In your own words, how does the command work? For each file in results/trimgalore/ that end with _R1.fastq.gz_trimming_report.txt:

1) list the sample number accomplished using `basename` which Claude explains to mean that the suffix for the file path is removed leaving just the sample number/name; 

2) then provide the percentage of reads removed using `grep` to specifically search for the line containing the phrase "shorter than the length cutoff", piped to cut at the tab separating the phrase and the values of interest (`cut -f2`), and piped to change the output by deleting the parentheses around the percentage value from the original text to report it cleanly. 

The two things used I did not know/did not learn in class found in this loop that I had to ask Claude to explain were `basename` and `tr -d '()'`.

### 17: Document your genAI use

### 18: Update your `CLAUDE.md`

*Answer*: What you added to `CLAUDE.md`, and why: I changed three things in CLAUDE.md based on the activity:

1) More detail in "Start scripts with `#!/bin/bash` and `set -euo pipefail` *which will stop and report an error if a command fails, a non-existent variable is referenced or if any command in a pipeline fails*"

2) Added "Before starting, check that the inputs  provided actually exist and provide an error as well as stop the script if one or more inputs do not exist"

3) Added "If descriptively named, lowercase variables are used such that the inputs are specified in the command line passed as arguments, any arguments that are passed are automatically assigned to variables according to their position in the command line"

These both address (e.g. would prevent in the future) comments made by Claude when asked suggest changes to trimgalore.sh. Both these new conventions would apply broadly to other future scripts as well. 

*Answer*: Did Claude follow the new instruction? Yes, I confirmed that this does change Claude output in a new conversation with the same prompt as question 10. Because I did not change the content in the script, it does still comment on the lack of usage comment, input reporting in the initial logging, and poor variable naming. A new comment it now makes is that the output directory should be validated in the event that `$3` is missing, although in that case it might not be correct because if that is not indicated in the command line the script would fail either way.

### 19: Reflection

I was pleasantly surprised at how well Claude did with writing new code. It feels like agentic AI has a lot more potential to create compared to chat AI, or at least it requires less work on the user end because it can "see" to your "working environment" for added context. Overall, it was able to produce code (e.g. loops) that performed as expected although in some cases it was potentially more complex than what we have learned in class. I think that is one important distinction to make when utilizing these genAI options is that it does not know what you do and don't know unless you explicitly ask it to use or not use certain things, but it sill may do its own thing. For example, in question 16 I asked for it to use simple commands and it did that but also used some that may be considered "simple" but ones we have not explicitly learned about in class yet and I had to look up/ask Claude to explain. So even if the code genAI makes does work, there should be some level of understanding of why or how. In some cases, it may be too advanced for an individual's current skill or knowleding and probably ill-advised to use it because you cannot properly evaluate its output. 

On the other hand, I felt that its ability to suggest changes to the script I already wrote in Part B was not particularly helpful. It could be that what I wrote just did not have many errors and it may be useful in other contexts but it seemed to get really caught up or nitpicking on minor details. Since I asked for five things to improve, it did what I asked but I assume that if my script actually had major problems, it would have picked up on those first.

------------------------------------------------------------------------

## Part D: Publish your repo on GitHub

### 20: Create a GitHub repository, push, and create an Issue
