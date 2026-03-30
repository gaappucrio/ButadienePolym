import numpy as np
import variaveis as v
import global_vars as g
import parametros_fixos as pf

def fortran_to_float(val):
    return float(val.lower().replace('d', 'e'))

def ler_dados_limpos(caminho_arquivo):
    dados = []
    with open(caminho_arquivo, 'r') as f:
        for linha in f:
            linha_limpa = linha.split('!')[0].replace(',', ' ')
            for x in linha_limpa.split():
                try:
                    dados.append(fortran_to_float(x))
                except ValueError:
                    break
    return dados

def leitura():
    lines = ler_dados_limpos('dadosexp.dat')
    v.Nexp = int(lines[0])
    v.NVent = int(lines[1])
    v.NData = int(lines[2])
        
    v.NVSai = v.NData # Na versão UA, NVSai é igual a NData (sem pressões e polímero)
    
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

    data = ler_dados_limpos('exp.dat')
    ptr = 0 
    
    for i in range(v.Nexp):
        t00_val = data[ptr] + 273.15; ptr += 1
        g.T0 = t00_val # Usamos g.T0 para manter compatibilidade com o resto do sistema
        
        g.Tempbanho[i, 0] = data[ptr] + 273.15; ptr += 1
        
        for k in range(v.NData):
            v.tempoexp[i, k] = data[ptr]; ptr += 1
            v.YM[i, k] = data[ptr] + 273.15; ptr += 1
            v.Texp[i, k] = v.YM[i, k]
            g.Tempbanho[i, k+1] = data[ptr] + 273.15; ptr += 1
            
        v.Texp[i, v.NData] = v.Texp[i, v.NData-1]
        
        # Pula a leitura de pressões e foca nos reagentes
        g.Solvente0[i] = data[ptr]; ptr += 1
        C0 = data[ptr]; ptr += 1
        M0 = data[ptr]; ptr += 1
        X0 = data[ptr]; ptr += 1
        
        v.XM[i, 0] = C0
        v.XM[i, 1] = 0.0
        v.XM[i, 2] = M0
        v.XM[i, 3:8] = [0.0, 0.0, 0.0, 0.0, X0]
        v.XM[i, 8:11] = 0.0
        v.XM[i, 11:14] = [1e-20, 1e-20, 0.0] 
        v.XM[i, 14:17] = [1e-20, 1e-20, 0.0] 
        v.XM[i, 17] = t00_val
        v.XM[i, 18] = t00_val
        v.XM[i, 19] = pf.PM * M0 / pf.rho_M + pf.PM_S * g.Solvente0[i] / pf.rho_S

        # Na versão UA, a variância é CALCULADA, não lida do arquivo
        for k in range(v.NData):
            desvio = 0.14 * v.YM[i, k]
            v.EVY[i, k, k] = (desvio / 130.0)**2.0

    v.X = np.copy(v.XM)