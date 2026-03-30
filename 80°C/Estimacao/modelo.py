# modelo.py
import numpy as np
from scipy.integrate import solve_ivp
import variaveis as v
import global_vars as g
import parametros_fixos as pf
from psat_bd import psat_bd
from psat_nhexano import psat_nhexano
from taxa import taxareac # Função criada no lote anterior

def modelo(VarEnt, Rpar):
    """Integra o modelo matemático ao longo do tempo. Retorna VarSai."""
    VarSai = np.zeros(v.NVSai)
    
    Y = np.copy(VarEnt)
    M0 = Y[2] # Y(3) no fortran
    
    M0g = 0.0 * M0
    M0 = M0 - M0g
    
    g.parS = 2.14643000e-4
    g.Solv0 = g.Solv0 - g.Solv0*g.parS
    
    Solv = g.Solv0
    Vl = Y[19] # Y(20)
    
    Phi_M0 = (M0 * pf.PM / pf.rho_M) / Vl
    Phi_S0 = (g.Solv0 * pf.PM_S / pf.rho_S) / Vl
    
    T02 = g.T0
    P_M_sat0 = psat_bd(T02)
    P_S_sat0 = psat_nhexano(T02)
    
    P_M0 = M0g * pf.Rcte2 * T02 / (pf.V_reator - Vl)
    P_M0 = P_M_sat0 * Phi_M0 + P_M0
    P_S0 = P_S_sat0 * Phi_S0
    PI = g.P0 - P_S0 - P_M0
    
    n_I = PI * (pf.V_reator - Vl) / (pf.Rcte2 * T02)
    Solv_g = P_S0 * (pf.V_reator - Vl) / (pf.Rcte2 * T02)
    Solv = g.Solv0 - Solv_g
    M_g = P_M0 * (pf.V_reator - Vl) / (pf.Rcte2 * T02)
    
    Y[2] = Y[2] - M_g # Monomero liquido
    
    g.Tb = g.Tbanho[0]
    
    # Prepara listas para guardar resultados ao longo de NData
    resultados = []
    
    t_atual = 0.0
    for i in range(v.NData):
        tout = g.tempo[i]
        
        # O método Radau ou BDF do solve_ivp é o equivalente moderno ao DASSL para EDOs stiff
        sol = solve_ivp(
            fun=lambda t, y: taxareac(t, y, Rpar, g, pf),
            t_span=(t_atual, tout),
            y0=Y,
            method='BDF', # Excelente para sistemas rígidos
            atol=1e-6,
            rtol=1e-6
        )
        
        # Atualiza Y para o proximo passo (pegando o ultimo ponto da integracao)
        Y = np.maximum(sol.y[:, -1], 0.0) # Garante que as concentrações sejam >= 0
        t_atual = tout
        
        # Computa valores pós-integração para este passo
        Temp2 = Y[17]
        P_M_sat_i = psat_bd(Temp2)
        P_S_sat_i = psat_nhexano(Temp2)
        
        VSolv = Y[19] - (Y[9]+Y[12])*pf.PM/pf.rho_Pol - Y[2]*pf.PM/pf.rho_M
        Solv_atual = VSolv * pf.rho_S / pf.PM_S
        
        phi_M_i = (Y[2]*pf.PM/pf.rho_M) / Y[19]
        phi_S_i = (Solv_atual*pf.PM_S/pf.rho_S) / Y[19]
        phi_pol_i = 1.0 - phi_M_i - phi_S_i
        
        P_M_i = phi_M_i * np.exp(phi_pol_i + pf.chi*(phi_pol_i**2)) * P_M_sat_i
        P_S_i = phi_S_i * np.exp(phi_pol_i + pf.chi*(phi_pol_i**2)) * P_S_sat_i
        P_I_i = (n_I*pf.Rcte2*Temp2) / (pf.V_reator - Y[19])
        
        Pr_i = P_S_i + P_I_i + P_M_i
        
        g.Tb = g.Tbanho[i+1]
        
        # Guarda estado para montar o VarSai
        resultados.append({
            'Temp': Y[17], 'Pr': Pr_i, 'cis': Y[3], 'trans': Y[4], 'vinil': Y[5],
            'beta_0': Y[11], 'beta_1': Y[12], 'beta_2': Y[13],
            'mu_0': Y[8], 'mu_1': Y[9], 'mu_2': Y[10]
        })

    # Finalizando VarSai
    ult = resultados[-1]
    tot = ult['cis'] + ult['trans'] + ult['vinil']
    cis_final = ult['cis'] / tot if tot != 0 else 0
    trans_final = ult['trans'] / tot if tot != 0 else 0
    
    Mn = (ult['beta_1'] + ult['mu_1']) / (ult['beta_0'] + ult['mu_0']) * pf.PM if (ult['beta_0'] + ult['mu_0']) != 0 else 0
    Mw = (ult['beta_2'] + ult['mu_2']) / (ult['beta_1'] + ult['mu_1']) * pf.PM if (ult['beta_1'] + ult['mu_1']) != 0 else 0

    # Popula array de saída (ajustando os índices conforme Fortran original)
    for idx, r in enumerate(resultados):
        VarSai[idx] = r['Temp']
        VarSai[v.NData + idx] = r['Pr']
        
    VarSai[v.NVSai - 4] = cis_final # NVSai - 3 em 1-based Fortran = NVSai - 4 em Python
    VarSai[v.NVSai - 3] = trans_final
    VarSai[v.NVSai - 2] = Mn
    VarSai[v.NVSai - 1] = Mw

    return VarSai