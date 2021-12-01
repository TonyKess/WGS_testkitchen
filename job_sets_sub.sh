#!/bin/bash
#Quick job submission across setfiles 

#1 = number of setfiles
#2 = species or project prefix for setfiles
#3 = script to run

for i in {1..$1}; do
sbatch --export=ALL,set=$2\_set$i.txt $3 ; done
