#!/bin/sh
#usage PcGs_finder.sh output_dir iteration# query.fasta KOGID pfm_database_path eggnog_database_path

mkdir $1

for i in `ls *.fasta`;
do
    sed -i 's/-/_/g;s/s/#/_/g;s/\./_/g;s/|/_/g;s/://g' $i
    fbname=$(basename "$i" .)
    fbname=${fbname%.fasta*}
    jackhmmer  --tblout $1/$fbname.jack --cpu 10 -N $2 --noali $3 $i;
done 

echo 'jackhmmer done'

for i in `ls $1/*.jack`;
do
   fbname=$(basename "$i" .)
   fbname=${fbname%.jack*}
   qid=$(grep '>' $3|sed 's/>//g;s/ .*//g')
   sed -n '/ target/,/ Program/p' $i|sed 's/-//g;s/#//g;s/ Program.*//g;s/target.*//g'|sed "s/$qid.*//g"|sed -r '/^\s*$/d'>> $1/$fbname.hits
   rm $i;
done 

echo 'parsing output done'


for i in `ls $1/*.hits`;
do
   fbname=$(basename "$i" .)
   fbname=${fbname%.hits*}
   xargs samtools faidx ./$fbname.fasta -o $1/$fbname.fa < $i
   rm $i;
done 

echo 'getting contigs done'


for i in `ls $1/*.fa`;
do
   fbname=$(basename "$i" .)
   fbname=${fbname%.fa*}
   emapper.py -m diamond --no_annot --no_file_comments --cpu 10 -i $i -o $1/$fbname
   emapper.py --annotate_hits_table $1/$fbname.emapper.seed_orthologs --data_dir $6 --no_file_comments  -o $1/$fbname --cpu 10
   rm $1/$fbname.emapper.seed_orthologs
   grep $4 $1/$fbname.emapper.annotations |cut -f1 >> $1/$fbname.egghits
   xargs samtools faidx $i -o $1/$fbname.faa < $1/$fbname.egghits
   rm $i;
done 

echo 'eggNOG done'

#wget ftp://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam32.0/Pfam-A.hmm.gz
#gunzip Pfam-A.hmm.gz
#hmmpress Pfam-A.hmm

for i in `ls $1/*.faa`;
do
   fbname=$(basename "$i" .)
   fbname=${fbname%.faa*}
   hmmscan --tblout $1/$fbname.pfam  --noali --cpu 10 $5 $i
   for f in `cat $1/$fbname.egghits`;
   do
      domain=$(grep $f $1/$fbname.pfam |sed 's/PF.*//g;s/           //g'| awk '{print}' ORS='|')
      printf "%s %s %s\n" "$fbname" "$f" "$domain" >> $1/$fbname.pfmhits;
    done;
done 


echo 'domain scan done'

rm *.fai
rm $1/*.fai
rm $1/*.egghits
rm $1/*.pfam
cat $1/*.pfmhits >> $1/report.tab
cat $1/*.faa >> $1/all_seq.faa
mkdir $1/annotations
mv $1/*.annotations $1/annotations/
