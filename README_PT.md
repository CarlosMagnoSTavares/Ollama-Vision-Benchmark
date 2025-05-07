# Ferramenta de Comparação de Modelos Ollama

Esta ferramenta automatiza o processo de avaliação de múltiplos modelos Ollama na mesma tarefa de processamento de imagem. Ela executa cada modelo Ollama instalado em uma imagem alvo e salva os resultados para comparação.

*Leia isto em outros idiomas: [English](README.md)*

## Requisitos

- [Ollama](https://ollama.com/) instalado e em execução
- Pelo menos um modelo carregado no Ollama
- Um arquivo de imagem para teste (padrão: `comprovante.jpg`)

## Instalando o Ollama

### Windows
1. Visite o [site do Ollama](https://ollama.com/download) e baixe o instalador para Windows
2. Execute o instalador e siga as instruções
3. O Ollama será executado como um serviço em segundo plano

### Linux
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### macOS
1. Visite o [site do Ollama](https://ollama.com/download) e baixe o aplicativo para macOS
2. Instale o aplicativo arrastando-o para a pasta de Aplicativos
3. Inicie o Ollama a partir da pasta de Aplicativos

## Carregando Modelos

Antes de executar o script, você precisa ter pelo menos um modelo disponível no Ollama. Para carregar um modelo:

```bash
# Carregue um modelo específico (exemplo: llama3)
ollama pull llama3

# Liste os modelos disponíveis
ollama list
```

Modelos populares para testar:
- `llama3` - Modelo de texto para uso geral
- `llama3.2-vision` - Para tarefas de análise de imagem
- `codellama` - Modelo focado em código
- `mistral` - Modelo de linguagem eficiente

## Instalação

1. Clone este repositório ou baixe os scripts
2. Certifique-se de que o Ollama esteja instalado e em execução
3. Garanta que você tenha pelo menos um modelo carregado no Ollama

## Uso

### Windows

1. Coloque sua imagem de teste no mesmo diretório do script (nome padrão: `comprovante.jpg`)
2. Abra o PowerShell e navegue até o diretório contendo o script
3. Execute o script:

```powershell
powershell -File run_models.ps1
```

### Linux

1. Coloque sua imagem de teste no mesmo diretório do script (nome padrão: `comprovante.jpg`)
2. Torne o script executável:

```bash
chmod +x run_models.sh
```

3. Execute o script:

```bash
./run_models.sh
```

### macOS

1. Coloque sua imagem de teste no mesmo diretório do script (nome padrão: `comprovante.jpg`)
2. Torne o script executável:

```bash
chmod +x run_models.sh
```

3. Execute o script:

```bash
./run_models.sh
```

## Como Funciona

1. O script lista todos os modelos disponíveis na sua instalação do Ollama
2. Para cada modelo, ele:
   - Verifica se um arquivo de resultado já existe para o modelo (pula se existir)
   - Executa o modelo com um prompt para analisar a imagem
   - Salva a saída em um arquivo chamado `result_[nome_do_modelo].comprovante.jpg.md`
   - Adiciona um pequeno atraso entre os modelos para evitar sobrecarga do sistema

Isso permite que você execute o script várias vezes e processe apenas modelos que ainda não foram processados, como quando adicionar novos modelos à sua instalação do Ollama.

## Personalização

Você pode personalizar:

- O prompt usado para análise (edite o script)
- A imagem alvo (altere o caminho do arquivo no script)
- O formato de saída (modifique a construção do caminho do arquivo de saída)

## Script para Linux e macOS

Aqui está a versão do script para Linux/macOS (`run_models.sh`):

```bash
#!/bin/bash

# Lista todos os modelos Ollama
models=$(ollama list | grep -E "^[a-zA-Z0-9]" | awk '{print $1}')

echo "Modelos encontrados: $models"

for model in $models; do
    echo "Processando modelo: $model"
    outputFile="result_${model//:/\_}.comprovante.jpg.md"
    
    # Executa o modelo com o prompt e salva a saída
    command="ollama run $model \"Analise este arquivo e extraia o conteúdo do documento para um arquivo de texto markdown. Forneça apenas o resultado final sem explicações ou texto desnecessário $(realpath ./comprovante.jpg)\""
    
    # Executa o comando e captura a saída
    result=$(eval $command)
    
    # Salva o resultado em um arquivo
    echo "$result" > "$outputFile"
    
    echo "Saída salva em $outputFile"
    
    # Pequeno atraso para evitar sobrecarga do sistema
    sleep 2
done

echo "Todos os modelos foram processados."
```

## Solução de Problemas

- **Erro: o modelo requer mais memória do sistema do que está disponível**: Alguns modelos são muito grandes para a RAM do seu sistema. Tente usar modelos menores.
- **Erros CUDA**: Relacionados a limitações de memória da GPU. Tente executar modelos menores ou usar o modo somente CPU.
- **Erros de conexão**: Certifique-se de que o Ollama esteja em execução e acessível.
- **Desempenho lento**: Modelos de visão requerem poder de processamento significativo. Considere usar modelos quantizados (com q4/q5 em seus nomes) para um desempenho mais rápido.

## Licença

MIT

## Contribuindo

Sinta-se à vontade para enviar problemas ou pull requests para melhorar os scripts ou a documentação. 