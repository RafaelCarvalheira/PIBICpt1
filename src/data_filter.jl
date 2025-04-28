using XLSX
using Base


# Function to load the file
function carregar_arquivo(file_path::String)
    return readlines(file_path)
end

# Function to extract a specific value from the file
function extrair_valor(dados::Vector{String}, chave::String, regex::Regex)
    for linha in dados
        if occursin(chave, linha)
            return parse(Float64, replace(linha, regex => ""))
        end
    end
    return missing
end

# Function to extract integer values
function extrair_inteiro(dados::Vector{String}, chave::String, regex::Regex)
    for linha in dados
        if occursin(chave, linha)
            return parse(Int, replace(linha, regex => ""))
        end
    end
    return missing
end

# Function to extract text values
function extrair_texto(dados::Vector{String}, chave::String, regex::Regex)
    for linha in dados
        if occursin(chave, linha)
            return strip(replace(linha, regex => ""))
        end
    end
    return missing
end

# Function to extract file category based on its name
function obter_categoria(nome_arquivo::String)
    resultado = match(r"output(\w+)"i, nome_arquivo)
    return resultado !== nothing ? resultado.captures[1] : "Desconhecido"
end


# Function to process files and organize them by category
function processar_pasta(pasta::String, arquivo_excel::String)
    arquivos_txt = filter(f -> endswith(f, ".txt"), readdir(pasta))
    categorias = Dict{String, Vector{Vector{Any}}}()
    
    for arquivo_txt in arquivos_txt
        dados = carregar_arquivo(joinpath(pasta, arquivo_txt))
        categoria = obter_categoria(arquivo_txt)

        id = extrair_inteiro(dados, "ID =", r"ID = |;")
        clientes = extrair_inteiro(dados, "Numero de clientes =", r"Numero de clientes = |;")
        custo = extrair_valor(dados, "OF (custo) =", r"OF \(custo\) = ")
        status = extrair_texto(dados, "status=", r"status= ")
        gap = extrair_valor(dados, "GAP =", r"GAP = |%")
        tempo_execucao = extrair_valor(dados, "Tempo de execução:", r"Tempo de execução: |segundos")
        
        push!(get!(categorias, categoria, []), [id, clientes, custo, status, gap, tempo_execucao])
    end

    XLSX.openxlsx(arquivo_excel, mode="w") do arquivo
        for (categoria, dados) in categorias
            sheet = XLSX.addsheet!(arquivo, categoria)
            sheet[1, :] = ["ID", "Numero de Clientes", "OF (Custo)", "Status", "%Gap", "Tempo de Execução (segundos)"]
            for (i, linha) in enumerate(dados)
                sheet[i + 1, :] = linha
            end
        end
    end
    println("Arquivo Excel criado com sucesso!")
end

# Folder containing text files
pasta_txts = "C:/Users/Rafael Carvalheira/Desktop/PIBIC_ORG/data/processed/resultados"
# Output Excel file name
arquivo_excel = "dados_categorizados.xlsx"
# Process the folder and create the categorized Excel file
processar_pasta(pasta_txts, arquivo_excel)
