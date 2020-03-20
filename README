These scripts identify small secreted proteins from protein sequence data.
The script 'ssp.sh' takes lists of gene IDs, retrieves their sequence from a FASTA file, surverys their length and predicts the presence of a signal peptide.
The script then calls count_SSPs.R, which concatenates the data and provides tables and lists of SSPs.

Dependencies:
Samtools
SignalP V5
R

usage:
call the script using the following command with the positional arguments

bash ssp.sh 1 2 3

1 = path/to/directory that contains lists of gene ids (each one with an individual name)
2 = path/to/reference/protein/annotation.fasta that must contain all of the genes present in your lists
3 = the name of an output directory

both ssp.sh and count_SSPs.R must be present in the same directory, within which the directory assigned to '1' is enclosed.
Call the command from this where the scripts are. 
