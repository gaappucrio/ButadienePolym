import numpy as np
import variaveis as v
import global_vars as g
from modelo import modelo

def fun_obj(IST, Param):
    """Avalia o modelo nas condições experimentais e calcula a função objetivo."""
    Fobj = 0.0

    for k in range(v.Nexp):
        VarEnt = np.copy(v.X[k, :])

        # Populando variáveis globais específicas do experimento K
        g.Tbanho = np.copy(g.Tempbanho[k, :])
        g.tempo = np.copy(v.tempoexp[k, :])
        g.T0 = v.X[k, 17]  # Índice 17 em Python = 18 no Fortran
        g.P0 = g.Pr0[k]
        g.M0 = v.X[k, 2]   # Índice 2 em Python = 3 no Fortran
        g.Solv0 = g.Solvente0[k]

        # Roda o modelo
        VarSai = modelo(VarEnt, Param)
        v.Y[k, :] = VarSai[:]

        # Desvios (Calculados - Medidos)
        EY = v.Y[k, :] - v.YM[k, :]

        # Máxima Verossimilhança: EY.T * EVYinv * EY
        erro_ponderado = EY.T @ v.EVYinv[k, :, :] @ EY

        Fobj += (1.0 - g.infomod) * erro_ponderado
        Fobj += g.infomod * g.Peso

    return Fobj