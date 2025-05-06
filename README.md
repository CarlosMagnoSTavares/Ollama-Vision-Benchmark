# Ollama Model Comparison Tool

This tool automates the process of evaluating multiple Ollama models on the same image processing task. It runs each installed Ollama model against a target image and saves the results for comparison.

*Read this in other languages: [Português](README_PT.md)*

## Requirements

- [Ollama](https://ollama.com/) installed and running
- At least one model pulled in Ollama
- An image file for testing (default: `comprovante.jpg`)

## Installing Ollama

### Windows
1. Visit [Ollama's website](https://ollama.com/download) and download the Windows installer
2. Run the installer and follow the prompts
3. Ollama will run as a service in the background

### Linux
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### macOS
1. Visit [Ollama's website](https://ollama.com/download) and download the macOS app
2. Install the app by dragging it to your Applications folder
3. Launch Ollama from your Applications folder

## Pulling Models

Before running the script, you need to have at least one model available in Ollama. To pull a model:

```bash
# Pull a specific model (example: llama3)
ollama pull llama3

# List available models
ollama list
```

Popular models to try:
- `llama3` - General-purpose text model
- `llama3.2-vision` - For image analysis tasks
- `codellama` - Code-focused model
- `mistral` - Efficient language model

## Installation

1. Clone this repository or download the scripts
2. Make sure Ollama is installed and running
3. Ensure you have at least one model pulled in Ollama

## Usage

### Windows

1. Place your test image in the same directory as the script (default name: `comprovante.jpg`)
2. Open PowerShell and navigate to the directory containing the script
3. Run the script:

```powershell
powershell -File run_models.ps1
```

### Linux

1. Place your test image in the same directory as the script (default name: `comprovante.jpg`)
2. Make the script executable:

```bash
chmod +x run_models.sh
```

3. Run the script:

```bash
./run_models.sh
```

### macOS

1. Place your test image in the same directory as the script (default name: `comprovante.jpg`)
2. Make the script executable:

```bash
chmod +x run_models.sh
```

3. Run the script:

```bash
./run_models.sh
```

## How It Works

1. The script lists all models available in your Ollama installation
2. For each model, it:
   - Runs the model with a prompt to analyze the image
   - Saves the output to a file named `result_[model_name].comprovante.jpg.md`
   - Adds a brief delay between models to avoid system overload

## Customization

You can customize:

- The prompt used for analysis (edit the script)
- The target image (change the file path in the script)
- The output format (modify the output file path construction)

## Linux and macOS Script

Here's the Linux/macOS version of the script (`run_models.sh`):

```bash
#!/bin/bash

# List all Ollama models
models=$(ollama list | grep -E "^[a-zA-Z0-9]" | awk '{print $1}')

echo "Found models: $models"

for model in $models; do
    echo "Processing model: $model"
    outputFile="result_${model//:/\_}.comprovante.jpg.md"
    
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
```

## Troubleshooting

- **Error: model requires more system memory than is available**: Some models are too large for your system's RAM. Try using smaller models.
- **CUDA errors**: Related to GPU memory limitations. Try running smaller models or using CPU-only mode.
- **Connection errors**: Make sure Ollama is running and accessible.
- **Slow performance**: Vision models require significant processing power. Consider using quantized models (with q4/q5 in their name) for faster performance.

## License

MIT

## Contributing

Feel free to submit issues or pull requests to improve the scripts or documentation. 