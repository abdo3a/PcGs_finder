# PcGs_finder
protein homologous finder


A simple shell script to apply pipeline employ jackhmmer protein search and eggNOG mapper to find a robust protein homologous within a big protein database. Finally, the selected protein screened for the domain architecture using hmmerscan. All results reported in a tab-delimited file.


#USAGE

PcGs_finder.sh output_dir iteration# query.fasta KOGID pfm_database_path eggnog_database_path
