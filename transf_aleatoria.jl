"""
Aplica uma transformacao na matriz de pontos baseado-se em uma matriz dada.

# Parametros
- `matriz_transf::Matrix{Float64}`: matriz que vai transformar a matriz de pontos.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function aleatoria(matriz_transf::Matrix{Float64}, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}
    
    # quantidade de pontos
    quant_pontos = size(matriz_pontos)[1]

    # novas coordenadas
    nova_matriz = zeros(size(matriz_pontos))

    # aplicando a transformacao nos vetores
    for i in 1:quant_pontos

        nova_matriz[1:2, i] = matriz_transf * matriz_pontos[1:2, i]

    end

    # retorna os vetores transformados
    return nova_matriz

end