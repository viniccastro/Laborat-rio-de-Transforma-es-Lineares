"""
Aplica a transformacao de esticamento em uma matriz de pontos baseado-se em dois valores dados.

# Parametros
- `valor_x::Float64              `: valor que vai esticar a coordenada do eixo x
- `valor_y::Float64              `: valor que vai esticar a coordenada do eixo y
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function esticamento(valor_x::Float64, valor_y::Float64, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}
    
    # matriz de esticamento
    matriz_est = [valor_x 0 ; 0  valor_y]

    # quantidade de pontos
    quant_pontos = size(matriz_pontos)[1]

    # novas coordenadas
    nova_matriz = zeros(size(matriz_pontos))

    # aplicando a transformacao nos vetores
    for i in 1:quant_pontos

        nova_matriz[1:2, i] = matriz_est * matriz_pontos[1:2, i]

    end

    # retorna os vetores esticados
    return nova_matriz

end