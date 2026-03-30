# Equivalente ao Psatnhexano.F90
import numpy as np
import psat

def psat_nhexano(temp):
    """Retorna P_S_sat em bar"""
    caso = 2
    if caso == 1:
        al = 7.0105100
        bl = 1246.3300
        cl = 232.98800
        p_sat = 10**(al - bl/((temp - 273.15) + cl)) # mmHg
        return p_sat / 750.0637554 # bar
    elif caso == 2:
        return np.exp(psat.paSn - psat.pbSn / (temp + psat.pcSn)) * psat.cteSn
    return 0.0