# modelo_din.py
import numpy as np
from scipy.integrate import solve_ivp
import variaveis as v

def res_din(t, y, rpar):
    """Equações diferenciais para o modelo_din."""
    # Constantes
    R = 8.314
    dn = 960.0
    por = 0.6
    v0 = 19.0
    bet = 10.0
    Tamb = 298.0
    
    # Parâmetros
    NA = rpar[0]
    NB = rpar[1]
    Aa = rpar[2]
    Ba = rpar[3]
    Ab = rpar[4]
    Bb = rpar[5]
    
    m = rpar[6]
    Temp = rpar[7]
    
    TrA = 673.0
    TrB = 673.0
    
    KA = np.exp(Aa + Ba*((Temp-TrA)/Temp))
    KB = np.exp(Ab + Bb*((Temp-TrB)/Temp))
    
    v_vol = v0 * Temp / Tamb
    Pa = y[0] * R * Temp
    
    d1 = y[0]*R*Temp / (((KA*y[0]*R*Temp)+1)**2)
    d2 = y[0]*R*Temp / (((KB*y[0]*R*Temp)+1)**2)
    d3 = KA*bet*Ba*TrA / (Temp**2)
    d4 = KB*bet*Bb*TrB / (Temp**2)
    d5 = KA*R*Temp / (((KA*y[0]*R*Temp)+1)**2)
    d6 = KB*R*Temp / (((KB*y[0]*R*Temp)+1)**2)
    d7 = KA*y[0]*R / (((KA*y[0]*R*Temp)+1)**2)
    d8 = KB*y[0]*R / (((KB*y[0]*R*Temp)+1)**2)
    
    dy_dt = np.zeros(1)
    # y[0] = Ca
    dy_dt[0] = (-y[0]*v_vol*dn/m + dn*(-NA*(d1*d3+bet*d7) - NB*(d2*d4+bet*d8))) / (1 + dn*(NA*d5+NB*d6))
    
    return dy_dt

def modelo_din(NVent, NVsai, Npar, VarEnt, Param):
    """Integra o modelo_din."""
    VarSai = np.zeros(NVsai)
    
    rpar = np.zeros(20)
    rpar[0:Npar] = Param
    rpar[Npar:Npar+NVent] = VarEnt
    
    y = np.array([0.0]) # Condição inicial
    t_atual = 0.0
    
    for i in range(NVsai):
        tout = v.tempo[i]
        rpar[7] = v.Temp[i] # rpar(8)
        
        sol = solve_ivp(
            fun=lambda t, y: res_din(t, y, rpar),
            t_span=(t_atual, tout),
            y0=y,
            method='BDF',
            atol=1e-8,
            rtol=1e-8
        )
        
        if not sol.success:
            VarSai[:] = 1e10
            break
        else:
            y = sol.y[:, -1]
            VarSai[i] = y[0]
            t_atual = tout
            
    return VarSai