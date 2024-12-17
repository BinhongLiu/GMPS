#!/bin/bash
FILE=`readlink -e $0`
rootdir=`dirname $FILE`

#----------------------------------------------------
# Default parameters
#----------------------------------------------------
app_path=$rootdir/Apps/
foldseek=$app_path/foldseek/bin/foldseek
usalign="$app_path/USalign/bin/USalign"
seqkit=$app_path/bin/seqkit

mkblastdb=$app_path/ncbi-blast-2.15.0+/bin/makeblastdb
blastp=$app_path/ncbi-blast-2.15.0+/bin/blastp
pdb2fasta=$app_path/bin/pdb2fasta
rg=$app_path/bin/rg

pymol=/usr/bin/pymol

data_path=$rootdir/database_final
n_model=20
tm_index=3
#tm_threshold=0.5
tm_threshold=0
print_help=0
work_dir="$rootdir/output"
keep_file=0
nhits_limit=-1


#----------------------------------------------------
# for test and debug
#----------------------------------------------------
Classification=Bacteria # Bacteria  Phage  ProPhage All
#Species=SpeciesTaxid_357276
Species=Bifidobacterium_adolescentis
input_pdb=$rootdir/example/3rbf.pdb

#----------------------------------------------------
# parse parameters
#----------------------------------------------------

POSITIONAL=()
while [[ $# -gt 0 ]]; do
 key="$1"
 case $key in
    -h|--help)
     print_help=1
     shift # past argument
     ;;
    -q|--query)
     input_pdb=($2)
     shift # past argument
     shift # past value
     ;;
    -o|--output)
     work_dir=($2)
     shift # past argument
     shift # past value
     ;;
    -c|--class)
     Classification="$2"
     shift # past argument
     shift # past value
     ;;
    -s|--species)
     Species=($2)
     shift # past argument
     shift # past value
     ;;
    --database-root)
     data_path="$2"
     shift # past argument
     shift # past value
     ;;
    --tm-threshold)
     tm_threshold=($2)
     shift # past argument
     shift # past value
     ;;
    --n-best-hits)
     n_model=($2)
     shift # past argument
     shift # past value
     ;;
    --sort-criterion)
     tm_index=($2)
     shift # past argument
     shift # past value
     ;;
    --foldseek)
     foldseek="$2"
     shift # past argument
     shift # past value
     ;;
    --hits-limit)
     nhits_limit="$2"
     shift # past argument
     shift # past value
     ;;
    --usalign)
     usalign="$2"
     shift # past argument
     shift # past value
     ;;
    --keep-intermediates)
     keep_file=1
     shift # past argument
     ;;
     *)
   POSITIONAL+=("$1") # save it in an array for later
     shift # past argument
     ;;
 esac
done

#----------------------------------------------------
# print help 
#----------------------------------------------------

help_info(){
    echo ""
    #echo 'Usage: DLDB_Search.sh -q query.pdb -c Bacteria -s SpeciesTaxid_357276 -o out'
    echo 'Usage: GMPS_Search.sh -q query.pdb -c Bacteria -s Bifidobacterium_adolescentis -o output'
    echo ""
    echo '            -q|--query            Give the query pdb file'
    echo ""
    echo '            -o|--output           Specify output path'
    echo ""
    echo "            -c|--class            Give the classification, should be one of"
    echo "                                  'All', 'Bacteria', 'Phages', or 'ProPhages'"
    echo ""
    echo '            -s|--species          Give the species name'
    echo ""
    echo "        optionally:"
    echo ""
    echo '            -h|--help             Print the help info'
    echo ""
    echo '            --database-root       The pathway of the database'
    echo ""
    echo '            --tm-threshold        The threshold for TMscore used by foldseek'
    echo "                                  (default is 0.4)"
    echo ""
    echo '            --n-best-hits         The number of best hits structures saved'
    echo "                                  (default is 3)"
    echo ""
    echo '            --sort-criterion      Criteria used to sort results from USalign:'
    echo "                                  '1' - TM1 (or qTMsocre)"
    echo "                                  '2' - TM2 (or tTMsocre)"
    echo "                                  '3' - default, min(TM1, TM2)"
    echo "                                  '4' - max(TM1, TM2)"
    echo "                                  '5' - mean(TM1, TM2)"
    echo "                                  '6' - smart mode, use min(TM1, TM2) first, "
    echo "                                        if no hits, turn to max(TM1, TM2)"
    echo ""
    echo "            --foldseek            The path to the executable file of foldseek"
    echo ""
    echo "            --usalign             The path to the executable file of USalign"
    echo ""
    echo "            --keep-intermediates  Do not delete intermediate files"
    echo ""
    exit 1
}

