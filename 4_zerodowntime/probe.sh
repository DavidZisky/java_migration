#!/usr/bin/env bash

URL=174.138.104.65:8080

while true
do
  time=$(date +'%r')
  echo "Probing app at $time:"
  curl $URL
  sleep 1
  echo ""
done
