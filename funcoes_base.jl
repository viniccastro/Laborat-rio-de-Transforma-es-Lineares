"""
# Numeros
Gera uma matriz com as coordenada dos pontos que formam a figura de um numero em uma malha 7x7 de largura 1.

# Parametro
- `numero::Int`: dita qua numero da figura entre 1 a 6.
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

"""
# Cubo
Gera uma matriz com as coordenada dos pontos que formam a figura de um cubo em uma malha 7x7x7 de largura 1.

# Retorna
- A matriz com as coordenadas do cubo.
"""
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

"""
# Desenho
Plota os pontos da matriz de pontos que foi dada.

# Parametros
- `matriz_pontos::Matrix{Float64}`: Coordenadas de cada ponto de modo que a linha 1 tenha os valores do eixo x e a linha 2 tenha os valores do eixo y.

# Retorna
- O plot da matriz de pontos.
"""
function desenho(matriz_pontos::Matrix{Float64})
    
    # dimencoes da matriz
    valor_l, valor_c = size(matriz_pontos)
    
    # tamanho_eixo
    tamanho_eixo = 2

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