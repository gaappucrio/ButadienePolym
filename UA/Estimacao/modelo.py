import numpy as np
from scipy.integrate import solve_ivp
import warnings

# Suprime os avisos de overflow da tela (deixa o terminal limpo)
warnings.filterwarnings("ignore", category=RuntimeWarning)

import variaveis as v
import global_vars as g
import parametros_fixos as pf
from psat_bd import psat_bd
from psat_nhexano import psat_nhexano
from taxa import taxareac

def modelo(VarEnt, Rpar):
    """Integra o modelo matemático ao longo do tempo. Retorna VarSai."""
    VarSai = np.zeros(v.NVSai)
    
    Y = np.copy(VarEnt)
    M0 = Y[2]
    
    M0g = 0.0 * M0
    M0 = M0 - M0g
    
    g.parS = 2.14643000e-4
    g.Solv0 = g.Solv0 - g.Solv0*g.parS
    
    Solv = g.Solv0
    Vl = Y[19]
    
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
    
    resultados = []
    t_atual = 0.0
    
    for i in range(v.NData):
        tout = g.tempo[i]
        
        try:
            # Integração BDF
            sol = solve_ivp(
                fun=lambda t, y: taxareac(t, y, Rpar, g, pf),
                t_span=(t_atual, tout),
                y0=Y,
                method='BDF',
                atol=1e-6,
                rtol=1e-6
            )
            
            # AIRBAG: Se a integração explodir por um parâmetro ruim do PSO
            if not sol.success:
                raise ValueError("Integração falhou (Runaway Térmico)")
                
            Y = np.maximum(sol.y[:, -1], 0.0)
            t_atual = tout
            g.Tb = g.Tbanho[i+1]
            
            resultados.append({'Temp': Y[17]})
            
        except Exception:
            # Se explodiu, penalizamos a partícula preenchendo o resto com 1e100
            # Isso faz o PSO entender que esse UA é fisicamente impossível
            resultados.append({'Temp': 1e100})
            break

    # Montando a saída
    for idx, r in enumerate(resultados):
        VarSai[idx] = r['Temp']
        
    # Preenche posições não calculadas se ocorreu falha
    for idx in range(len(resultados), v.NData):
        VarSai[idx] = 1e100

    return VarSai