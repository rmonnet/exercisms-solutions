#!/usr/bin/env bash

res=""
if [ $(($1 % 3)) -eq 0 ]; then
  res="Pling"
fi

if [ $(($1 % 5)) -eq 0 ]; then
  res="${res}Plang"
fi

if [ $(($1 % 7)) -eq 0 ]; then
  res="${res}Plong"
fi

echo "${res:-$1}"
