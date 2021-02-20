; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato ANALIZZA_COPPIA riceve nei registri R0 e R1 due
numeri a 16 bit in complemento a 2.
Il sottoprogramma inoltre, restituisce:
- nel registro R0 il valore 0 se i due numeri sono concordi, il valore 1 se sono discordi;
- nel registro R1 il valore 0 se il valore assoluto del primo numero è maggiore o uguale al 
	valore assoluto del secondo, il valore 1 in caso contrario;
- nel registro R2 il valore 0 se la somma dei due numeri NON dà luogo a traboccamenti, 
	il valore 1 in caso contrario.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ************ ESEMPI FUNZIONAMENTO SOTTOPROGRAMMA ************

INPUT 1 				OUTPUT 1
R0     -16 	R1      15 		R0    1 	R1    0 	R2    0

INPUT 2 				OUTPUT 2
R0   30000 	R1   25000 		R0    0 	R1    0 	R2    1

INPUT 3 				OUTPUT 3
R0  -16000 	R1  -20000 		R0    0 	R1    1 	R2    1

; ****** PROGRAMMA TEST *************

.orig		x3000
		LD	R0, primo_num
		LD	R1, sec_num

; ****** SOTTOPROGRAMMA **************

; ANALIZZA_COPPIA
		
		ST	R2, store2

		AND	R2,R2,#0	; registro si/no traboccamento

		AND	R0,R0,R0
		BRZP	primo_pos
		BRN	primo_neg
		
primo_pos	AND	R1,R1,R1
		BRP	conc_pos
		BRNZ	discordi	; discordi -> no rischio traboccamento
		

primo_neg	AND	R1,R1,R1
		BRN	conc_neg
		BRZP	discordi	; discordi -> no rischio traboccamento

conc_pos	ADD	R3,R0,R1	; in R3 <- somma due numeri positivi
		BRZP	no_traboc
		BRN	traboc



discordi	AND	R,R0,#0		
		ADD	R0,R0,#1		; output R0 = 1 (specifica)
no_traboc	ADD 	R2,R2,#0		; output R2 = 0 (specifica)
		BRNZP	fine

trabocc		ADD 	R2,R2,#1		; output R2 = 1 (specifica)

fine		


		LD	R2, store2


; 		RET

; ****** VAR / COST *************

store2		.blkw	1

primo_num
		.fill	#-16
		.fill	#30000
		.fill	#-16000
sec_num
		.fill	#15
		.fill	#25000
		.fill	#-20000

.end
