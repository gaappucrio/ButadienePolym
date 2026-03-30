import numpy as np
from solvente_n_hexano import solvente_n_hexano
from monomero import monomero

def taxareac(t, Y, Rpar, g, pf):
    """Retorna as derivadas R (Taxa de cada componente) e Balanço de Energia"""
    R = np.zeros(20)
    
    # Extraindo Y (O Python começa no índice 0, então Y(1) vira Y[0])
    C      = Y[0]
    M      = Y[2]
    cis    = Y[3]
    trans  = Y[4]
    vinil  = Y[5]
    b      = Y[6]
    mu_0   = Y[8]
    mu_1   = Y[9]
    mu_2   = Y[10]
    beta_0 = Y[11]
    beta_1 = Y[12]
    beta_2 = Y[13]
    Temp   = Y[17]
    Tc     = Y[18]
    V      = Y[19]

    # Parâmetros do modelo
    k1c = 10.0**Rpar[0]
    k1t = 0.0
    kpc = 10.0**Rpar[2]
    kpt = (10.0**Rpar[1]) * kpc
    kb1 = 10.0**Rpar[3]
    ktm = (10.0**Rpar[4]) * 0.0096
    kdP = 0.0
    
    # Detecção automática do coeficiente de transferência de calor (UA)
    # Baseado na temperatura de referência inicial do experimento (T0)
    T0_celsius = g.T0 - 273.15
    if T0_celsius > 65.0:
        # Se for o experimento de 70°C ou 80°C
        UA = 0.918772 * 0.131604e3
    else:
        # Se for o experimento de 60°C
        UA = 1.38451 * 0.131604e3

    # Capacidades Caloríficas
    Cp_H2O = (8.712 + 0.00125*Temp - 0.00000018*(Temp**2)) * pf.Rcte     
    Cp_pol = 52.63 + 0.178*Temp                               
    phi_pol = ((beta_1 + mu_1) * pf.PM / pf.rho_Pol) / V

    # Termodinâmica (Agora integrados com sucesso!)
    Cp_S, Solvg_DeltaH_vap_dT = solvente_n_hexano(phi_pol, g.Solv, V, Temp, pf)
    Cp_M, Cp_M_dT, Mg_DeltaH_vap_dT = monomero(phi_pol, M, V, Temp)

    beta_3 = beta_2*(2*beta_0*beta_2 - beta_1**2)/(beta_0*beta_1) if (beta_0*beta_1) != 0 else 0

    # Equações diferenciais de Massa
    R[0] = -(k1c + k1t)*(M/V)*(C/V)*V + kdP*(mu_0/V)*V 
    R[1] = 0.0
    R[2] = -(k1c + k1t)*(M/V)*(C/V)*V -(kpc + kpt + ktm)*(M/V)*(mu_0/V)*V 
    R[3] = k1c*(M/V)*(C/V)*V + kpc*(mu_0/V)*(M/V)*V                                                                                   
    R[4] = k1t*(M/V)*(C/V)*V + kpt*(mu_0/V)*(M/V)*V                                                                                 
    R[5] = kdP*(mu_0/V)*V
    R[6] = 2.0*(mu_0/V)*(kb1*(beta_1/V))*V
    R[7] = 0.0    
    R[8] = (k1c + k1t)*(M/V)*(C/V)*V - kdP*(mu_0/V)*V 
    R[9] = (k1c + k1t)*(M/V)*(C/V)*V + ktm*((mu_0/V)-(mu_1/V))*(M/V)*V + (kpc + kpt)*(mu_0/V)*(M/V)*V - kdP*(mu_1/V)*V + kb1*(mu_0/V)*(beta_2/V)*V      
    R[10] = (k1c + k1t)*(M/V)*(C/V)*V + ktm*((mu_0/V)-(mu_2/V))*(M/V)*V + (kpc + kpt)*((mu_0/V) + 2.0*(mu_1/V))*(M/V)*V - kdP*(mu_2/V)*V + kb1*(2.0*(mu_1/V)*(beta_2/V) + (mu_0/V)*(beta_3/V))*V 
    R[11] = - kb1*(beta_1/V)*(mu_0/V)*V + kdP*(mu_0/V)*V + ktm*(M/V)*(mu_0/V)*V
    R[12] = - kb1*(beta_2/V)*(mu_0/V)*V + kdP*(mu_1/V)*V + ktm*(M/V)*(mu_1/V)*V
    R[13] = - kb1*(beta_3/V)*(mu_0/V)*V + kdP*(mu_2/V)*V + ktm*(M/V)*(mu_2/V)*V
    R[14:17] = 0.0

    # Balanço de Energia (Totalmente ativado)
    Rp = -R[2] 
    Cp_pol_dT = 52.63*(Temp-pf.Tref) + 0.178*((Temp-pf.Tref)**2)/2.0
    
    deltaH = pf.DeltaH_ref + Cp_pol_dT - Cp_M_dT
    
    DTML = abs((Temp+pf.eps-g.Tb)-(Temp-Tc)) / np.log(abs(((Temp+pf.eps-g.Tb)/(Temp-Tc + pf.eps))))
    CALOR = np.sign(Temp-Tc) * (UA*DTML)
    
    R[17] = (Rp*(-deltaH) - CALOR) / (g.M0*Cp_M + g.Solv0*Cp_S + Solvg_DeltaH_vap_dT + Mg_DeltaH_vap_dT)
    R[18] = (CALOR/pf.MM_H2O**2 + pf.vazao*pf.rho_H2O*Cp_H2O*(g.Tb-Tc)/pf.MM_H2O) / (pf.Vc*Cp_H2O*pf.rho_H2O/pf.MM_H2O)   
    R[19] = 0.0

    return R