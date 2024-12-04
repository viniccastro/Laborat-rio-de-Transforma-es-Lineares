"""
# Rotacao
Aplica a transformacao de rotacao em uma matriz de pontos do R² baseado-se em um angulo dado.

# Parametros para o R²
- `angulo::Int                   `: Valor do angulo, em graus, da rotacao no sentido anti-horario.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Parametros para o R³
- `angulo::Int                   `: Valor do angulo, em graus, da rotacao no sentido anti-horario.
- `eixo::String                  `: Eixo que sera aplicado a rotacao:
    * `x` : eixo x;
    * `y` : eixo y;
    * `z` : eixo z.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function rotacao(angulo::Int, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}

    # quantidade de pontos
    valor_l, valor_c = size(matriz_pontos)

    # angulo em radiano
    angulo_radiano = angulo*pi/180

    # matriz de coordenadas transformadas
    matriz_transformada = zeros(size(matriz_pontos))
    
    # matriz de rotacao
    if valor_l == 2

        matriz_rot = [cos(angulo_radiano) -sin(angulo_radiano) ; sin(angulo_radiano) cos(angulo_radiano)]

    else
        
        error("Dimencao dos pontos invalida, matriz_pontos deve deve ter dimencao (2 x np) onde np e o numero de pontos.")
        
    end

    # aplicando a transformacao nos vetores
    for i in 1:valor_c

        matriz_transformada[1:valor_l, i] = matriz_rot * matriz_pontos[1:valor_l, i]

    end

    # retorna os vetores rotacionados
    return matriz_transformada

end

function rotacao(angulo::Int, eixo::String, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}

    # quantidade de pontos
    valor_l, valor_c = size(matriz_pontos)

    # angulo em radiano
    angulo_radiano = angulo*pi/180

    # matriz de coordenadas transformadas
    matriz_transformada = zeros(size(matriz_pontos))
    
    # matriz de rotacao
    if valor_l == 3
        
        # escolhendo o eixo de rotacao
        if eixo == "x"
            
            # eixo x
            matriz_rot = [1 0 0 ; 0 cos(angulo_radiano) -sin(angulo_radiano) ; 0 sin(angulo_radiano) cos(angulo_radiano)]

        elseif eixo == "y"
            
            # eixo y
            matriz_rot = [cos(angulo_radiano) 0 sin(angulo_radiano) ; 0 1 0 ; -sin(angulo_radiano) 0 cos(angulo_radiano)]

        elseif eixo == "z"
            
            # eixo z
            matriz_rot = [cos(angulo_radiano) -sin(angulo_radiano) 0 ; sin(angulo_radiano) cos(angulo_radiano) 0 ; 0 0 1]

        else

            error("Parametro ``eixo`` invalido")

        end

    else
        
        error("Dimencao dos pontos invalida, matriz_pontos deve deve ter dimencao (3 x np) onde np e o numero de pontos.")
        
    end

    # aplicando a transformacao nos vetores
    for i in 1:valor_c

        matriz_transformada[1:valor_l, i] = matriz_rot * matriz_pontos[1:valor_l, i]

    end

    # retorna os vetores rotacionados
    return matriz_transformada

end