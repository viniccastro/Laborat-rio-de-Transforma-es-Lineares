"""
# Reflexao
Aplica a transformacao de reflexao em uma matriz de pontos do R² baseado-se em um eixo dado.

# Parametros para o R²
- `eixo::String                  `: dita a direcao da tansfomacao:
    * `"x"`   : em relacao ao eixo x;
    * `"y"`   : em relacao ao eixo y;
    * `"xy"`  : em relacao ao eixo xy;
    * `"-xy"` : em relacao ao eixo -xy.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Parametros para o R³
- `eixo::String                  `: dita a direcao da tansfomacao:
    * `"x"`  : em relacao ao eixo x;
    * `"y"`  : em relacao ao eixo y;
    * `"z"`  : em relacao ao eixo z;
    * `"xy"` : em relacao ao eixo xy;
    * `"xz"`  : em relacao ao eixo xz;
    * `"yz"`  : em relacao ao eixo yz;
    * `"xyz"` : em relacao ao eixo xyz.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function reflexao(eixo::String, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}
    
    # quantidade de pontos
    valor_l, valor_c = size(matriz_pontos)

    # matriz de reflexao
    if valor_l == 2
        
        if eixo == "x"

            # eixo x
            matriz_ref = [ 1.0 0.0 ; 0.0 -1.0]
    
        elseif eixo == "y"
            
            # eixo y
            matriz_ref = [-1.0 0.0 ; 0.0  1.0]
    
        elseif eixo == "xy" || eixo == "yx"
    
            # eixo xy
            matriz_ref = [ 0.0 1.0 ; 1.0  0.0]
    
        elseif eixo == "-xy" || eixo == "-yx"
    
            # eixo xy
            matriz_ref = [ 0.0 -1.0 ; -1.0  0.0]

        else
    
            error("Parametro ``eixo`` invalido")
    
        end

    elseif valor_l == 3

        if eixo == "x"
            
            # eixo x
            matriz_ref = [1.0 0.0 0.0 ; 0.0 -1.0 0.0 ; 0.0 0.0 -1.0]
    
        elseif eixo == "y"
    
            # eixo y
            matriz_ref = [-1.0 0.0 0.0 ; 0.0  1.0 0.0 ; 0.0 0.0 -1.0]
    
        elseif eixo == "z"
    
            # eixo z
            matriz_ref = [-1.0 0.0 0.0 ; 0.0 -1.0 0.0 ; 0.0 0.0  1.0]
    
        elseif eixo == "xy" || eixo == "yx"
    
            # eixo xy
            matriz_ref = [ 1.0 0.0 0.0 ; 0.0  1.0 0.0 ; 0.0 0.0 -1.0]

        elseif eixo == "xz" || eixo == "zx"
    
            # eixo xz
            matriz_ref = [ 1.0 0.0 0.0 ; 0.0 -1.0 0.0 ; 0.0 0.0  1.0]

        elseif eixo == "yz" || eixo == "zy"
    
            # eixo yz
            matriz_ref = [-1.0 0.0 0.0 ; 0.0  1.0 0.0 ; 0.0 0.0  1.0]

        elseif eixo == "xyz" || eixo == "xzy" || eixo == "yxz" || eixo == "yzx" || eixo == "zxy" || eixo == "zyx"
    
            # eixo xyz
            matriz_ref = [-1.0 0.0 0.0 ; 0.0 -1.0 0.0 ; 0.0 0.0 -1.0]

        else
    
            error("Parametro ``eixo`` invalido")
    
        end

    else

        error("Dimencao dos pontos invalida")
        
    end

    # novas coordenadas
    nova_matriz = zeros(size(matriz_pontos))

    # aplicando a transformacao nos vetores
    for i in 1:valor_c

        nova_matriz[1:valor_l, i] = matriz_ref * matriz_pontos[1:valor_l, i]

    end

    # retorna os vetores espelhados
    return nova_matriz

end