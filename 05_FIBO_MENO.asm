; ********* PROGRAMMA TEST ************
.orig		x3000
		LD	R0,interoN	; carico in R0 il valore intero N

; ********** SOTTOPROGRAMMA ***********

; FIBO_MENO				; nome del sottoprogramma

		ST	R1,store1	; contenuto R1 -> in cella indirizzo store1
		ST	R2,store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3,store3	; contenuto R3 -> in cella indirizzo store3
		ST	R4,store4	; contenuto R4 -> in cella indirizzo store4
	
		AND	R0,R0,R0	; verifico il valore presente in R0
		BRNZ	out_zero	; se trovo N minore o uguale a zero vado a output_zero

; da qui numero N � posiTivo 

		ADD	R0,R0,#-2	; verifico se il numero � 1 (BRn) oppure 2 (BRz)	
		BRN	out_uno		; se trovo N uguale a 1 -> output_1 (specifica)
		BRZ	out_due		; se trovo N uguale a 2 -> output_2 (specifica)
		
; da qui il numero N � maggiore di 2 altrimenti avrei bypassato questa parte di codice
		
		AND	R1,R1,#0	; azzero il registro R1 da impostare come (Fn-1)
		AND	R2,R2,#0	; azzero il registro R2 da impostare come (Fn-2)
		
		ADD 	R1,R1,#2	; imposto R1 come Fn-1 = 2 (da specifica)
		ADD 	R2,R2,#1	; imposto R2 come Fn-2 = 1 (da specifica)
		
ciclo		NOT	R4,R1		; in R4 -> NOT bit a bit di R1 (attenzione a questo)
		ADD	R4,R4,#1	; Ca2 di R1 = -R4 (-Fn-1) -> per sottrazione di Fn
		
		ADD	R3,R2,R4	; calcolo Fn = Fn-2 - Fn-1 (R2+(-R4))
		ADD	R0,R0,-1	; decremento di 1 il valore di R0
		BRZ	out_n		; se ottengo zero la sequenza da calcolare � terminata
					; e vado ad emetterla in output....
					; altrimenti.....
		ADD	R2,R1,#0	; Fn-1 diventa Fn-2 (contenuto R1 -> in R2)
		ADD	R1,R3,#0	; Fn diventa Fn-1 (contenuto R3 -> in R1)
		BRNZP	ciclo		; rieseguo il ciclo per il calcolo di nuove Fn sino a R0 = 0

out_zero	AND	R0,R0,#0	; restituisco in output R0 = zero (come da specifica)
		BRNZP   fine		; vado alla fine del sottoprogramma

out_uno		AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R0,#1	; restituisco in output R0 = 1 (come da specifica)
		BRNZP   fine		; vado alla fine del sottoprogramma

out_due		AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R0,#2	; restituisco in output R0 = 2 (come da specifica)
		BRNZP   fine		; vado alla fine del sottoprogramma

out_n		AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R3,#0	; restituisco in output R0 = R3 = Fn (come da specifica)
	
fine		LD	R1,store1	; contenuto cella indirizzo store1 -> in R1
		LD	R2,store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3,store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4,store4	; contenuto cella indirizzo store4 -> in R4

;		RET			; ritorno da sottoprogramma

; ************ VARIABILI PROGRAMMA e SOTTOPROGRAMMA *************

store1		.blkw	1		; riservo una cella memoria per contenuto R1
store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4

interoN
;		.fill	#-4
;		.fill	#0
;		.fill	#1
;		.fill	#2
;		.fill	#3
		.fill	#10

.end					; fine sottoprogramma