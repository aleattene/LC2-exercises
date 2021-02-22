; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato SEQVALASS riceve nel registri R0 il numero intero N 
e restituisce sempre in R0 l’ennesimo termine S(N) della sequenza definita nel seguente modo:
			S(N) = S(N-1) – 2 x | S(N-2) |
con S1 = 1 e S2 = 1, dove la notazione | S(N-2) | significa valore assoluto di S(N-2).
Si ipotizza inoltre che S(N = 0) per N ≤ 0
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ************ ESEMPI FUNZIONAMENTO SOTTOPROGRAMMA ************

  INPUT 1	          OUTPUT 1
R0	 9		R0	-85

  INPUT 2	          OUTPUT 2
R0	 2		R0	  1

  INPUT 3	          OUTPUT 3
R0	-4		R0	  0

; ********* PROGRAMMA TEST ********

.orig		x3000
		LD	R0, numN	; in R0 <- numero intero N (positivo/negativo)

; ********* SOTTOPROGRAMMA ***********

; SEQVALASS				; nome sottoprogramma
		
		ST	R1, store1	; contenuto R1 -> in cella indirizzo store1
		ST	R2, store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3	
	
		AND	R1,R1,#0	; azzero R1 -> contenitore Sn-1
		AND	R2,R2,#0	; azzero R2 -> contenitore Sn-2	;
	
		AND	R0,R0,R0	; verifico valore in R0
		BRNZ	output_0	; se N minore/uguale 0 -> Sn = 0 (output)

; qui positivo
		ADD	R0,R0,-2	; se risultato è negativo N = 1 mentre
		BRNZ	output_1	; se nullo N = 2 -> Sn = 1 (output)
					; altrimento N maggiore di 2

; qui N > 2
		ADD	R1,R1,#1	; in R1 <- S2 -> futuro Sn-1
		ADD	R2,R2,#1	; in R2 <- S1 -> futuro Sn-2

ciclo		AND	R2,R2,R2	; verifico se Sn-2 è negativo o meno
		BRN	val_ass		; se negativo -> valore assoluto
					; altrimenti calcolo la sequenza Sn

		ADD	R3,R2,R2	; in R3 <- valore    2 x |Sn-2|
		NOT	R3,R3
		ADD	R3,R3,#1	; in R3 <- valore  - 2 x |Sn-2|
		ADD	R3,R1,R3	; in R3 <- calcolo la sequenza Sn
		
		ADD	R0,R0,#-1	; decremento il valore di N
		BRZ	output_Sn	; se zero sequenza terminata -> output Sn
					; altrimenti si prosegue calcoli new Sn
		
		ADD	R2,R1,#0	; Sn-1 diventa Sn-2
		ADD	R1,R3,#0	; Sn -> diventa Sn-1
		BRNZP	ciclo		; si ripete il calcolo della new Sn

val_ass		NOT	R2,R2
		ADD	R2,R2,#1	; in R2 <- valore assoluto |Sn-2|		
		BRNZP	ciclo

output_0	AND	R0,R0,#0	; output -> R0 = 0 (come da specifica)
		BRNZP	fine		

output_1	AND	R0,R0,#0	; azzero R0	
		ADD	R0,R0,#1	; output -> R0 = 1 (come da specifica)
		BRNZP	fine

output_Sn	ADD	R0,R3,#0	; in R0 <- contenuto R3 (Output Sn)
					; 		come da specifica	

fine		LD	R1, store1	; contenuto cella indirizzo store1 -> in R1
		LD	R2, store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3

; 		RET			; ritorno da sottoprogramma

; ********** VAR/COST ************

store1		.blkw	1		; riservo una cella memoria per contenuto R1	
store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3

;numN		.fill	#-4
;numN		.fill	#2
numN		.fill	#9

.end					; fine programma test
