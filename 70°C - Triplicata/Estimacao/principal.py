import numpy as np
import variaveis as v
import global_vars as g
from leitura import leitura
from enxame0 import enxame0

def main():
    print("Iniciando Estimação de Parâmetros...")
    
    # 1. Faz a leitura dos dados experimentais
    leitura()
    print("Fim Leitura dos dados experimentais")
    
    v.Pred = np.zeros((v.Nexp, v.NVSai, v.NVSai))
    
    # 2. Leitura das configurações do otimizador (dadosbusca.dat)
    lines = []
    with open('dadosbusca.dat', 'r') as f:
        for linha in f:
            # Remove vírgulas
            linha_limpa = linha.split('!')[0].replace(',', ' ')
            for x in linha_limpa.split():
                try:
                    lines.append(float(x.lower().replace('d', 'e')))
                except ValueError:
                    # Bateu em uma letra/texto? Pula pro resto da próxima linha (Emula Fortran)
                    break
                    
    ptr = 0
    IST = int(lines[ptr]); ptr += 1
    RegConf = int(lines[ptr]); ptr += 1
    Niter = int(lines[ptr]); ptr += 1
    Npt = int(lines[ptr]); ptr += 1
    
    if Npt == 0: RegConf = 0
    if IST != 0: RegConf = 0
        
    C1 = lines[ptr]; ptr += 1
    C2 = lines[ptr]; ptr += 1
    Wo = lines[ptr]; ptr += 1
    Wf = lines[ptr]; ptr += 1
    
    # Variáveis do método Gauss-Newton
    Rpd = lines[ptr]; ptr += 1
    LB = lines[ptr]; ptr += 1
    Ftol = lines[ptr]; ptr += 1
    ALtol = lines[ptr]; ptr += 1
    alfa = lines[ptr]; ptr += 1
    
    # Número de parâmetros
    g.NPar = int(lines[ptr]); ptr += 1
    NPar = g.NPar
    
    # Trava de segurança extra
    if NPar <= 0:
        raise ValueError(f"O número de parâmetros (NPar) lido é {NPar}, o que é inválido. Verifique o dadosbusca.dat")
        
    v.Param = np.zeros(NPar)
    Plim = np.zeros((NPar, 2))
    
    # Leitura da estimativa inicial dos parâmetros
    for i in range(NPar):
        v.Param[i] = lines[ptr]; ptr += 1
        
    # Leitura da faixa válida para os parâmetros (Plim)
    for i in range(NPar):
        Plim[i, 0] = lines[ptr]; ptr += 1
        Plim[i, 1] = lines[ptr]; ptr += 1

    # Inicializando X com os valores experimentais
    if v.XM is not None:
        v.X = np.copy(v.XM)
        
    # Inversão otimizada
    if v.EVY is not None:
        v.EVYinv = np.linalg.inv(v.EVY) 
        
    # 3. Chamada da otimização
    Fobj = 0.0
    if Npt != 0:
        print(f"Iniciando otimização PSO com {Npt} partículas e {NPar} parâmetros...")
        Fobj = enxame0(IST, RegConf, Niter, Npt, C1, C2, Wo, Wf, Plim)
        print(f"Fim Enxame0. Fobj Final: {Fobj:.6E}")
        
    print("FIM")

if __name__ == "__main__":
    main()