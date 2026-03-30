# Equivalente ao SolventenHexano.F90
import numpy as np
import psat
from psat_nhexano import psat_nhexano
# import parametros_fixos as pf # Será ativado quando traduzirmos ParametrosFixos

def solvente_n_hexano(phi_pol, Solv, V, temp, pf):
    """Retorna a tupla (Cp_S, Solvg_DeltaH_vap_dT)"""
    al = 151.99247739
    bl = -0.10500919
    cl = 0.00082671

    P_S_sat = psat_nhexano(temp)

    # Capacidade calorifica do n-hexano liquido
    Cp_S = (al + bl*temp + cl*temp**2)
    Cp_S_dT = al*(temp-pf.Tref) + (bl*(temp-pf.Tref)**2)/2.0 + (cl*(temp-pf.Tref)**3)/3.0

    ag = -4.33726689
    bg = 0.5662083
    cg = -0.00025022

    # Capacidade calorifica do n-hexano gasoso
    Cp_Sg = (ag + bg*temp + cg*temp**2)
    Cp_Sg_dT = (ag*(temp-pf.Tref) + (bg*(temp-pf.Tref)**2)/2.0 + (cg*(temp-pf.Tref)**3)/3.0)

    phi_S = (Solv * pf.PM_S / pf.rho_S) / V
    P_S = phi_S * (np.exp(phi_pol + pf.chi*(phi_pol**2))) * P_S_sat

    cg0 = pf.DeltaH_vap_ref_S
    cg2 = pf.V_reator
    cg4 = phi_S
    cg6 = phi_pol

    # Equação longa particionada para legibilidade
    termo1 = cg4 * np.exp(cg6 + pf.chi * cg6**2) * psat.pbSn / (temp + psat.pcSn)**2 * np.exp(psat.paSn - psat.pbSn / (temp + psat.pcSn)) * psat.cteSn * (cg2 - V) / pf.Rcte2 / temp * (cg0 + Cp_Sg_dT - Cp_S_dT)
    termo2 = -cg4 * np.exp(cg6 + pf.chi * cg6**2) * np.exp(psat.paSn - psat.pbSn / (temp + psat.pcSn)) * psat.cteSn * (cg2 - V) / pf.Rcte2 / temp**2 * (cg0 + Cp_Sg_dT - Cp_S_dT)
    termo3 = cg4 * np.exp(cg6 + pf.chi * cg6**2) * np.exp(psat.paSn - psat.pbSn / (temp + psat.pcSn)) * psat.cteSn * (cg2 - V) / pf.Rcte2 / temp * (Cp_Sg - Cp_S)

    Solvg_DeltaH_vap_dT = termo1 + termo2 + termo3

    return Cp_S, Solvg_DeltaH_vap_dT