#!/usr/bin/env bash

message=$(echo "$1" | tr '[:lower:]' '[:upper:]')
acronym=""

IFS=' -_*' read -ra words <<< "$message"
for i in "${words[@]}"; do
  acronym="${acronym}${i:0:1}"
done

echo "$acronym"
