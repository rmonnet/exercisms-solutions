#!/usr/bin/env bash

twofer () {
  echo "One for ${name:-you}, one for me."
}

name="$1"
twofer

