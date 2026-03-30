import numpy as np
import variaveis as v
import global_vars as g
import parametros_fixos as pf

def fortran_to_float(val):
    """Converte strings numéricas do Fortran (ex: 1.0d0) para float do Python."""
    return float(val.lower().replace('d', 'e'))

def ler_dados_limpos(caminho_arquivo):
    """Lê um arquivo de dados, remove comentários e ignora textos/rótulos (Comportamento Fortran)."""
    dados = []
    with open(caminho_arquivo, 'r') as f:
        for linha in f:
            # Pega tudo antes do símbolo '!' e troca vírgulas por espaços
            linha_limpa = linha.split('!')[0].replace(',', ' ')
            for x in linha_limpa.split():
                try:
                    # Tenta converter para número
                    dados.append(fortran_to_float(x))
                except ValueError:
                    # Bateu em uma letra/texto? Ignora o resto dessa linha e vai pra próxima
                    break
    return dados

def leitura():
    """Lê os arquivos de dados e aloca as variáveis de ambiente."""
    
    # Lendo dimensões do problema
    lines = ler_dados_limpos('dadosexp.dat')
    v.Nexp = int(lines[0])
    v.NVent = int(lines[1])
    v.NData = int(lines[2])
        
    v.NVSai = v.NData * 2 + 4
    
    # Alocando matrizes
    v.XM = np.zeros((v.Nexp, v.NVent))
    v.X = np.zeros((v.Nexp, v.NVent))
    v.YM = np.zeros((v.Nexp, v.NVSai))
    v.Y = np.zeros((v.Nexp, v.NVSai))
    v.EVY = np.zeros((v.Nexp, v.NVSai, v.NVSai))
    v.EVYinv = np.zeros((v.Nexp, v.NVSai, v.NVSai))
    v.tempoexp = np.zeros((v.Nexp, v.NData))
    g.Pr0 = np.zeros(v.Nexp)
    g.Solvente0 = np.zeros(v.Nexp)
    g.Tempbanho = np.zeros((v.Nexp, v.NData + 1))
    v.Texp = np.zeros((v.Nexp, v.NData + 1))
    g.Tbanho = np.zeros(v.NData + 1)
    g.tempo = np.zeros(v.NData)

    # Lendo exp.dat
    data = ler_dados_limpos('exp.dat')
        
    ptr = 0 # Ponteiro de leitura
    
    for i in range(v.Nexp):
        g.T0 = data[ptr] + 273.15; ptr += 1
        g.Pr0[i] = data[ptr]; ptr += 1
        g.Tempbanho[i, 0] = data[ptr] + 273.15; ptr += 1
        
        for k in range(v.NData):
            v.tempoexp[i, k] = data[ptr]; ptr += 1
            v.YM[i, k] = data[ptr] + 273.15; ptr += 1
            v.Texp[i, k] = v.YM[i, k]
            g.Tempbanho[i, k+1] = data[ptr] + 273.15; ptr += 1
            
        v.Texp[i, v.NData] = v.Texp[i, v.NData-1]
        
        for k in range(v.NData):
            desvio = data[ptr]; ptr += 1
            v.EVY[i, k, k] = (1.2 * desvio)**2.0
            
        for k in range(v.NData, v.NVSai - 4):
            v.YM[i, k] = data[ptr]; ptr += 1
            
        for k in range(v.NData, v.NVSai - 4):
            desvio = data[ptr]; ptr += 1
            v.EVY[i, k, k] = desvio**2.0
            
        v.YM[i, v.NVSai - 4] = data[ptr]; ptr += 1 # cis
        v.YM[i, v.NVSai - 3] = data[ptr]; ptr += 1 # trans
        v.YM[i, v.NVSai - 2] = data[ptr]; ptr += 1 # Mn
        v.YM[i, v.NVSai - 1] = data[ptr]; ptr += 1 # Mw
        
        for k in range(v.NVSai - 4, v.NVSai - 2):
            desvio = data[ptr]; ptr += 1
            v.EVY[i, k, k] = desvio**2.0
            
        for k in range(v.NVSai - 2, v.NVSai):
            desvio = data[ptr]; ptr += 1
            v.EVY[i, k, k] = desvio**2.0
            
        g.Solvente0[i] = data[ptr]; ptr += 1
        C0 = data[ptr]; ptr += 1
        M0 = data[ptr]; ptr += 1
        X0 = data[ptr]; ptr += 1
        
        # Preenchendo XM
        v.XM[i, 0] = C0
        v.XM[i, 1] = 0.0
        v.XM[i, 2] = M0
        v.XM[i, 3:8] = [0.0, 0.0, 0.0, 0.0, X0]
        v.XM[i, 8:11] = 0.0
        v.XM[i, 11:14] = [1e-20, 1e-20, 0.0] # beta_0, beta_1, beta_2
        v.XM[i, 14:17] = [1e-20, 1e-20, 0.0] # lambda_0, lambda_1, lambda_2
        v.XM[i, 17] = g.T0
        v.XM[i, 18] = g.T0
        v.XM[i, 19] = pf.PM * M0 / pf.rho_M + pf.PM_S * g.Solvente0[i] / pf.rho_S

    v.X = np.copy(v.XM)