#!/bin/bash
#SBATCH --time=20:00:00
#SBATCH --account=def-ibradbur
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=tonykess@gmail.com
#SBATCH --nodes=1
#SBATCH --mem=80G
#SBATCH --cpus-per-task=20
#SBATCH --kill-on-invalid=yes
#SBATCH --job-name=gatksparkmark

#ensure you are in your home directory - this script assumes starting in /home/user
#load variables
source WGSparams_Lump.txt

## Load software modules
module load java/1.8.0_192
#change directory and align all reads
cd $projdir/align

while read ind;
  do echo $ind\.bam ;
  $gatk MarkDuplicatesSpark \
  -I $ind.sorted.bam \
  -O $ind.dedup.bam \
  --remove-sequencing-duplicates
  --num-executors 8 \
  --executor-cores 12 \
  --verbosity OFF \
  ; done < $projdir/sets/Lumpfish_set4.txt
