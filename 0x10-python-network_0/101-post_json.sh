#!/bin/bash

# Validate the JSON payload
function validate_json() {
    jq . "$1" > /dev/null 2>&1
    return $?
}

# Check if the number of arguments is correct
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 URL JSON_FILE"
    exit 1
fi

URL="$1"
JSON_FILE="$2"

# Validate the JSON payload
validate_json "$JSON_FILE"
if [ $? -ne 0 ]; then
    echo "Not a valid JSON"
    exit 1
fi

# Send the POST request with the JSON payload
curl -sX POST -H "Content-Type: application/json" -d @"$JSON_FILE" "$URL"
echo "Valid JSON"

