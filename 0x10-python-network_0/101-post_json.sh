#!/bin/bash

endpoint="$1"
file="$2"

if ! jq . "$file" &> /dev/null; then
  echo "Not a valid JSON"
  exit 1
fi

curl -sX POST -H "Content-Type: application/json" -d @"$file" "$endpoint" | grep "Valid JSON" &> /dev/null

if [ $? -eq 0 ]; then
  echo "Valid JSON"
else
  echo "Not a valid JSON"
fi

