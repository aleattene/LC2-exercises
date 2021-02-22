; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato OVER_UNDER riceve nei registri R0 e R1 
due numeri a 16 bit in complemento a due ed effettua la somma R0 + R1, 
restituendola nel registro R0 al programma chiamante, indicando se:
- il risultato è corretto (R1 = 0)
- si è verificato overflow (R1 = 1)
- si è verificato underflow (R1 = -1).
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ************* PROGRAMMA TEST ***********

.orig		x3000
		LD	R0, num1	; ricevo in R0 il primo numero
		LD	R1, num2	; ricevo in R1 il secondo numero
				
; ************* SOTTOPROGRAMMA **********

; OVER_UNDER				; nome sottoprogramma
		
		AND 	R0,R0,R0	; verifico il valore contenuto in R0
		BRN	num1_neg	; primo numero negativo
		BRP	num1_pos	; primo numero positivo
		BRZ	discordi	; no rischio traboccamento

num1_neg	AND 	R1,R1,R1        ; verifico il valore contenuto in R1
		BRNZ	conc_neg		; rischio underflow
		BRP	discordi	; non rischio traboccamento

num1_pos	AND 	R1,R1,R1        ; verifico il valore contenuto in R1
		BRN	discordi	; no rischio traboccamento
		BRZP	conc_pos	; rischio overflow

conc_neg	ADD	R0,R0,R1	; in R0 metto la somma R0 + R1
		BRN	corretto	; no underflow
		BRZP	underflow

conc_pos	ADD	R0,R0,R1	; in R0 metto la somma R0 + R1
		BRP	corretto	; no overflow
		BRNZ	overflow	; overflow

discordi	ADD	R0,R0,R1	; in R0 metto la somma R0 + R1
		BRNZP	corretto
		
corretto	AND	R1,R1,#0	; restituisco in output R1 = 0
		BRNZP	fine

underflow	AND	R1,R1,#0	; resetto il registro R1
		ADD	R1,R1,#-1	; restituisco in output R1 = -1
		BRNZP	fine

overflow	AND	R1,R1,#0	; resetto il registro R1	
		ADD	R1,R1,#1	; restituisco in output R1 = 1
		BRNZP	fine

fine		brnzp	fine
		
		; RET 
				
;*********** VARIABILI PROGRAMMA ****************

num1	.fill	#32767
;num1	.fill	#-32768

num2	.fill	#1
;num2	.fill	#-1
;num2	.fill	#0

.end
	