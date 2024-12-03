"""
Aplica uma transformacao na matriz de pontos baseado-se em uma matriz dada.

# Parametros
- `matriz_transf::Matrix{Float64}`: matriz que vai realizar a transformacao na matriz de pontos.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function aleatoria(matriz_transf::Matrix{Float64}, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}
    
    # dimencao e quantidade de pontos
    valor_l1, valor_c1 = size(matriz_pontos)
    valor_l2, valor_c2 = size(matriz_transf)
    @assert valor_l2 == valor_c2 "A matriz_transf deve ser quadrada." # verificador
    @assert valor_l1 == valor_l2 "Dimencao da matriz_transf e da matriz_pontos sao incompativeis." # verificador

    # novas coordenadas
    nova_matriz = zeros(size(matriz_pontos))

    # aplicando a transformacao nos vetores
    for i in 1:valor_c1

        nova_matriz[1:valor_l1, i] = matriz_transf * matriz_pontos[1:valor_l1, i]

    end

    # retorna os vetores transformados
    return nova_matriz

end