if [[ $print_help -eq 1 ]]; then
    help_info
fi

#----------------------------------------------------
# prepare 
#----------------------------------------------------

Species_path=$data_path/$Classification/$Species
pdb_path=$Species_path/pdb/

if [[ $Species == 'All' ]] && [[ $Classification == 'Bacteria' ]]; then
    csv_path=$Species_path/csv
    bacteria_all=1
else
    csv_path=$Species_path/
    bacteria_all=0
fi
csv_file=$Species_path/$Species.csv

foldseek_db=$Species_path/foldseek/fsDB
if [ ! -s "$foldseek_db" ];then
    curdir="$PWD"
    mkdir -p $Species_path/foldseek
    cd $Species_path/pdb
    $foldseek createdb *.pdb* $foldseek_db
    $foldseek createindex $foldseek_db $Species_path/tmp
    rm -rf $Species_path/tmp
    cd $curdir
fi

pdb_base=`basename $input_pdb`
query_base=`echo $pdb_base| sed "s/.pdb$//g"`

sub_foler=C_${Classification}_S_${Species}_Q_${query_base}
mkdir -p $work_dir
mkdir -p $work_dir/results
mkdir -p $work_dir/results/$sub_foler
cp $input_pdb $work_dir/results/$sub_foler
cd $work_dir/results/$sub_foler

#----------------------------------------------------
# do foldseek  
#----------------------------------------------------

format=query,target,fident,pident,alnlen,qcov,qlen,tcov,tlen,evalue,alntmscore,lddt,bits,prob

$foldseek easy-search $pdb_base $foldseek_db foldseek.out tmpFolder --exhaustive-search 1 --tmscore-threshold $tm_threshold --format-output $format

#----------------------------------------------------
# do usalign
#----------------------------------------------------

awk '{print $2}' foldseek.out > foldseek.hits
$usalign $pdb_base -dir2 $pdb_path foldseek.hits  -split 0 -outfmt 2 > usalign.out

#----------------------------------------------------
# give models of the best hits
#----------------------------------------------------

let tm_index=tm_index+1
grep "^#" -v usalign.out | awk '{print $3}' > TM1.out
grep "^#" -v usalign.out | awk '{print $4}' > TM2.out
paste TM1.out TM2.out | awk '{if ($1<$2) {print $1} else {print $2}}' > TMmin.out
paste TM1.out TM2.out | awk '{if ($1<$2) {print $2} else {print $1}}' > TMmax.out
paste TM1.out TM2.out | awk '{print ($1+$2)*0.5}' > TMmean.out
paste TM1.out TM2.out TMmin.out TMmax.out TMmean.out TMmin.out | nl > TMall.out
rm TM1.out TM2.out TMmin.out TMmax.out TMmean.out

cat TMall.out | sort -n -k $tm_index -r | awk '{if ($a>=0.5) {print $0}}' a=$tm_index > TMsort.out
n_hit=`cat TMsort.out | wc -l`

if [[ $n_hit -eq 0 ]] && [[ $tm_index -eq 7 ]]; then
    tm_index=5
    cat TMall.out | sort -n -k $tm_index -r | awk '{if ($a>=0.5) {print $0}}' a=$tm_index > TMsort.out
    n_hit=`cat TMsort.out | wc -l`
fi

head -n 1 usalign.out | sed 's/#//g' > usalign_hits.csv

touch pdb.list
rm pdb.list
mkdir -p best_hit_models
mkdir -p pymol_tmp

if [[ $n_hit -eq 0 ]]; then
    echo "no hit" >> usalign_hits.csv
