#!/bin/bash
# handles file upload from upload.js on html page
# Runs the R script that processes the file
# got from ChatGPT 2025-03-12 16:30

UPLOAD_DIR="/tmp"
INPUT_FILE=$(mktemp --suffix=.csv)
OUTPUT_FILE=$(mktemp --suffix=.csv)

# Read and save the uploaded CSV file
while IFS="=" read -r name value; do
    if [[ "$name" == "column" ]]; then
        column_name=$(echo "$value" | tr -d '\r')
    fi
done < <(env | grep CONTENT_)

# Extract the uploaded file
cat > "$INPUT_FILE"

# Call R script to process the file
/usr/bin/Rscript /var/www/cgi-bin/process.r "$INPUT_FILE" "$OUTPUT_FILE" "$column_name"

# Send processed file as response
echo -e "Content-Type: text/csv"
echo -e "Content-Disposition: attachment; filename=processed.csv\n"
cat "$OUTPUT_FILE"

# Cleanup
rm -f "$INPUT_FILE" "$OUTPUT_FILE"
