# bibliotecas
using Plots
using LinearAlgebra

# Definindo PlotlyJS como backend
# using PlotlyJS
plotlyjs()

#========================================#
#       Dados necessarios
#========================================#
include("funcoes_base.jl")         # dados de entrada e plot dos pontos
include("transf_rotacao.jl")       # rotacao
include("transf_reflexao.jl")      # reflexao
include("transf_esticamento.jl")   # esticamento
include("transf_cisalhamento.jl")  # cisalhamento
include("transf_aleatoria.jl")     # aleatoria



#========================================#
#       Dados de entrada
#========================================#
plano_2d = numeros(00, "2d")
plano_3d = numeros(00, "3d")
cuboo    = cubo()



#========================================#
#       Transformacoes lineares
#========================================#
# exemplo_01 = rotacao(90, plano_2d)
# exemplo_02 = rotacao(90, "x", plano_3d)
# exemplo_03 = rotacao(90, "x", cuboo)

# exemplo_04 = reflexao("x", plano_2d)
# exemplo_05 = reflexao("x", plano_3d)
# exemplo_06 = reflexao("x", cuboo)

# vetor_1 = [1.2, 0.5]
# vetor_2 = [0.5, 0.5, 0.5]
# exemplo_07 = esticamento(vetor_1, plano_2d)
# exemplo_08 = esticamento(vetor_2, plano_3d)
# exemplo_09 = esticamento(vetor_2, cuboo)

# exemplo_10 = cisalhamento(0.5, "x", plano_2d)
# exemplo_11 = cisalhamento(0.5, "xy", plano_3d)
# exemplo_12 = cisalhamento(0.5, "xy", cuboo)

# matriz_1 = [cos(pi) -sin(pi) ; sin(pi) cos(pi)]
# matriz_2 = [1.0 0.0 0.0; 0.0 0.0 1.0 ; 0.0 1.0 0.0]
# exemplo_13 = aleatoria(matriz_1, plano_2d)
# exemplo_14 = aleatoria(matriz_2, plano_3d)
# exemplo_15 = aleatoria(matriz_2, cuboo)

# display(desenho(exemplo_03))
# display(desenho(exemplo_08))
# display(desenho(exemplo_15))



#========================================#
#       animacao
#========================================#
# =====>  exemplo 1
# angulos_1 = collect(0 : 10 : 360)
# animacao = @animate for a in angulos_1
    
#     imagem = desenho(rotacao(a,"x",cuboo))
    
# end
# gif(animacao, fps=10)
# desenho(cisalhamento(0.7,"yz",cuboo))


# =====>  exemplo 2
# empurrao = collect(0 : 0.5/10 : 1.0)
# animacao = @animate for a in empurrao
    
#     # imagem = desenho(cisalhamento(a, "x", plano_2d))
#     imagem = desenho(cisalhamento(a, "yz", cuboo))
    
# end
# gif(animacao, fps=10)


# =====>  exemplo 3
# angulos_2 = collect(0 : 10 : 500)
# cuboo1 = rotacao(90,"x",cuboo)
# animacao = @animate for a in angulos_2
    
#     if a <= 90
        
#         imagem = desenho(rotacao(a,"x",cuboo))

#     elseif a > 140
#         imagem = desenho(cisalhamento(a/1000,"yz", cuboo1))
#     end
    
# end
# gif(animacao, fps=10)