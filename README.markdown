# PIBIC Primeira Parte  
**Adaptação e Comparação de Algoritmos para o Problema de Roteamento de Veículos Utilizando Programação em Julia**

Este projeto tem como objetivo otimizar a execução de 100 instâncias do **VRP** (Vehicle Routing Problem), com foco no **SCCVRP** (Shared Customer Collaboration Vehicle Routing Problem). A automação proposta elimina a necessidade de extração manual de dados e permite a execução sequencial e eficiente de todas as instâncias em um único processo, gerando resultados organizados para análise comparativa de algoritmos.

---

## Estrutura do Projeto

```
├── data/                     # Arquivos de dados
│   ├── raw/                  # Dados brutos
│   │   └── SCCVRP-dat.rar    # Arquivo compactado com instâncias do SCCVRP
│   ├── processed/            # Dados processados
│   │   ├── modified/         # Dados adaptados para o modelo
│   │   └── results/          # Resultados das execuções
├── src/                      # Scripts do projeto
│   ├── main.jl               # Script principal para execução das instâncias
│   ├── utils.jl              # Funções auxiliares para manipulação de dados
│   ├── utils2.jl             # Funções adicionais de suporte
│   ├── data_filter.jl        # Funções para filtragem de dados
│   └── result_processor.jl   # Script para organizar resultados em Excel
├── .gitignore                # Arquivo para controle de versão
├── LICENSE                   # Licença do projeto (MPL 2.0)
└── README.md                 # Documentação do projeto
```

---

## Pré-requisitos

Certifique-se de que as seguintes ferramentas e dependências estão instaladas:

### Linguagem
- **Julia**: Versão 1.11.3 ou superior

### Solver
- **Gurobi**: Licença válida necessária

### Bibliotecas Julia
- `JuMP.jl`
- `Random.jl`
- `Gurobi.jl`
- `XLSX.jl`

### Outros
- **Git**: Para controle de versão
- Ferramenta para descompactar arquivos `.rar` (ex.: WinRAR, 7-Zip, ou unrar)

---

## Configuração do Projeto

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/RafaelCarvalheira/PIBICpt1.git
   cd PIBICpt1
   ```

2. **Instale as dependências no Julia**:
   ```julia
   using Pkg
   Pkg.add(["JuMP", "Random", "Gurobi", "XLSX"])
   ```

3. **Configure o solver Gurobi**:
   - Certifique-se de que a licença do Gurobi está ativa.
   - No Julia, execute:
     ```julia
     using Gurobi
     ENV["GUROBI_HOME"] = "caminho/para/gurobi"  # Ajuste conforme necessário
     ```

4. **Descompacte os dados**:
   - Extraia o arquivo `SCCVRP-dat.rar` para a pasta `data/raw/`.

---

## Como Usar

### 1. Executar as Instâncias
   - No Julia, execute o script principal para processar as instâncias do SCCVRP:
     ```julia
     include("src/main.jl")
     ```

### 2. Filtrar Dados
   - Pré-processe as instâncias usando o módulo de filtragem:
     ```julia
     include("src/data_filter.jl")
     using .DataFilter
     filtered_data = filter_instances(raw_data, min_nodes=10, max_nodes=100)
     ```

### 3. Organizar Resultados
   - Após a execução das instâncias, organize os resultados em um arquivo Excel categorizado:
     ```julia
     include("src/result_processor.jl")
     processar_pasta("data/processed/results", "dados_categorizados.xlsx")
     ```
   - **Descrição**: O script `result_processor.jl` lê arquivos `.txt` na pasta `data/processed/results/`, extrai informações como ID, número de clientes, custo, status, %Gap e tempo de execução, e organiza os dados em um arquivo Excel com abas separadas por categoria.

### 4. Resultados
   - Resultados brutos são salvos em `data/processed/results/` (arquivos `.txt`).
   - Dados filtrados são salvos em `data/processed/modified/`.
   - O arquivo Excel (`dados_categorizados.xlsx`) é gerado no diretório especificado, contendo os resultados organizados por categoria.

### 5. Análise
   - Use o arquivo Excel para comparar o desempenho de diferentes algoritmos aplicados ao SCCVRP. As abas categorizadas facilitam a análise de métricas como custo, tempo de execução e %Gap.

---

## Objetivos do Projeto

- **Automatização**: Sequenciar e executar 100 instâncias do SCCVRP de forma eficiente.
- **Comparação**: Avaliar o desempenho de diferentes algoritmos para o problema.
- **Escalabilidade**: Facilitar a inclusão de novas instâncias ou algoritmos no futuro.
- **Reprodutibilidade**: Garantir que os experimentos possam ser replicados com facilidade.
- **Organização**: Estruturar resultados em formato Excel para análise simplificada.

---

## Filtro de Dados

A funcionalidade de filtro de dados permite pré-processar as instâncias do SCCVRP, garantindo que apenas instâncias relevantes sejam utilizadas. Benefícios incluem:
- Redução do tempo de processamento.
- Foco em subconjuntos específicos de instâncias.
- Consistência nos dados de entrada.

### Como Funciona
O módulo `DataFilter` (em `src/data_filter.jl`) filtra instâncias com base em parâmetros como:
- Número mínimo e máximo de nós.
- Outros critérios personalizáveis (ex.: capacidade dos veículos, distância máxima).

### Uso
```julia
include("src/data_filter.jl")
using .DataFilter

# Exemplo: Filtrar instâncias com 10 a 100 nós
filtered_data = filter_instances(raw_data, min_nodes=10, max_nodes=100)
```

### Impacto
A filtragem otimiza o tempo de execução e facilita a análise. Dados filtrados são salvos em `data/processed/modified/`.

### Personalização
Modifique a função `filter_instances` em `src/data_filter.jl` para adicionar novos critérios de filtragem.

---

## Processamento de Resultados

A funcionalidade de processamento de resultados organiza os dados gerados pelas execuções do SCCVRP em um arquivo Excel estruturado, com abas separadas por categoria. Isso simplifica a análise comparativa de métricas como custo, tempo de execução e %Gap.

### Como Funciona
O script `result_processor.jl`:
- Lê arquivos `.txt` na pasta `data/processed/results/`.
- Extrai métricas: ID, número de clientes, custo (OF), status, %Gap, tempo de execução.
- Organiza os dados em um arquivo Excel, com uma aba para cada categoria (extraída do nome do arquivo, ex.: `outputCategoria.txt`).

### Uso
```julia
include("src/result_processor.jl")
processar_pasta("data/processed/results", "dados_categorizados.xlsx")
```

### Saída
- Um arquivo Excel (`dados_categorizados.xlsx`) com abas nomeadas por categoria.
- Cada aba contém colunas: ID, Número de Clientes, OF (Custo), Status, %Gap, Tempo de Execução (segundos).

### Personalização
Modifique `result_processor.jl` para adicionar novas métricas ou ajustar a lógica de categorização.

---

## Contribuição

1. Faça um fork do repositório.
2. Crie uma branch para suas alterações:
   ```bash
   git checkout -b minha-contribuicao
   ```
3. Commit suas mudanças:
   ```bash
   git commit -m "Descrição das alterações"
   ```
4. Envie para o repositório remoto:
   ```bash
   git push origin minha-contribuicao
   ```
5. Abra um Pull Request no GitHub.

---

## Licença

Este projeto está licenciado sob a **Mozilla Public License 2.0**. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## Contato

Para dúvidas ou sugestões, entre em contato com o mantenedor do projeto:
- **Rafael Carvalheira**: rafaelvargascar20@gmail.com