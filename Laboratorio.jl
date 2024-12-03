# bibliotecas
using Plots
# using PlotlyJS
using LinearAlgebra
# Definindo PlotlyJS como backend
plotlyjs()

#========================================#
#       Transformacoes lineares
#========================================#
include("transf_rotacao.jl")      # rotacao
include("transf_reflexao.jl")     # reflexao
include("transf_esticamento.jl")  # esticamento
include("transf_cisalhamento.jl") # cisalhamento
include("transf_aleatoria.jl")    # aleatoria



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

    if numero == 00

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

        error("Parametro ``numero`` imvalido.")

    end

    # arestas
    aresta8 = collect(0 : 1/7 : 1)       # aresta externa
    aresta6 = collect(1/7 : 1/7 : 1-1/7) # aresta interna

    # complemento da dimencao
    resto80 = zeros(8)
    resto60 = zeros(6)
    resto81 = ones(8)
    resto61 = ones(6)

    # inicializando as bordas
    borda_x = [aresta8 ; aresta8 ; resto61 ; resto60]
    borda_y = [resto81 ; resto80 ; aresta6 ; aresta6]

    # retorna a matriz do numero
    if dimencao == "2d"
        
        bordas        = [borda_x borda_y] # 28 pontos
        matriz_pontos = [vetor_x vetor_y]

    elseif dimencao == "3d"

        vetor_z = zeros(length(vetor_x))
        borda_z = zeros(28)

        bordas        = [borda_x borda_y borda_z] # 28 pontos
        matriz_pontos = [vetor_x vetor_y vetor_z]

    else

        error("Parametro ``dimencao`` invalido.")

    end

    # retorna a matriz de pontos da figura
    return [bordas ; matriz_pontos]'

end

function cubo() :: Matrix{Float64}

    # arestas
    aresta8 = collect(0 : 1/7 : 1)       # aresta externa
    aresta6 = collect(1/7 : 1/7 : 1-1/7) # aresta interna

    # complemento da dimencao
    resto80 = zeros(8)
    resto60 = zeros(6)
    resto81 = ones(8)
    resto61 = ones(6)

    # juntando as bordas
    borda_x = [aresta8 ; aresta8 ; aresta8 ; aresta8 ; resto60 ; resto61 ; resto60 ; resto61 ; resto60 ; resto60 ; resto61 ; resto61]
    borda_y = [resto80 ; resto81 ; resto80 ; resto81 ; aresta6 ; aresta6 ; aresta6 ; aresta6 ; resto60 ; resto61 ; resto60 ; resto61]
    borda_z = [resto80 ; resto80 ; resto81 ; resto81 ; resto60 ; resto60 ; resto61 ; resto61 ; aresta6 ; aresta6 ; aresta6 ; aresta6]

    # retorna a matriz de pontos da figura de um cubo
    return [borda_x borda_y borda_z]' # 80 pontos

end

