import numpy as np
from solvente_n_hexano import solvente_n_hexano
from monomero import monomero

def taxareac(t, Y, Rpar, g, pf):
    """Retorna as derivadas R (Taxa de cada componente) e Balanço de Energia"""
    R = np.zeros(20)
    
    # -------------------------------------------------------------------------
    # CINTO DE SEGURANÇA: O solver BDF as vezes testa valores negativos.
    # Travamos as concentrações em >= 0 e a Temperatura em >= 0°C (273.15 K)
    # -------------------------------------------------------------------------
    Y_safe = np.maximum(Y, 0.0)
    
    C      = Y_safe[0]
    M      = Y_safe[2]
    cis    = Y_safe[3]
    trans  = Y_safe[4]
    vinil  = Y_safe[5]
    b      = Y_safe[6]
    mu_0   = Y_safe[8]
    mu_1   = Y_safe[9]
    mu_2   = Y_safe[10]
    beta_0 = Y_safe[11]
    beta_1 = Y_safe[12]
    beta_2 = Y_safe[13]
    
    Temp   = max(Y[17], 273.15)
    Tc     = max(Y[18], 273.15)
    V      = max(Y[19], 1e-6)

    # Detecção: Cinética (5+ args) ou UA (1 arg)
    if len(Rpar) >= 5:
        k1c = 10.0**Rpar[0]
        k1t = 0.0
        kpc = 10.0**Rpar[2]
        kpt = (10.0**Rpar[1]) * kpc
        kb1 = 10.0**Rpar[3]
        ktm = (10.0**Rpar[4]) * 0.0096
        kdP = 0.0
        
        T0_celsius = g.T0 - 273.15
        if T0_celsius >= 75.0:
            UA = 1.5460 * 0.131604e3
        elif T0_celsius >= 65.0:
            UA = 0.918772 * 0.131604e3
        else:
            UA = 1.38451 * 0.131604e3
    else:
        k1c = 10.0**(-1.970740)
        k1t = 0.0
        kpc = 10.0**(3.175470)
        kpt = (10.0**(-1.915400)) * kpc
        kb1 = 10.0**(-0.929920)
        ktm = (10.0**(2.1)) * 0.0096
        kdP = 0.0
        
        UA = Rpar[0] * 0.131604e3

    # Capacidades Caloríficas
    Cp_H2O = (8.712 + 0.00125*Temp - 0.00000018*(Temp**2)) * pf.Rcte     
    Cp_pol = 52.63 + 0.178*Temp                               
    phi_pol = ((beta_1 + mu_1) * pf.PM / pf.rho_Pol) / V

    # Termodinâmica
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

    # Balanço de Energia
    Rp = -R[2] 
    Cp_pol_dT = 52.63*(Temp-pf.Tref) + 0.178*((Temp-pf.Tref)**2)/2.0
    
    deltaH = pf.DeltaH_ref + Cp_pol_dT - Cp_M_dT
    
    DTML = abs((Temp+pf.eps-g.Tb)-(Temp-Tc)) / np.log(abs(((Temp+pf.eps-g.Tb)/(Temp-Tc + pf.eps))))
    CALOR = np.sign(Temp-Tc) * (UA*DTML)
    
    R[17] = (Rp*(-deltaH) - CALOR) / (g.M0*Cp_M + g.Solv0*Cp_S + Solvg_DeltaH_vap_dT + Mg_DeltaH_vap_dT)
    R[18] = (CALOR/pf.MM_H2O**2 + pf.vazao*pf.rho_H2O*Cp_H2O*(g.Tb-Tc)/pf.MM_H2O) / (pf.Vc*Cp_H2O*pf.rho_H2O/pf.MM_H2O)   
    R[19] = 0.0

    return R