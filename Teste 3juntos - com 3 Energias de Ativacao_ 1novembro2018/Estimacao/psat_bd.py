# Equivalente ao PsatBD.F90
import psat

def psat_bd(temp):
    """Retorna P_M_sat (P sat do n-hexano em bar)"""
    caso = 1
    if caso == 1:
        return 10**(3.99798 - (941.662 / (temp - 32.653)))
    elif caso == 2:
        return (10**(psat.paM - (psat.pbM / (temp + psat.pcM)))) * psat.cteM
    return 0.0