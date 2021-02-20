; ******** PROGRAMMA TEST ***********

.orig		x3000
		LEA	R0, arrayI_init	; in R0 <- indirizzo inizio arrayI (di interi)
		LEA	R1, arrayI_fine	; in R1 <- indirizzo fine arrayI (di interi)
		LEA	R2, arrayS	; in R0 <- indirizzo inizio arrayS (vuoto)

; ******** SOTTOPROGRAMMA ***********

; SEGNO_ARRAY				; nome sottoprogramma

		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3		
		ST	R4, store4	; contenuto R4 -> in cella indirizzo store4
		ST	R5, store5	; contenuto R5 -> in cella indirizzo store5
		ST	R6, store6	; contenuto R6 -> in cella indirizzo store6

		AND	R4,R4,#0	; contatore numeri negativi
		AND	R5,R5,#0	; contatore numeri positivi
		AND	R6,R6,#0	; contatore numeri nulli
	
		NOT 	R1,R1
		ADD	R1,R1,#1	; in R1 <- Ca2 di R1 (ovvero -R1)
		
ciclo		ADD	R3,R0,R1	; in R3 <- confronto arrayI_init - arrayI_fine
		BRP	fine		; arrayI_init > arraI_fine -> array terminato
					; quindi si va a fine sottorpogramma
			
		LDR	R3,R0,#0	; in R3 <- valore cella puntata da R0
		BRN	negativo	
		BRZ	nullo
		BRP 	positivo

negativo	AND	R3,R3,#0	; azzero R3 poichè precedentemente utilizzato 
		ADD	R3,R3,#-1	; in R3 <- valore "-1" per output (num negativo)
		ADD	R4,R4,#1	; incremento contatore numeri negativi
		BRNZP	scrivi		; vado scrivere valore R3 in cella puntata da R2
		
positivo	AND	R3,R3,#0	; azzero R3 poichè precedentemente utilizzato 
		ADD	R3,R3,#1	; in R3 <- valore "1" per output (num positivo)
		ADD	R5,R5,#1	; incremento contatore numeri positivi
		BRNZP	scrivi		; vado scrivere valore R3 in cella puntata da R2

nullo		AND	R3,R3,#0	; azzero R3 precedentemente utilizzato (per output)
		ADD	R6,R6,#1	; incremento contatore numeri nulli
		BRNZP	scrivi		; vado scrivere valore R3 in cella puntata da R2

scrivi		STR	R3,R2,#0	; valore R3 in cella puntata da R2 (arrayS)	
		ADD	R0,R0,#1	; incremento cella puntata da R0 (arrayI)
		ADD	R2,R2,#1	; incremento cella puntata da R2 (arrayS)
		BRNZP	ciclo		; ripeto ciclo sino termine array (vedi confronto)

fine		ADD	R0,R4,#0	; in R0 <- valore R4 (contatore numeri negativi)
		ADD	R1,R6,#0	; in R1 <- valore R6 (contatore numeri nulli)
		ADD	R2,R5,#0	; in R2 <- valore R5 (contatore numeri positivi)

		LD	R3, store3	; in R3 <- contenuto cella indirizzo store3
		LD	R4, store4	; in R4 <- contenuto cella indirizzo store4
		LD	R5, store5	; in R5 <- contenuto cella indirizzo store5
		LD	R6, store6	; in R6 <- contenuto cella indirizzo store6

; 		RET			; ritorno da sottoprogramma

;********* VAR / COST *****************

store3		.blkw	1		; riservo una cella di memoria per contenuto R3
store4		.blkw	1		; riservo una cella di memoria per contenuto R4
store5		.blkw	1		; riservo una cella di memoria per contenuto R5
store6		.blkw	1		; riservo una cella di memoria per contenuto R6

arrayI_init	.fill	#1		; inizio arrayI
		.fill	#-3
		.fill	#0
		.fill	#-121
arrayI_fine	.fill	#90		; fine arrayI

arrayS		.blkw	5		; riservo 5 celle di memoria per arrayS (vuoto)

.end					; fine programma