# Equivalente ao RES.F90
import numpy as np
from taxa import taxareac

def res(t, y, yprime, rpar, var_globais, pf):
    """Resíduo para solver DAE (Differential-Algebraic Equations)"""
    R = taxareac(t, y, rpar, var_globais, pf)
    delta = np.zeros(20)
    
    # Componentes diferenciais padrao
    delta[0:19] = yprime[0:19] - R[0:19]
    
    # Restrição algébrica na última posição (V) - índices ajustados para 0-based
    delta[19] = yprime[19] - (yprime[12] + yprime[9])*pf.PM/pf.rho_Pol - (yprime[2]*pf.PM/pf.rho_M) 

    return delta