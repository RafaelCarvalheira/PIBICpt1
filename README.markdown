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
│   └── utils2.jl             # Funções adicionais de suporte
├── .gitignore                # Arquivo para controle de versão
├── LICENSE                   # Licença do projeto (MBL 2.0)
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
   Pkg.add(["JuMP", "Random", "Gurobi"])
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

1. **Executar as instâncias**:
   - No Julia, execute o script principal:
     ```julia
     include("src/main.jl")
     ```

2. **Resultados**:
   - Os resultados processados serão salvos em `data/processed/results/`.
   - Arquivos intermediários adaptados estarão em `data/processed/modified/`.

3. **Análise**:
   - Os resultados podem ser usados para comparar o desempenho de diferentes algoritmos aplicados ao SCCVRP.

---

## Objetivos do Projeto

- **Automatização**: Sequenciar e executar 100 instâncias do SCCVRP de forma eficiente.
- **Comparação**: Avaliar o desempenho de diferentes algoritmos para o problema.
- **Escalabilidade**: Facilitar a inclusão de novas instâncias ou algoritmos no futuro.
- **Reprodutibilidade**: Garantir que os experimentos possam ser replicados com facilidade.

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
