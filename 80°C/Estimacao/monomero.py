# monomero.py
import numpy as np
import parametros_fixos as pf
import psat
from psat_bd import psat_bd

def monomero(phi_pol, M, V, Temp):
    """Calcula propriedades do monômero. Retorna: (Cp_M, Cp_M_dt, Mg_DeltaH_vap_dT)"""
    al = 3.66554521
    bl = 0.30262073
    cl = -0.00013841

    # Cp do Monomero 1,3-butadieno liquido
    Cp_M    = (al + bl*Temp + cl*Temp**2)  
    Cp_M_dT = (al*(Temp-pf.Tref) + bl*(Temp-pf.Tref)**2/2.0 + cl*(Temp-pf.Tref)**3/3.0)

    # Cp do Monomero 1,3-butadieno gasoso
    ag = 3.71294522
    bg = 0.30235431
    cg = -0.00013803

    phi_M = (M * pf.PM / pf.rho_M) / V
    P_M_sat = psat_bd(Temp)
    
    # Pressão parcial de monomero
    P_M = phi_M * (np.exp(phi_pol + pf.chi*(phi_pol**2))) * P_M_sat

    cg0 = pf.DeltaH_vap_ref_M
    cg2 = pf.V_reator
    cg4 = phi_M
    cg6 = phi_pol

    # Termos auxiliares para a equação principal
    T_sub = Temp + psat.pcM
    exp_psat = 10 ** (psat.paM - psat.pbM / T_sub)
    term_ag_bg_cg = (ag * (Temp - pf.Tref) + bg * (Temp - pf.Tref)**2 / 2.0 + cg * (Temp - pf.Tref)**3 / 3.0)
    term_al_bl_cl = (al * (Temp - pf.Tref) + bl * (Temp - pf.Tref)**2 / 2.0 + cl * (Temp - pf.Tref)**3 / 3.0)

    # Expressão particionada para legibilidade e conversão direta do Fortran
    part1 = cg4 * np.exp(cg6 + pf.chi * cg6**2) * exp_psat * psat.pbM * np.log(10.0) * psat.cteM * (cg2 - V) * (cg0 + term_ag_bg_cg - term_al_bl_cl) / T_sub**2 / pf.Rcte2 / Temp
    part2 = - cg4 * np.exp(cg6 + pf.chi * cg6**2) * exp_psat * psat.cteM * (cg2 - V) * (cg0 + term_ag_bg_cg - term_al_bl_cl) / pf.Rcte2 / Temp**2
    part3 = cg4 * np.exp(cg6 + pf.chi * cg6**2) * exp_psat * psat.cteM * (cg2 - V) * ((ag + bg*(Temp-pf.Tref) + cg*(Temp-pf.Tref)**2) - (al + bl*(Temp-pf.Tref) + cl*(Temp-pf.Tref)**2)) / pf.Rcte2 / Temp

    Mg_DeltaH_vap_dT = part1 + part2 + part3

    return Cp_M, Cp_M_dT, Mg_DeltaH_vap_dT