else
    awk '{print $1}' TMsort.out > used_index.dat
    echo "rank" > rank.list
    ii=1
    for n in `cat used_index.dat`
    do
        grep "^#" -v usalign.out | head -n $n | tail -n 1  >> usalign_hits.csv
        echo "rank"$ii >> rank.list	
        pdb=`grep "^#" -v usalign.out | head -n $n | tail -n 1 | awk '{print $2}' | sed 's/\///g'`
	echo "$pdb" >> pdb.list
	let ii=ii+1
    done
    paste rank.list usalign_hits.csv | tr '\t' ',' > usalign_hits.csv_added
    mv usalign_hits.csv_added usalign_hits.csv
    

    if [[ $n_hit -lt $n_model ]]; then
        n_model=$n_hit
    fi
   
    touch top.fasta
    rm top.fasta 
    touch top.fasta
    for n in `head -n $n_model used_index.dat`
    do
        pdb=`grep "^#" -v usalign.out | head -n $n | tail -n 1 | awk '{print $2}' | sed 's/\///g'`
	cp $pdb_path/$pdb ./best_hit_models
	hit_base=`echo $pdb | sed 's/.pdb.gz//g'`
        $usalign $pdb_base $pdb_path/$pdb -o pymol_tmp/$hit_base
        $pymol -c -d @pymol_tmp/${hit_base}_all_atm.pml -g ./best_hit_models/$hit_base.png

	echo ">$hit_base" >> top.fasta
        $pdb2fasta $pdb_path/$pdb | tail -n 1 >> top.fasta
    done
fi

#----------------------------------------------------
# give models of the best hits
#----------------------------------------------------

header=`head -n 1  $csv_file`
echo 'rank,'$header > annotation.csv

ii=1
#for pdb in `cat pdb.list | sed "s/.pdb.gz$//g"`
for pdb in `cat pdb.list`
do

   if [[ $bacteria_all == 1 ]]; then
       startname=`echo $pdb | cut -c 1-3`

       if [[ $startname == 'AF-' ]]; then
           startname2=`echo $pdb | cut -c 1-6`
           if [[ $startname2 == 'AF-A0A' ]]; then
               used_name=`echo $pdb | cut -c 1-9`
           else
               used_name=`echo $pdb | cut -c 1-6`
           fi
       elif [[ $startname == 'Spe' ]]; then
           used_name=`echo $pdb | awk -F. '{print $1}'`
       fi
       csv_file=$csv_path/$used_name.csv
   fi

   $rg -N "$pdb" $csv_file > tmp_grep
   n_grep=`cat tmp_grep | wc -l`

   if [[ $n_grep == 0 ]]; then
       ann=$pdb
       echo 'rank'$ii,$ann >> annotation.csv
   else
       for i in `seq $n_grep`
       do
           ann=`head -n $i tmp_grep | tail -n 1` 
           echo 'rank'$ii,$ann >> annotation.csv
       done
   fi
   let ii=ii+1
   rm tmp_grep
done


#----------------------------------------------------
# organize results
#----------------------------------------------------

awk -F, '{print $2}' annotation.csv  | sed '1d' | sed 's/\"//g' > gene_id
$seqkit grep -f gene_id $data_path/final_all_protein.fasta > hits.fasta

$mkblastdb -in top.fasta -dbtype prot -out tmpFolder/hits.db
$pdb2fasta $pdb_base > $query_base.fasta
$blastp -query $query_base.fasta -out top_hits.ali  -outfmt 0 -db tmpFolder/hits.db -num_alignments $n_model  -evalue 1000000
$blastp -query $query_base.fasta -out top_hits.ali2 -db tmpFolder/hits.db -max_hsps 1 -evalue 1000000 -outfmt '6 nident qlen slen pident qcovs evalue' 

echo "identity,coverage,e-value" > sali.tmp
cat top_hits.ali2 | awk '{if ($2 > $3) {print $1/$2*100,$5,$6} else {print $1/$3*100,$5,$6}}' | sed 's/ /,/g' >> sali.tmp
cat top_hits.ali2
cat sali.tmp
paste usalign_hits.csv sali.tmp |  sed 's/\t/,/g' >> usalign_hits2.csv
mv usalign_hits2.csv usalign_hits.csv

mv top_hits.ali2 sali.tmp pymol_tmp pdb.list rank.list foldseek.hits foldseek.out usalign.out TMsort.out TMall.out used_index.dat gene_id gene_id_top tophits.fasta tmpFolder
if [[ $keep_file -eq 0 ]]; then
    rm -rf tmpFolder
fi