#========================================#
#       Plot
#========================================#
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
    plot(legend=false, aspect_ratio=:equal, xlabel = "eixo x", ylabel = "eixo y", zlabel = "eixo z")
    
    # limites da janela de plot
    xlims!(-tamanho_eixo, tamanho_eixo)
    ylims!(-tamanho_eixo, tamanho_eixo)

    if valor_l == 2
        
        # plot dos eixos
        plot!([-tamanho_eixo, tamanho_eixo], [0, 0], linecolor=:red, label="Eixo x") # eixo x
        plot!([0, 0], [-tamanho_eixo, tamanho_eixo], linecolor=:green, label="Eixo y") # eixo y
    
        # plot das bordas
        plot!(matriz_pontos[1,  1:16], matriz_pontos[2,  1:16], seriestype=:scatter, label=false, color=:red) # aresta do x
        plot!(matriz_pontos[1, 17:28], matriz_pontos[2, 17:28], seriestype=:scatter, label=false, color=:green) # aresta do y
        
        # plot dos pontos
        plot!(matriz_pontos[1, 29:end], matriz_pontos[2, 29:end], seriestype=:scatter, label=false, color=:black)

    elseif valor_l == 3
        
        # plot dos eixos
        plot!([-tamanho_eixo, tamanho_eixo], [0, 0], [0, 0], linecolor=:red, label="Eixo x") # eixo x
        plot!([0, 0], [-tamanho_eixo, tamanho_eixo], [0, 0], linecolor=:green, label="Eixo y") # eixo y
        plot!([0, 0], [0, 0], [-tamanho_eixo, tamanho_eixo], linecolor=:blue, label="Eixo z") # eixo z
        
        if valor_c < 80 # trabalhando com um plano

            # plot das bordas
            plot!(matriz_pontos[1,  1:16], matriz_pontos[2,  1:16], matriz_pontos[3,  1:16], seriestype=:scatter, label=false, color=:red) # aresta do x
            plot!(matriz_pontos[1, 17:28], matriz_pontos[2, 17:28], matriz_pontos[3, 17:28], seriestype=:scatter, label=false, color=:green) # aresta do y
            
            # plot dos pontos
            plot!(matriz_pontos[1, 29:end], matriz_pontos[2, 29:end], matriz_pontos[3, 29:end], seriestype=:scatter, label=false, color=:black)

        elseif valor_c >= 80 # trabalhando com um cubo
            
            # plot das bordas
            plot!(matriz_pontos[1, 1:8], matriz_pontos[2, 1:8], matriz_pontos[3, 1:8], seriestype=:scatter, label=false, color=:red) # aresta do x
            plot!(matriz_pontos[1, 9:16], matriz_pontos[2, 9:16], matriz_pontos[3, 9:16], seriestype=:scatter, label=false, color=:yellow)
            plot!(matriz_pontos[1, 17:24], matriz_pontos[2, 17:24], matriz_pontos[3, 17:24], seriestype=:scatter, label=false, color=:pink)
            plot!(matriz_pontos[1, 25:32], matriz_pontos[2, 25:32], matriz_pontos[3, 25:32], seriestype=:scatter, label=false, color=:orange)

            plot!(matriz_pontos[1, 33:38], matriz_pontos[2, 33:38], matriz_pontos[3, 33:38], seriestype=:scatter, label=false, color=:green) # aresta do y
            plot!(matriz_pontos[1, 39:44], matriz_pontos[2, 39:44], matriz_pontos[3, 39:44], seriestype=:scatter, label=false, color=:lime)
            plot!(matriz_pontos[1, 45:50], matriz_pontos[2, 45:50], matriz_pontos[3, 45:50], seriestype=:scatter, label=false, color=:cyan)
            plot!(matriz_pontos[1, 51:56], matriz_pontos[2, 51:56], matriz_pontos[3, 51:56], seriestype=:scatter, label=false, color=:brown)

            plot!(matriz_pontos[1, 57:62], matriz_pontos[2, 57:62], matriz_pontos[3, 57:62], seriestype=:scatter, label=false, color=:blue) # aresta do z
            plot!(matriz_pontos[1, 63:68], matriz_pontos[2, 63:68], matriz_pontos[3, 63:68], seriestype=:scatter, label=false, color=:purple)
            plot!(matriz_pontos[1, 69:74], matriz_pontos[2, 69:74], matriz_pontos[3, 69:74], seriestype=:scatter, label=false, color=:teal)
            plot!(matriz_pontos[1, 75:80], matriz_pontos[2, 75:80], matriz_pontos[3, 75:80], seriestype=:scatter, label=false, color=:magenta)

            # plot dos pontos
            plot!(matriz_pontos[1, 81:end], matriz_pontos[2, 81:end], matriz_pontos[3, 81:end], seriestype=:scatter, label=false, color=:black)

        end

    else

        error("Dimencao dos pontos invalida, matriz_pontos deve deve ter dimencao (2 x np) ou (3 x np) onde np e o numero de pontos.")

    end

    # retona o plot dos pontos

end




#========================================#
#       Testes
#========================================#
# println("===== tamnha da matriz =====")
# println(size(numeros(1, "3d")))
# println(size(cubo()))

# println()
# println("===== matriz =====")
# display(numeros(1, "3d"))
# display(cubo())

# =========== Dados ===========
# display(plot_imagem(numeros(00, "2d")))
# display(plot_imagem(numeros(00, "3d")))
# display(plot_imagem(cubo()))

