#!/bin/bash

num_wrk=${1:-"4"}
col_nam=${2:-"link"}
fld_pth=${3:-"output"}

col_num=$(head -1 labelled_newscatcher_dataset.csv | tr ';' '\n' | nl | grep -w "${col_nam}" | tr -d " "| tr "\t" '\n' | head -1)


skipfirst=0

while read -r lin
do
 if [ $skipfirst -gt 1 ]
 then
    echo "$(echo "$lin" | cut -f $col_num -d';')"
  fi
  skipfirst=3

done < labelled_newscatcher_dataset.csv| parallel --progress -j $num_wrk wget -q {} -P "$fld_pth"
