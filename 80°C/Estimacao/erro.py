def erro(n):
    """Retorna mensagens de erro e interrompe a estimação lançando uma Exceção."""
    mensagens = {
        1: "DELX muito grande: A faixa das variaveis independentes esta sendo ultrapassada",
        2: "DELP muito grande: A faixa dos parametros esta sendo ultrapassada",
        3: "Nao eh caracterizada a convergencia para um minimo: Aproximacao linear eh ruim",
        4: "O numero maximo de iteracoes foi excedido"
    }
    
    msg = mensagens.get(n, f"ERRO DESCONHECIDO (Código: {n})")
    
    # Interrompe o programa levantando a exceção
    raise RuntimeError(msg)