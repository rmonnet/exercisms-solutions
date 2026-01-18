#!/usr/bin/env bash

strand1=$1
strand2=$2

if [ $# -lt 2 ]; then
  echo "Usage: hamming.sh <string1> <string2>"
  exit 1
fi

if [ ${#strand1} -ne ${#strand2} ]; then
  echo "strands must be of equal length"
  exit 1
fi

dist=0
for (( i=0; i<${#strand1}; i++ )); do
  if [ ${strand1:$i:1} != ${strand2:$i:1} ]; then
    dist=$(($dist + 1))
  fi
done

echo "$dist"
