# bibliotecas
using Plots
# using PlotlyJS
using LinearAlgebra
# Definindo PlotlyJS como backend
plotlyjs()


#========================================#
#       Dados de entrada
#========================================#

"""
Gera uma matriz com as coordenada dos pontos que formam a figura de um numero em uma malha 7x7 de largura 1.

# Parametro
- `numero::Int`: dita qua numero da figura.
- `dimencao::String`: dita a dimencao dos dados da matriz:
    * `2d` : Duas dimencoes;
    * `3d` : Tres dimencoes.

# Retorna
- A matriz com as coordenadas do numero escolhido.
"""
function numeros(numero::Int, dimencao::String) :: Matrix{Float64}

    if numero == 0

        # coordenadas dos pontos do J (11 pontos)
        vetor_x = 1/14*[ 3,  5,  7,  9, 11,  7,  7,  7,  3,  5,  7]
        vetor_y = 1/14*[11, 11, 11, 11, 11,  9,  7,  5,  3,  3,  3]
        

    elseif numero == 1

        # coordenadas dos pontos do 1 (10 pontos)
        vetor_x = 1/14*[ 7,  7,  7,  7,  7,  5,  3,  5,  9, 11]
        vetor_y = 1/14*[11,  9,  7,  5,  3,  9,  3,  3,  3,  3]

    elseif numero == 2

        # coordenadas dos pontos do 2 (13 pontos)
        vetor_x = 1/14*[ 5,  7,  9,  3, 11,  7,  9,  5,  3,  5,  7,  9, 11]
        vetor_y = 1/14*[11, 11, 11,  9,  9,  7,  7,  5,  3,  3,  3,  3,  3]

    elseif numero == 3

        # coordenadas dos pontos do 3 (10 pontos)
        vetor_x = 1/14*[ 5,  7,  9, 11,  7,  9, 11,  5,  7,  9]
        vetor_y = 1/14*[11, 11, 11,  9,  7,  7,  5,  3,  3,  3]
    
    elseif numero == 4

        # coordenadas dos pontos do 4 (11 pontos)
        vetor_x = 1/14*[ 3,  3,  3,  5,  7,  9, 11,  9,  9,  9,  9]
        vetor_y = 1/14*[11,  9,  7,  7,  7,  7,  7, 11,  9,  5,  3]
    
    elseif numero == 5

        # coordenadas dos pontos do 5 (15 pontos)
        vetor_x = 1/14*[ 3,  5,  7,  9, 11,  3,  3,  5,  7,  9, 11,  3,  5,  7,  9]
        vetor_y = 1/14*[11, 11, 11, 11, 11,  9,  7,  7,  7,  7,  5,  3,  3,  3,  3]
    
    elseif numero == 6

        # coordenadas dos pontos do 6 (14 pontos)
        vetor_x = 1/14*[ 5,  7,  9, 11,  3,  3,  5,  7,  9,  3, 11,  5,  7,  9]
        vetor_y = 1/14*[11, 11, 11, 11,  9,  7,  7,  7,  7,  5,  5,  3,  3,  3]

    else

        error("Parametro ``numero`` imvalido")

    end

    # borda superior
    superior_x = collect(0 : 1/7 : 1)
    superior_y = ones(8)

    # borda inferior
    inferior_x = collect(0 : 1/7 : 1)
    inferior_y = zeros(8)

    # borda direita
    direita_x = ones(6)
    direita_y = collect(1/7 : 1/7 : 1-1/7)

    # borda esquerda
    esquerda_x = zeros(6)
    esquerda_y = collect(1/7 : 1/7 : 1-1/7)

    # juntando as bordas
    borda_x = [superior_x ; inferior_x ; direita_x ; esquerda_x]
    borda_y = [superior_y ; inferior_y ; direita_y ; esquerda_y]

    # retorna a matriz do numero
    if dimencao == "2d"
        
        bordas        = [borda_x borda_y] # 28 pontos
        matriz_pontos = [vetor_x vetor_y]

    elseif dimencao == "3d"

        vetor_z = zeros(length(vetor_x))
        borda_z = zeros(length(borda_x))
        bordas        = [borda_x borda_y borda_z] # 28 pontos
        matriz_pontos = [vetor_x vetor_y vetor_z]

    else

        error("Parametro ``dimencao`` invalido")

    end

    return [bordas ; matriz_pontos]'

end

