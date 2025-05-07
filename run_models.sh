#!/bin/bash

# List all Ollama models
models=$(ollama list | grep -E "^[a-zA-Z0-9]" | awk '{print $1}')

echo "Found models: $models"

for model in $models; do
    echo "Processing model: $model"
    outputFile="result_${model//:/\_}.comprovante.jpg.md"
    
    # Check if output file already exists
    if [ -f "$outputFile" ]; then
        echo "Output file $outputFile already exists. Skipping model $model."
        continue
    fi
    
    # Run the model with the prompt and save output
    command="ollama run $model \"Analyze this file and extract the document content to a markdown text file. Provide only the final result without explanations or unnecessary text $(realpath ./comprovante.jpg)\""
    
    # Execute command and capture output
    result=$(eval $command)
    
    # Save the result to a file
    echo "$result" > "$outputFile"
    
    echo "Saved output to $outputFile"
    
    # Small delay to avoid overloading the system
    sleep 2
done

echo "All models processed." 