# List all Ollama models
$models = Invoke-Expression "ollama list" | Select-String -Pattern "^[a-zA-Z0-9]" | ForEach-Object { $_.ToString().Split(" ")[0] }

Write-Host "Found models: $($models -join ', ')"

foreach ($model in $models) {
    Write-Host "Processing model: $model"
    $outputFile = "result_$($model.Replace(':', '_')).comprovante.jpg.md"
    
    try {
        # Run the model with the prompt and save output
       $command = "ollama run $model ""Analyze this file and extract the document content to a markdown text file. Provide only the final result without explanations or unnecessary text $(Resolve-Path ./comprovante.jpg)"""

        
        # Execute command and capture output
        $result = Invoke-Expression $command
        
        # Save the result to a file
        $result | Out-File -FilePath $outputFile -Encoding utf8
        
        Write-Host "Saved output to $outputFile"
    }
    catch {
        Write-Host "Error processing model $model`: $_"
    }
    
    # Small delay to avoid overloading the system
    Start-Sleep -Seconds 2
}

Write-Host "All models processed." 