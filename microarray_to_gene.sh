#!/bin/bash

blastn -query input.fa -db blastdb  max_target_seqs 1 -max_hsps 3 -task blastn-short -outfmt 6 -out out.filee
