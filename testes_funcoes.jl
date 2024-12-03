# bibliotecas
using Plots
# using PlotlyJS
using LinearAlgebra
# Definindo PlotlyJS como backend
plotlyjs()

#========================================#
#       Transformacoes lineares
#========================================#
include("funcoes_base.jl")        # dados de entrada e plot dos pontos
include("transf_rotacao.jl")      # rotacao
include("transf_reflexao.jl")     # reflexao
include("transf_esticamento.jl")  # esticamento
include("transf_cisalhamento.jl") # cisalhamento
include("transf_aleatoria.jl")    # aleatoria



#========================================#
#       Dados de entrada
#========================================#
plano_2d = numeros(00, "2d")
plano_3d = numeros(00, "3d")
cuboo     = cubo()



#========================================#
#       Testes
#========================================#

# ==========================>  estrutura  <==========================
# println("=====>  tamnha da matriz  <=====")
# println(size(plano_2d))
# println(size(plano_3d))
# println(size(cuboo))

# println()
# println("=====>  matriz  <=====")
# display(plano_2d)
# display(plano_3d)
# display(cuboo)



# ==========================>  Dados entrada  <==========================
# display(desenho(plano_2d))  # true
# display(desenho(plano_3d))  # true
# display(desenho(cuboo))      # true



# ==========================>  rotacao  <==========================
# display(desenho(rotacao(90, plano_2d)))       # true
# display(desenho(rotacao(90, "x", plano_2d)))  # true
# display(desenho(rotacao(90, "x", plano_3d)))  # true 
# display(desenho(rotacao(90, "y", plano_3d)))  # true
# display(desenho(rotacao(90, "z", plano_3d)))  # true
# display(desenho(rotacao(90, "x", cuboo)))      # true
# display(desenho(rotacao(90, "y", cuboo)))      # true
# display(desenho(rotacao(90, "z", cuboo)))      # true



# ==========================>  reflexao  <==========================
# display(desenho(reflexao("x", plano_2d)))    # true
# display(desenho(reflexao("y", plano_2d)))    # true
# display(desenho(reflexao("xy", plano_2d)))   # true
# display(desenho(reflexao("-xy", plano_2d)))  # true
# display(desenho(reflexao("-xz", plano_2d)))  # true

# display(desenho(reflexao("x", plano_3d)))    # true
# display(desenho(reflexao("y", plano_3d)))    # true
# display(desenho(reflexao("z", plano_3d)))    # true
# display(desenho(reflexao("x", cuboo)))        # true
# display(desenho(reflexao("y", cuboo)))        # true
# display(desenho(reflexao("z", cuboo)))        # true

# display(desenho(reflexao("xy", plano_3d)))   # true
# display(desenho(reflexao("yx", plano_3d)))   # true
# display(desenho(reflexao("xy", cuboo)))       # true
# display(desenho(reflexao("yx", cuboo)))       # true
# display(desenho(reflexao("xz", plano_3d)))   # true
# display(desenho(reflexao("zx", plano_3d)))   # true
# display(desenho(reflexao("xz", cuboo)))       # true
# display(desenho(reflexao("zx", cuboo)))       # true
# display(desenho(reflexao("yz", plano_3d)))   # true
# display(desenho(reflexao("zy", plano_3d)))   # true
# display(desenho(reflexao("yz", cuboo)))       # true
# display(desenho(reflexao("zy", cuboo)))       # true

# display(desenho(reflexao("xyz", plano_3d)))  # true
# display(desenho(reflexao("xzy", plano_3d)))  # true
# display(desenho(reflexao("yxz", plano_3d)))  # true
# display(desenho(reflexao("yzx", plano_3d)))  # true
# display(desenho(reflexao("zxy", plano_3d)))  # true
# display(desenho(reflexao("zyx", plano_3d)))  # true
# display(desenho(reflexao("xyz", cuboo)))      # true
# display(desenho(reflexao("xzy", cuboo)))      # true
# display(desenho(reflexao("yxz", cuboo)))      # true
# display(desenho(reflexao("yzx", cuboo)))      # true
# display(desenho(reflexao("zxy", cuboo)))      # true
# display(desenho(reflexao("zyx", cuboo)))      # true



# ==========================>  esticamento  <==========================
# vetor_1 = [0.5, 0.5]
# vetor_2 = [1.2, 0.5]
# vetor_3 = [0.5, 0.5, 0.5]
# vetor_4 = [1.4, 0.9, 0.1]

# display(desenho(esticamento(vetor_1, plano_2d)))  # true
# display(desenho(esticamento(vetor_2, plano_2d)))  # true
# display(desenho(esticamento(vetor_3, plano_2d)))  # true
# display(desenho(esticamento(vetor_1, plano_3d)))  # true
# display(desenho(esticamento(vetor_3, plano_3d)))  # true
# display(desenho(esticamento(vetor_4, plano_3d)))  # true
# display(desenho(esticamento(vetor_3, cuboo)))      # true
# display(desenho(esticamento(vetor_4, cuboo)))      # true



# ==========================>  cisalhamento  <==========================
# display(desenho(cisalhamento(0.5, "x", plano_2d)))   # true
# display(desenho(cisalhamento(0.5, "y", plano_2d)))   # true
# display(desenho(cisalhamento(0.5, "z", plano_2d)))   # true
# display(desenho(cisalhamento(0.5, "x", plano_3d)))   # true
# display(desenho(cisalhamento(0.5, "xy", plano_3d)))  # true
# display(desenho(cisalhamento(0.5, "xz", plano_3d)))  # true
# display(desenho(cisalhamento(0.5, "yx", plano_3d)))  # true
# display(desenho(cisalhamento(0.5, "yz", plano_3d)))  # true
# display(desenho(cisalhamento(0.5, "zx", plano_3d)))  # true
# display(desenho(cisalhamento(0.5, "zy", plano_3d)))  # true
# display(desenho(cisalhamento(0.5, "xy", cuboo)))      # true
# display(desenho(cisalhamento(0.5, "xz", cuboo)))      # true
# display(desenho(cisalhamento(0.5, "yx", cuboo)))      # true
# display(desenho(cisalhamento(0.5, "yz", cuboo)))      # true
# display(desenho(cisalhamento(0.5, "zx", cuboo)))      # true
# display(desenho(cisalhamento(0.5, "zy", cuboo)))      # true



# ==========================>  aleatoria  <==========================
# matriz_1 = [1.0 0.5 ; 0.0 2.0]
# matriz_2 = [cos(pi) -sin(pi) ; sin(pi) cos(pi)]
# matriz_3 = [1.0 0.5 0.0; 0.0 2.0 0.0 ; 0.0 0.0 0.0]
# matriz_4 = [1.0 0.0 0.0; 0.0 0.0 1.0 ; 0.0 1.0 0.0]

# display(desenho(aleatoria(matriz_1, plano_2d)))  # true
# display(desenho(aleatoria(matriz_2, plano_2d)))  # true
# display(desenho(aleatoria(matriz_3, plano_2d)))  # true
# display(desenho(aleatoria(matriz_1, plano_3d)))  # true
# display(desenho(aleatoria(matriz_3, plano_3d)))  # true
# display(desenho(aleatoria(matriz_4, plano_3d)))  # true
# display(desenho(aleatoria(matriz_3, cuboo)))      # true
# display(desenho(aleatoria(matriz_4, cuboo)))      # true