# Equivalente ao Variaveis.f90
# Em Python, declaramos como globais e inicializamos dinamicamente no Principal
Neq = 20  # Numero de equacoes

XM = None  # Variáveis de entrada medidas
X = None
YM = None  # Variáveis de saída medidas
Y = None   # Variáveis de saída calculas pelo modelo
EVY = None # Matriz relativa às variâncias experimentais
EVYinv = None

Nexp = 0   # Número de Experimentos realizados
NVent = 0  # Número de variáveis de entrada
NVsai = 0  # Número de Variáveis de Saída medidas
NData = 0  # Número de pontos de integração

Param = None     # Vetor com os parametros
tempoexp = None  # Vetor tempo
Tempbanho = None
Texp = None

Solvente0 = None
Pr0 = None