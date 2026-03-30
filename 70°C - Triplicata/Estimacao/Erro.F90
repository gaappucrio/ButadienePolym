!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Rotina que retorna mensagens de erro e interrompe a estimação
!
SUBROUTINE Erro(N)
IMPLICIT NONE
INTEGER N

! seleciona o tipo de erro
SELECT CASE (N)
	!Erro 1: 
	CASE (1)
		WRITE(*,*) 'DELX muito grande: A faixa das variaveis independentes esta sendo ultrapassada'
		PAUSE
	!Erro 2: 
	CASE (2)
		WRITE(*,*) 'DELP muito grande: A faixa dos parametros esta sendo ultrapassada'
		PAUSE
	!Erro 3: 
	CASE (3)
		WRITE(*,*) 'Nao eh caracterizada a convergencia para um minimo: Aproximacao linear eh ruim'
		PAUSE
	!Erro 4: 
	CASE (4)
		WRITE(*,*) 'O numero maximo de iteracoes foi excedido'
        PAUSE
	CASE DEFAULT
		WRITE(*,*) 'ERRO'
		PAUSE
END SELECT

STOP
END SUBROUTINE Erro

