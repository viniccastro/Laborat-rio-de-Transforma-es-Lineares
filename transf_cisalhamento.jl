"""
Aplica a transformacao de cisalhamento em uma matriz de pontos baseado-se em uma orientacao e um parametro dado.

# Parametros
- `orientacao::String            `: dita a direcao da tansfomacao:
    * `"x"` : em relacao ao eixo x (horizontal);
    * `"y"` : em relacao ao eixo y (vertical).
- `parametro::Float64            `: dita o quanto sera cisalhado.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function cisalhamento(orientacao::String, parametro::Float64, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}
    
    # matriz de cisalhamento
    if orientacao == "v"

        matriz_cis = [1 0 ; parametro  1]

    elseif orientacao == "h"

        matriz_cis = [ 1 parametro ; 0 1]

    else

        error("Parametro invalido")

    end

    # quantidade de pontos
    quant_pontos = size(matriz_pontos)[1]

    # novas coordenadas
    nova_matriz = zeros(size(matriz_pontos))

    # aplicando a transformacao nos vetores
    for i in 1:quant_pontos

        nova_matriz[1:2, i] = matriz_cis * matriz_pontos[1:2, i]

    end

    # retorna os vetores cisalhados
    return nova_matriz

end