# ==========================> rotacao <==========================
# display(plot_imagem(rotacao(90, numeros(00,"2d"))))      # true
# display(plot_imagem(rotacao(90, "x", numeros(00,"2d")))) # true
# display(plot_imagem(rotacao(90, "x", numeros(00,"3d")))) # true 
# display(plot_imagem(rotacao(90, "y", numeros(00,"3d")))) # true
# display(plot_imagem(rotacao(90, "z", numeros(00,"3d")))) # true
# display(plot_imagem(rotacao(90, "x", cubo())))           # true
# display(plot_imagem(rotacao(90, "y", cubo())))           # true
# display(plot_imagem(rotacao(90, "z", cubo())))           # true



# =========================> reflexao <=========================
# display(plot_imagem(reflexao("x", numeros(00,"2d"))))   # true
# display(plot_imagem(reflexao("y", numeros(00,"2d"))))   # true
# display(plot_imagem(reflexao("xy", numeros(00,"2d"))))  # true
# display(plot_imagem(reflexao("-xy", numeros(00,"2d")))) # true

# display(plot_imagem(reflexao("x", numeros(00,"3d"))))   # true
# display(plot_imagem(reflexao("y", numeros(00,"3d"))))   # true
# display(plot_imagem(reflexao("z", numeros(00,"3d"))))   # true
# display(plot_imagem(reflexao("x", cubo())))             # true
# display(plot_imagem(reflexao("y", cubo())))             # true
# display(plot_imagem(reflexao("z", cubo())))             # true

# display(plot_imagem(reflexao("xy", numeros(00,"3d"))))  # true
# display(plot_imagem(reflexao("yx", numeros(00,"3d"))))  # true
# display(plot_imagem(reflexao("xy", cubo())))            # true
# display(plot_imagem(reflexao("yx", cubo())))            # true
# display(plot_imagem(reflexao("xz", numeros(00,"3d"))))  # true
# display(plot_imagem(reflexao("zx", numeros(00,"3d"))))  # true
# display(plot_imagem(reflexao("xz", cubo())))            # true
# display(plot_imagem(reflexao("zx", cubo())))            # true
# display(plot_imagem(reflexao("yz", numeros(00,"3d"))))  # true
# display(plot_imagem(reflexao("zy", numeros(00,"3d"))))  # true
# display(plot_imagem(reflexao("yz", cubo())))            # true
# display(plot_imagem(reflexao("zy", cubo())))            # true

# display(plot_imagem(reflexao("xyz", numeros(00,"3d")))) # true
# display(plot_imagem(reflexao("xzy", numeros(00,"3d")))) # true
# display(plot_imagem(reflexao("yxz", numeros(00,"3d")))) # true
# display(plot_imagem(reflexao("yzx", numeros(00,"3d")))) # true
# display(plot_imagem(reflexao("zxy", numeros(00,"3d")))) # true
# display(plot_imagem(reflexao("zyx", numeros(00,"3d")))) # true
# display(plot_imagem(reflexao("xyz", cubo())))           # true
# display(plot_imagem(reflexao("xzy", cubo())))           # true
# display(plot_imagem(reflexao("yxz", cubo())))           # true
# display(plot_imagem(reflexao("yzx", cubo())))           # true
# display(plot_imagem(reflexao("zxy", cubo())))           # true
# display(plot_imagem(reflexao("zyx", cubo())))           # true



# =========== esticamento ===========

# =========== cisalhamento ===========

# =========== aleatoria ===========




#========================================#
#       animacao
#========================================#
# angulos = collect(0 : 10 : 360)

# animacao = @animate for a in angulos
    
#     if a <= 90
#         imagem = plot_imagem(rotacao(a,"x",cubo()))
#     elseif a > 90 && a <= 180
#         imagem = plot_imagem(rotacao(-a,"y",cubo()))
#     elseif a > 180 && a <= 270
#         imagem = plot_imagem(rotacao(a,"z",cubo()))
#     elseif a > 270 && a <= 360
#         imagem = plot_imagem(rotacao(a,"x",cubo()))
#     end
    
# end

# gif(animacao, fps=10)