"""
Plota os pontos da matriz de pontos que foi dada.

# Parametros
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- O plot da matriz de pontos.
"""
function plot_imagem(matriz_pontos::Matrix{Float64})
    
    # dimencoes da matriz
    valor_l, valor_c = size(matriz_pontos)
    
    # tamanho_eixo
    tamanho_eixo = 1.5

    # incializando o plot
    plot(legend=false, aspect_ratio=:equal)

    # limites da janela de plot
    xlims!(-tamanho_eixo, tamanho_eixo)
    ylims!(-tamanho_eixo, tamanho_eixo)

    if valor_l == 2
        
        # plot dos eixos
        plot!([-tamanho_eixo, tamanho_eixo], [0, 0], linecolor=:red, label="Eixo x") # eixo x
        plot!([0, 0], [-tamanho_eixo, tamanho_eixo], linecolor=:green, label="Eixo y") # eixo y
    
        if valor_c < 28
    
            # plot dos pontos
            plot!(matriz_pontos[1, 1:end], matriz_pontos[2, 1:end], seriestype=:scatter, label=false, color=:black)
            
        elseif valor_c >= 28
            
            # plot das bordas
            plot!(matriz_pontos[1,  1:16], matriz_pontos[2,  1:16], seriestype=:scatter, label=false, color=:red) # superior e inferior
            plot!(matriz_pontos[1, 17:28], matriz_pontos[2, 17:28], seriestype=:scatter, label=false, color=:green) # direita e esquerda
            
            # plot dos pontos
            plot!(matriz_pontos[1, 29:end], matriz_pontos[2, 29:end], seriestype=:scatter, label=false, color=:black)
    
        end

    elseif valor_l == 3

        # plot dos eixos
        plot!([-tamanho_eixo, tamanho_eixo], [0, 0], [0, 0], linecolor=:red, label="Eixo x") # eixo x
        plot!([0, 0], [-tamanho_eixo, tamanho_eixo], [0, 0], linecolor=:green, label="Eixo y") # eixo y
        plot!([0, 0], [0, 0], [-tamanho_eixo, tamanho_eixo], linecolor=:blue, label="Eixo z") # eixo z
        
        # plot das bordas
        # plot!(matriz_pontos[1,  1:32], matriz_pontos[2,  1:32], matriz_pontos[3,  1:32], seriestype=:scatter, label=false, color=:red) # superior e inferior
        # plot!(matriz_pontos[1, 33:56], matriz_pontos[2, 33:56], matriz_pontos[3, 33:56], seriestype=:scatter, label=false, color=:green) # direita e esquerda
        
        # plot dos pontos
        cores = rand(RGB, length(matriz_pontos[1, 1:end])) # cor do pontos
        plot!(matriz_pontos[1, 1:end], matriz_pontos[2, 1:end], matriz_pontos[3, 1:end], seriestype=:scatter, label=false, color=cores)

    else

        error("Dimencao dos pontos invalida")

    end

    # retona o plot dos pontos

end

#========================================#
#       Transformacoes lineares 2D
#========================================#
"""
Aplica a transformacao de espelhamento em uma matriz de pontos baseado-se em um eixo dado.

# Parametros
- `eixo::String                  `: dita a direcao da tansfomacao:
    * `"x"`  : em relacao ao eixo x;
    * `"y"`  : em relacao ao eixo y;
    * `"xy"` : em relacao ao eixo xy.
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- A matriz com as coordenadas dos pontos apos transformacao.
"""
function espelhamento(eixo::String, matriz_pontos::Matrix{Float64}) :: Matrix{Float64}
    
    # matriz de espelhamento
    if eixo == "x"

        matriz_esp = [-1 0 ; 0  1]

    elseif eixo == "y"

        matriz_esp = [ 1 0 ; 0 -1]

    elseif eixo == "xy"

        matriz_esp = [0 -1 ; -1 0]

    else

        error("Parametro invalido")

    end

    # quantidade de pontos
    quant_pontos = size(matriz_pontos)[1]

    # novas coordenadas
    nova_matriz = zeros(size(matriz_pontos))

    # aplicando a transformacao nos vetores
    for i in 1:quant_pontos

        valores_transformados = matriz_esp * matriz_pontos[i, 1:2]

        nova_matriz[i, 1:2] = valores_transformados

    end

    # retorna os vetores espelhados
    return nova_matriz

end

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

        valores_transformados = matriz_cis * matriz_pontos[i, 1:2]

        nova_matriz[i, 1:2] = valores_transformados

    end

    # retorna os vetores cisalhados
    return nova_matriz

end

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

        valores_transformados = matriz_est * matriz_pontos[i, 1:2]

        nova_matriz[i, 1:2] = valores_transformados

    end

    # retorna os vetores esticados
    return nova_matriz

end

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

        valores_transformados = matriz_transf * matriz_pontos[i, 1:2]

        nova_matriz[i, 1:2] = valores_transformados

    end

    # retorna os vetores transformados
    return nova_matriz

end


#========================================#
#       Transformacoes lineares para 2D e 3D
#========================================#
"""
Aplica a transformacao de rotacao em uma matriz de pontos baseado-se em um angulo dado.

# Parametros
- `angulo::Int                   `: Valor do angulo, em graus, da rotacao no sentido anti-horario.
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
        
    elseif valor_l == 3
        
        # eixo x
        matriz_rot = [1 0 0 ; 0 cos(angulo_radiano) -sin(angulo_radiano) ; 0 sin(angulo_radiano) cos(angulo_radiano)]

        # eixo y
        # matriz_rot = [cos(angulo_radiano) 0 sin(angulo_radiano) ; 0 1 0 ; -sin(angulo_radiano) 0 cos(angulo_radiano)]

        # eixo z
        # matriz_rot = [cos(angulo_radiano) -sin(angulo_radiano) 0 ; sin(angulo_radiano) cos(angulo_radiano) 0 ; 0 0 1]

    else
        
        error("Dimencao dos pontos invalida")
        
    end

    # aplicando a transformacao nos vetores
    for i in 1:valor_c

        matriz_transformada[1:valor_l, i] = matriz_rot * matriz_pontos[1:valor_l, i]

    end

    # retorna os vetores rotacionados
    return matriz_transformada

end


# if valor_l == 2
# elseif valor_l == 3
# else
#     error("Dimencao dos pontos invalida")
# end


#========================================#
#       Testes
#========================================#
# println("===== tamnha da matriz =====")
# println(size(numeros(1, "3d")))

# println()
# println("===== matriz =====")
# display(numeros(1, "3d"))

# println()
# println("===== plot =====")
# display(plot_imagem(numeros(1, "3d")))
# display(plot_imagem(rotacao(90,numeros(1,"3d"))))


#========================================#
#       animacao
#========================================#
angulos = collect(0 : 10 : 90)

animacao = @animate for a in angulos
    
    imagem = plot_imagem(rotacao(a,numeros(1,"3d")))
    
end

gif(animacao, fps=10)