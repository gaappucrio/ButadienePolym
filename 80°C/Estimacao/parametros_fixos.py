# parametros_fixos.py

MM_H2O = 18.0          # MM agua (g/mol) 
PM = 54.09             # Massa Molar (g/mol) de butadieno
rho_M = 614.9          # densidade butadieno g/L
rho_Pol = 1010.0       # densidade polibutadieno g/L
rho_H2O = 997.0479     # densidade H2O (g/L)

rho_X = 798.0          # g/L
MM_X  = 142.22         # g/mol
rho_C = 881.0          # g/L
MM_C  = 219.33         # g/mol

V_reator = 1.0         # Volume do Reator em Litros
Vc = 0.3553            # Volume da camisa de resfriamento em Litros
vazao = 3.4318         # Vazão de entrada da camisa em Litros/min
chi  = 0.5             # Parâmetro de Flory-Huggins Solv. Pol. 
Rcte  = 8.314          # (J/(mol K)) Constante ideal dos gases
Rcte2 = 0.0830865      # [(bar L)/(mol K)] Constante ideal dos gases 
DeltaH_vap_ref_M = 389.0 / PM   # J/g*(g/mol) a 298k
DeltaH_ref = -73000.0  # Delta H de reacao na temperatura de 298K

Tref = 298.15          # Temperatura de referencia = 298.15 K
eps  = 1e-10           

# solvente n-hexano
PM_S = 86.18           # Massa Molar (g/mol) de n-hexano
rho_S = 654.8          # densidade solvente n-hexano g/L
H_Sref  = -31590.86055 # J/mol a 298k
H_Srefg = -664.0629908 # J/mol a 298K
DeltaH_vap_ref_S = 30926.79756  # J/mol a 298K (-664.0629908 + 31590.86055)