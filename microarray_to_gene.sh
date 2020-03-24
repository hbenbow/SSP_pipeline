#!/bin/bash

#$1 is path to input file (list of genes)
#$2 is the path to the microarray reference fasta file
#$3 is the path to the blast database (nucleotide)
FILES=$1/*
for file in $FILES
do
xargs samtools faidx $2 < $file > $file.gene
blastn -query $file.gene -db $3  -max_target_seqs 1 -max_hsps 3 -task blastn-short -outfmt 6 -out $file.blast
done
R CMD BATCH /home/hbenbow/ssp_pipeline/scripts/sort.R
FILES=$1/*_genes.txt
for file in $FILES
do
xargs samtools faidx $3 < $file > $file.fa
done

