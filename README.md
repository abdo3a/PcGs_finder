# PcGs-finder
A computational pipeline to identify Polycomb-group proteins (PcGs) homologous.


A python script to apply pipeline employ jackhmmer protein search and eggNOG mapper to find a robust protein homologous within a big protein database. Finally, the selected protein screened for the domain architecture using hmmerscan. All results reported in a tab-delimited file.


#USAGE

./PcGs_finder.py -i input.fasta -o output folder -pg name of the taget subunit(ezh,suz12,esc,p55) -t # of threads (default=10)

#requirments

- PcGs-finder needs to download the domain data base (3.0 GB) and eggnog database(37.0 GB). to avoid downloading the databases everytime you using the pipline we recommend to use the same outfolder which the databases were downloaded for the first time.

- PcGs-finder uses python => 3 and the following librieries must be avaliable in your system.
1- pip3 install os-sys
2- pip3 install argparse
3- pip3 install biopython
4- pip3 install regex
5- pip3 install python-csv
6- pip3 install wget


- Also, the follwing softwares must be installed on your system.
1- HMMER: biosequence analysis using profile hidden Markov models
http://hmmer.org/
2- eggnog-mapper
https://github.com/eggnogdb/eggnog-mapper
3- Apache Subversion Binary Packages
apt-get install subversion
