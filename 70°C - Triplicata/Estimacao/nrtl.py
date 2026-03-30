# Equivalente ao NRTL.f90
import numpy as np

def nrtl(x, temp):
    """Retorna os coeficientes gamma(2)"""
    x = np.array(x, dtype=np.float64)
    R = 1.987
    
    A = np.zeros((2, 2))
    A[0, 1] = -136.235961914063
    A[1, 0] = 356.105163574219
    
    alfa = np.zeros((2, 2))
    alfa[0, 1] = 0.3
    alfa[1, 0] = 0.3
    
    tau = A / (R * temp)
    G = np.exp(-alfa * tau)
    
    gamma = np.zeros(2)
    for i in range(2):
        soma = 0.0
        for j in range(2):
            den = G[0, j]*x[0] + G[1, j]*x[1]
            num = tau[i, j] - (x[0]*tau[0, j]*G[0, j] + x[1]*tau[1, j]*G[1, j]) / den
            soma += (x[j] * G[i, j] / den) * num
            
        gamma[i] = np.exp(np.dot(tau[:, i], (G[:, i]*x)) / np.dot(G[:, i], x) + soma)
        
    return gamma