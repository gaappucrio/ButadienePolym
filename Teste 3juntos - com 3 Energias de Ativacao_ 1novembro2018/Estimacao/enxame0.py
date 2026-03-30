import numpy as np
import os
import variaveis as v
import global_vars as g
from calcula import fun_obj

def enxame0(IST, RegConf, Niter, Npt, C1, C2, Wo, Wf, Plim):
    """Minimização da função objetivo pelo método do Enxame de Partículas (PSO)."""
    Npar = g.NPar
    Fotm = 1e100
    Fpt = np.full(Npt, 1e100)
    
    # Define a velocidade máxima
    Vmax = (Plim[:, 1] - Plim[:, 0]) / 2.0

    # Gerando enxame inicial e velocidades
    P = np.zeros((Npt, Npar))
    Pvel = np.zeros((Npt, Npar))
    for i in range(Npt):
        for j in range(Npar):
            P[i, j] = Plim[j, 0] + np.random.rand() * (Plim[j, 1] - Plim[j, 0])
            Pvel[i, j] = Vmax[j] * (2.0 * np.random.rand() - 1.0)

    # A primeira partícula recebe o palpite inicial
    P[0, :] = v.Param[:]
    Potm = np.copy(v.Param)
    F = np.zeros(Npt)
    Ppt = np.copy(P)

    # Define o caminho do arquivo (se RegConf != 1, joga no buraco negro do SO para não dar erro)
    arquivo_tudo = 'Saida_tudo.dat' if RegConf == 1 else os.devnull

    # Abertura dos arquivos para salvar os relatórios
    with open('relatorioenxame.dat', 'w') as f21, \
         open('Saida_bom.dat', 'w') as f110, \
         open(arquivo_tudo, 'w') as f120:

        for IT in range(1, Niter + 1):
            print(f"ITERACAO {IT} Fobj {Fotm}")
            f21.write(f"\n   Função Objetivo = {Fotm:.6E}\n")
            f21.write("   Parâmetros Estimados\n")
            for idx, val in enumerate(Potm):
                f21.write(f"   Param({idx+1:02d}) =    {val:.9E}\n")

            # Avalia a função objetivo para cada partícula
            for i in range(Npt):
                Param_temp = np.copy(P[i, :])
                F[i] = fun_obj(IST, Param_temp)

                if RegConf == 1:
                    # Formata e salva tudo se RegConf for 1
                    p_str = " ".join([f"{x:.6E}" for x in P[i, :min(5, Npar)]])
                    f120.write(f" {IT:5d} {i:3d} {p_str}  {F[i]:.6E}\n")

            # Verifica se a menor FObj desta iteração é menor que o ótimo atual global
            pos_min = np.argmin(F)
            if F[pos_min] < Fotm:
                Fotm = F[pos_min]
                Potm = np.copy(P[pos_min, :])
                p_str_opt = " ".join([f"{x:.6E}" for x in Potm])
                f110.write(f"  {IT:4d}  {p_str_opt}  {Fotm:.6E}\n")
                print(f"  {IT:4d}  {p_str_opt}  {Fotm:.6E}")

            # Atualiza o melhor pessoal de cada partícula
            for i in range(Npt):
                if F[i] < Fpt[i]:
                    Fpt[i] = F[i]
                    Ppt[i, :] = np.copy(P[i, :])

            # Ponderação decrescente para inércia W
            W = Wo + (Wf - Wo) * (IT - 1) / (Niter - 1) if Niter > 1 else Wf
            
            # Geração dos novos pontos e velocidades
            for i in range(Npt):
                for j in range(Npar):
                    # Atualiza velocidade
                    Pvel[i, j] = W * Pvel[i, j]
                    Pvel[i, j] += C1 * np.random.rand() * (Ppt[i, j] - P[i, j])
                    Pvel[i, j] += C2 * np.random.rand() * (Potm[j] - P[i, j])
                    
                    # Controle de velocidade máxima
                    if abs(Pvel[i, j]) > Vmax[j]:
                        Pvel[i, j] = np.sign(Pvel[i, j]) * Vmax[j]
                        
                    # Atualiza posição
                    P[i, j] += Pvel[i, j]

                    # Teste e rebatimento dos limites de busca
                    if P[i, j] < Plim[j, 0]:
                        P[i, j] = Plim[j, 0]
                        Pvel[i, j] = -Pvel[i, j] / 2.0
                    elif P[i, j] > Plim[j, 1]:
                        P[i, j] = Plim[j, 1]
                        Pvel[i, j] = -Pvel[i, j] / 2.0

    v.Param = np.copy(Potm)
    return Fotm