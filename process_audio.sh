#!/bin/bash

# Check if the input file path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file_path>"
    exit 1
fi

input_file="$1"
output_file="$(dirname "$input_file")/output.wav"
output_text_file="$(pwd)/output.txt"

# Step 1: Convert the input file to the desired format
ffmpeg -i "$input_file" -ar 16000 -ac 1 -c:a pcm_s16le "$output_file"

# Step 2: Change the directory to /Users/nichlashansen/Documents/
cd /Users/nichlashansen/Documents/whisper.cpp/

# Step 3: Run the executable with the output file as an argument
./main -f "$output_file" > "$output_text_file"

# Step 4: Remove the first blank line from the output text file
sed -i '1{/^$/d;}' "$output_text_file"

# Step 5: Convert the cleaned output text to SRT format
function convert_txt_to_srt {
    local txt_file="$1"
    local lines=()
    IFS=$'\n' read -d '' -r -a lines < "$txt_file"

    local srt_file="${txt_file%.txt}.srt"
    local counter=1

    for line in "${lines[@]}"; do
        if [[ -n "$line" && "$line" != " "* ]]; then
            local timestamp="${line%%]*}"
            local text="${line#*]   }"
            echo "$counter"
            echo "$timestamp"
            echo "$text"
            echo
            ((counter++))
        fi
    done > "$srt_file"
}

convert_txt_to_srt "$output_text_file"

# Step 7: Change back to the original directory
cd -

echo "Output text saved to $output_text_file and converted to SRT."

