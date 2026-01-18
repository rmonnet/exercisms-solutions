#!/usr/bin/env bash

twofer () {
  echo "One for ${1:-you}, one for me."
}

twofer "$1"

