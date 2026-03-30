import numpy as np
import variaveis as v
import global_vars as g
from modelo import modelo

def deriv_p(DrP):
    """Calcula as derivadas do modelo com relação aos parâmetros (Jacobiano numérico)."""
    Npar = g.NPar
    DFP = np.zeros((v.Nexp, v.NVSai, Npar))
    ParamT = np.copy(v.Param)

    for k in range(v.Nexp):
        VarEnt = np.copy(v.X[k, :])

        for i in range(Npar):
            DeltaPar = DrP[i] * np.abs(v.Param[i]) + DrP[i]

            # Perturbação Positiva (+)
            ParamT[i] = v.Param[i] + DeltaPar
            VarSai_up = modelo(VarEnt, ParamT)

            # Perturbação Negativa (-)
            ParamT[i] = v.Param[i] - DeltaPar
            VarSai_down = modelo(VarEnt, ParamT)

            # Calcula a derivada por diferença central
            DFP[k, :, i] = (VarSai_up - VarSai_down) / (2.0 * DeltaPar)

            # Retorna o parâmetro ao seu valor original
            ParamT[i] = v.Param[i]

    return DFP