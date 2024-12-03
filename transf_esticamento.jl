"""
Aplica a transformacao de esticamento em uma matriz de pontos baseado-se em um vetor de esticamento dado.

# Parametros
- `vetor_escala::Vector{Float64} `: Vetor com os valore que vam esticar cada coordenada.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function esticamento(vetor_escala::Vector{Float64}, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}
    
    # dimencao e quantidade de pontos
    valor_l, valor_c = size(matriz_pontos)
    valor_d = length(vetor_escala)
    @assert valor_l == valor_d "Dimencao do vetor_escala e da matriz_pontos sao incompativeis." # verificador

    # matriz de esticamento
    if valor_l == 2

        matriz_est = [vetor_escala[1] 0 ; 0  vetor_escala[2]]
        
    elseif valor_l == 3

        matriz_est = [vetor_escala[1] 0 0 ; 0  vetor_escala[2] 0 ; 0 0 vetor_escala[3]]

    else

        error("Dimencao dos pontos invalida, matriz_pontos deve deve ter dimencao (2 x np) ou (3 x np) onde np e o numero de pontos.")

    end

    # novas coordenadas
    nova_matriz = zeros(size(matriz_pontos))

    # aplicando a transformacao nos vetores
    for i in 1:valor_c

        nova_matriz[1:valor_l, i] = matriz_est * matriz_pontos[1:valor_l, i]

    end

    # retorna os vetores esticados
    return nova_matriz

end