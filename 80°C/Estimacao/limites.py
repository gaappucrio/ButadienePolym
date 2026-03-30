# limites.py
def limites(Ndim, Lim, Var, DelVar, Rpd, ALtol, AL):
    """Testa limites de busca de parâmetros e reduz o passo (AL) se violado."""
    i = 0
    while i < Ndim:
        aux = Var[i] + AL * DelVar[i]
        
        if Lim[i, 0] < aux < Lim[i, 1]:
            i += 1
        else:
            AL = AL / Rpd
            if AL < ALtol:
                # Dispara erro genérico ou customizado (Equivalente ao CALL erro(2))
                raise ValueError("Tolerância do passo (ALtol) atingida na avaliação dos limites.")
                
    return AL