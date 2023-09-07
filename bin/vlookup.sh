#!/bin/bash
#vlookup
if [ $# -ne 2 ]
  then
    echo "File number supplied is not right"
    echo "Input File1 that have your info"
    echo "Input File2 you want to know"
fi
#awk 'NR==FNR{lee[$1]=$0;next}NR>FNR{if($1 in lee){print lee[$1]} else {print $0 "\t" "None"}}' $1 $2 >${2}.extracted
awk 'NR==FNR{lee[$1]=$0;lee[$2]=$s;next}NR>FNR{if($1 in lee){print $s "\t" lee[$1]} else {print $s "\t" $0 "\t" "None"}}' $1 $2 >${2}.extracted
#awk '$5~/hi/' A01_10103850__10416224_infiltrating_sumout.csv.extracted |awk '{sum+=$2}END{print "A01_10103850__10416224_infiltrating_sumout.csv.extracted" "\t" sum/NR}' >>sumout_AVE
#NR is the total row of file,which here refers file1
#FNR is the row number of specific file
#lee[1]=$0,is to create an array of $0(you want to extract)
#if $1 in file2 also in file1,print lee[1],you can also specific what you want to print, also the tab


