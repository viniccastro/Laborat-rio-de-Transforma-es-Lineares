"""
# Cisalhado
Aplica a transformacao de cisalhamento em uma matriz de pontos baseado-se em uma orientacao e um parametro dado.

# Parametros
- `valor::Float64                `: dita o quanto sera cisalhado.
- `orientacao::String            `: dita a direcao da tansfomacao:
    * ``"x"`` : em relacao ao eixo x (horizontal);
    * ``"y"`` : em relacao ao eixo y (vertical).
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Parametros
- `valor::Float64                `: dita o quanto sera cisalhado.
- `orientacao::String            `: dita a direcao da tansfomacao:
    * ``"xy"`` : em relacao ao plano xy;
    * ``"yx"`` : em relacao ao plano yx;
    * ``"xz"`` : em relacao ao plano xz;
    * ``"zx"`` : em relacao ao plano zx;
    * ``"yz"`` : em relacao ao plano yz;
    * ``"zy"`` : em relacao ao plano zy.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function cisalhamento(valor::Float64, orientacao::String, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}
    
    # dimencao e numero de pontos
    valor_l, valor_c = size(matriz_pontos)

    # matriz de cisalhamento
    if valor_l == 2

        if orientacao == "x"
    
            matriz_cis = [1.0 valor ; 0.0 1.0]
    
        elseif orientacao == "y"
    
            matriz_cis = [1.0 0.0 ; valor 1.0]
    
        else
    
            error("Parametro ``orientacao`` invalido")
    
        end

    elseif valor_l == 3

        if orientacao == "xy"
    
            matriz_cis = [1.0 valor 0.0 ; 0.0 1.0 0.0 ; 0.0 0.0 1.0]
    
        elseif orientacao == "xz"
    
            matriz_cis = [1.0 0.0 valor ; 0.0 1.0 0.0 ; 0.0 0.0 1.0]

        elseif orientacao == "yz"
    
            matriz_cis = [1.0 0.0 0.0 ; 0.0 1.0 valor ; 0.0 0.0 1.0]

        elseif orientacao == "yx"
    
            matriz_cis = [1.0 0.0 0.0 ; valor 1.0 0.0 ; 0.0 0.0 1.0]

        elseif orientacao == "zx"
    
            matriz_cis = [1.0 0.0 0.0 ; 0.0 1.0 0.0 ; valor 0.0 1.0]

        elseif orientacao == "zy"
    
            matriz_cis = [1.0 0.0 0.0 ; 0.0 1.0 0.0 ; 0.0 valor 1.0]
    
        else
    
            error("Parametro ``orientacao`` invalido")
    
        end

    else

        error("Dimencao dos pontos invalida, matriz_pontos deve deve ter dimencao (2 x np) ou (3 x np) onde np e o numero de pontos.")
        
    end

    # novas coordenadas
    nova_matriz = zeros(size(matriz_pontos))

    # aplicando a transformacao nos vetores
    for i in 1:valor_c

        nova_matriz[1:valor_l, i] = matriz_cis * matriz_pontos[1:valor_l, i]

    end

    # retorna os vetores cisalhados
    return nova_matriz

end