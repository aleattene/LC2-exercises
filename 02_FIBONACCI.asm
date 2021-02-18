************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato FIBONACCI riceve nel registro R0 il numero intero N e
restituisce sempre in R0 l’ennesimo termine F^N della sequenza di Fibonacci.
Si ricorda che il termine N-esimo della sequenza di Fibonacci è dato da:
		F(N) = F(N-1) + F(N-2)
con F(1) = 1 e F(2) = 1. Si ipotizzi che sia F(N) = 0 per N ≤ 0
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

************ ESEMPIO FUNZIONAMENTO SOTTOPROGRAMMA ************

	INPUT 			OUTPUT
	R0 	10 		R0 	55
	R0 	 2 		R0 	 1
	R0 	-4 		R0 	 0

; ********* PROGRAMMA TEST ************

.orig		x3000
		LD	R0,interoN	; carico in R0 il valore intero N

; ********** SOTTOPROGRAMMA ***********

;FIBONACCI				; nome del sottoprogramma

		ST	R1,store1	; scrivo contenuto R1 nella cella indirizzo store1
		ST	R2,store2	; scrivo contenuto R2 nella cella indirizzo store2
		ST	R3,store3	; scrivo contenuto R3 nella cella indirizzo store3
	
		AND	R0,R0,R0	; verifico il valore presente in R0
		BRNZ	out_zero	; se trovo N minore o uguale a zero vado a output_zero

; da qui numero N posiTivo

		ADD	R0,R0,#-2	; verifico se il numero è 1 (BRn) oppure 2 (BRz)	
		BRNZ	out_uno		; se trovo N uguale a 1 o 2 vado a output_1
		
; da qui numero N maggiore di 2 altrimenti avrei bypassato questa parte di codice
		
		AND	R1,R1,#0	; azzero il registro R1 da impostare come (Fn-2)
		AND	R2,R2,#0	; azzero il registro R2 da impostare come (Fn-1)
		ADD 	R1,R1,#1	; imposto R1 come Fn-2 = 1 (da specifica)
		ADD 	R2,R2,#1	; imposto R2 come Fn-1 = 1 (da specifica)
ciclo		AND	R3,R3,#0	; azzero registro da utilizzare per Fn
		ADD	R3,R2,R1	; calcolo Fn = Fn-1 + Fn-2 (R2+R1)
		ADD	R0,R0,-1	; decremento di 1 il valore di R0
		BRZ	out_n		; se ottengo zero la sequenza da calcolare è terminata
					; e vado ad emetterla in output....
					; altrimenti.....
		ADD	R1,R2,#0	; Fn-1 diventa Fn-2 (contenuto R2 -> contenuto R1)
		ADD	R2,R3,#0	; Fn diventa Fn-1 (contenuto R3 -> contenuto R2)
		BRNZP	ciclo		; rieseguo il ciclo per il calcolo di nuove Sn sino a R0 = 0

out_zero	AND	R0,R0,#0	; restituisco in output R0 = zero (come da specifica)
		BRNZP   fine		; vado alla fine del sottoprogramma

out_uno		AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R0,#1	; restituisco in output R0 = 1 (come da specifica)
		BRNZP   fine		; vado alla fine del sottoprogramma

out_n		AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R3,#0	; restituisco in output R0 = R3 = Sn (come da specifica)
		BRNZP   fine		; vado alla fine del sottoprogramma

fine		LD	R1,store1	; metto in R1 contenuto cella indirizzo store1
		LD	R2,store2	; metto in R2 contenuto cella indirizzo store2
		LD	R3,store3	; metto in R3 contenuto cella indirizzo store3

;		RET			; ritorno da sottoprogramma

; ************ VARIABILI PROGRAMMA e SOTTOPROGRAMMA *************

store1		.blkw	1
store2		.blkw	1
store3		.blkw	1

;interoN	.fill	#-4
;interoN	.fill	#2
interoN		.fill	#10

.end					; fine programma
