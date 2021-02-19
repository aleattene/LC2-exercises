; ************** PROGRAMMA TEST ***********

.orig		x3000
		LEA	R0, array_INIT	; in R0 <- indirizzo inizio array
		LEA	R1, array_FINE	; in R1 <- indirizzo fine array

; ************* SOTTOPROGRAMMA ***********

; CONTA_PARI_DISPARI			; nome sottoprogramma
		
		ST	R2, store2	; contenuto R2 -> cella di indir store2
		ST	R3, store3	; contenuto R3 -> cella di indir store3
		ST	R4, store4	; contenuto R4 -> cella di indir store4
		ST	R5, store5	; contenuto R5 -> cella di indir store5

		AND	R4,R4,#0	; azzeramento reg contatore num pari
		AND	R5,R5,#0	; azzeramento reg contatore num dispari
		
		NOT	R1,R1
		ADD	R1,R1,#1	; Ca2 indir fine array (per succ confronto)

ciclo		ADD	R3,R1,R0	; confronto tra fine array e inizio array
		BRP	fine		; se risultato > 0 (positivo) -> array finito
		LDR	R2,R0,#0	; in R2 <- contenuto cella di indir in R0
		ADD	R0,R0,#1	; incremento array (si avanza di una cella)
		AND	R2,R2,#1	; AND tra contenuto R2 e #1
		BRZ	pari		; se risultato � zero -> numero pari
					; altrimenti dispari....
		ADD	R5,R5,#1	; incremento contatore numeri dispari
		BRNZP	ciclo		; si prosegue ciclo sino a fine array

pari		ADD	R4,R4,#1	; incremento contatore numeri pari
		BRNZP	ciclo		; si prosegue ciclo sino a fine array
		
fine		ADD R0,R4,#0		; contenuto R4 -> in R0 (come da specifica)
		ADD R1,R5,#0		; contenuto R5 -> in R1 (come da specifica)

		LD	R2, store2	; contenuto cella di indir store2 -> in R2
		LD	R3, store3	; contenuto cella di indir store3 -> in R3	
		LD	R4, store4	; contenuto cella di indir store4 -> in R4
		LD	R5, store5	; contenuto cella di indir store5 -> in R5

; 		RET			; ritorno da sottoprogramma

; ************** VARIABILI ****************

store2		.blkw	1		; riservo una cella memoria per R2
store3		.blkw	1		; riservo una cella memoria per R3
store4		.blkw	1		; riservo una cella memoria per R4
store5		.blkw	1		; riservo una cella memoria per R5

array_INIT	.fill	#112
		.fill	#-27	
		.fill	#-1232
		.fill	#450
		.fill	#15
array_FINE	.fill	#120

.end					; fine programma