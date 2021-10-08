#!/bin/bash

input=${1:-dataset.csv}
train_ratio=${2:-"0.7"}
first_ln=$(head -1 $input)
size=$(cat $input | wc -l)


touch train.csv
echo "$first_ln" > train.csv
train_size=$(awk "BEGIN {print int(($size - 1) * $train_ratio)}")
cat $input | awk -F ","  -v end="$train_size" 'NR>=2 && NR<=end { print }' >> train.csv

touch test.csv
echo "$first_ln" > test.csv
test_size=$(awk "BEGIN {print $train_size + 1}")
cat $input | awk -F "," -v start="$test_size" -v end="$size" 'NR>=start && NR<=end { print }' >> test.csv
