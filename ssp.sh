#!/bin/bash
#this surveys length opf proteins and detects signal peptides
FILES=$1/*
mkdir $3
for file in $FILES
do
xargs samtools faidx $2 < $file > $file.protein
samtools faidx $file.protein
signalp -fasta $file.protein -format short
done
mv *.signalp5 $3
mv $1/*.protein* $3
cd $3
R CMD BATCH ../count_SSPs.R
