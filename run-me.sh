#!/bin/bash

# check if values are provided
if [ $# -eq 0 ]; then
    echo "Please provide one or more values as arguments."
    exit 1
fi

# loop through the values and run the commands for each value
for value in "$@"; do
    echo "Running commands for value: $value"
    
    # run python script to scrape fandom
    python ScrapeFandom.py "$value"

    # report successful scrape
    echo "Successful scrape of: $value"
    
    # run wikiextractor with necessary options
    wikiextractor "$value.xml" --no-templates -l --json -o "$value"

    # successful extraction
    echo "Successful wikiextraction of: $value"
    
    # run python script to convert json to text
    python json2jsonl.py ./"$value"/ "$value".jsonl
done
