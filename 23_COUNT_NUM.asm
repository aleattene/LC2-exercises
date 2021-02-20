; ******* PROGRAMMA TEST *********

.orig		x3000
		LEA	R0, stringaS	; in R0 <- indirizzo inizio stringaS 

; ****** SOTTOPROGRAMMA **********

; COUNT_NUM				; nome sottprogramma

		ST	R1, store1	; contenuto R1 -> in cella indirizzo store1
		ST	R2, store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3
		ST	R4, store4	; contenuto R4 -> in cella indirizzo store4
		ST	R5, store5	; contenuto R5 -> in cella indirizzo store5
		ST	R6, store6	; contenuto R6 -> in cella indirizzo store6

		LD	R2, cifra_x30	; in R2 <- valore "-48" (decim opposto x30)
		LD	R3, cifra_x39	; in R3 <- valore "-57"	(decim opposto x39)
		LD	R4, virgola	; in R4 <- valore "-44"	(decim opposto x2C)
		
		AND	R6,R6,#0	; contatore cifre

ciclo_S		LDR	R1,R0,#0	; in R1 <- valore cella (car/num) puntata da R0
		BRZ	fine		; se zero -> sequenza finita -> fine
		
		ADD	R5,R1,R2	; confronto con caratt maggiori/uguali x30 (-48)
		BRN	no_num		; se risultato negativo -> no numero trovato
		ADD	R5,R1,R3	; confronto con caratt maggiori/uguali x39 (-57)
		BRP 	no_num		; se risultato positivo -> no numero trovato
					; altrimenti .... cifra trovata ( valore 48 - 57 )
; qui cifra trovata 
	
		ADD	R6,R6,#1	; incremento contatore numeri trovati

ciclo_num	ADD	R0,R0,#1	; incremento cella (car/num) puntata da R0
		LDR	R1,R0,#0	; in R1 <- valore cella (car/num) puntata da R0
		BRZ	fine		; se zero -> sequenza finita -> fine
		
		ADD	R5,R1,R4	; confronto car/num con virgola x2C (-44)
		BRZ	ciclo_num	; se virgola ri-ciclo "numero trovato"
		ADD	R5,R1,R2	; confronto con caratt maggiori/uguali x30 (-48)	
		BRN	no_num		; se risultato negativo -> no numero trovato
		ADD	R5,R1,R3	; confronto con caratt maggiori/uguali x39 (-57)
		BRP 	no_num		; se risultato positivo -> no numero trovato
		BRNZ	ciclo_num	; riciclo il "numero trovato" senza incrementare
					; il contatore poichè "sequenza numerica unica"

no_num		ADD	R0,R0,#1	; incremento cella (car/num) puntata da R0
		BRNZP	ciclo_S		; continuo "scansione" stringaS fino termine (/0)

fine		ADD	R0, R6,#0	; in R0 <- contatore numeri R6 (come da specifica)

		LD	R1, store1	; contenuto cella indirizzo store1 -> in R1
		LD	R2, store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store4 -> in R4
		LD	R5, store5	; contenuto cella indirizzo store5 -> in R5
		LD	R6, store6	; contenuto cella indirizzo store6 -> in R6

; 		RET			; ritorno da sottoprogramma

; ******** VAR / COST **********

store1		.blkw	1		; riservo una cella di memoria per contenuto R1
store2		.blkw	1		; riservo una cella di memoria per contenuto R2
store3		.blkw	1		; riservo una cella di memoria per contenuto R3
store4		.blkw	1		; riservo una cella di memoria per contenuto R4
store5		.blkw	1		; riservo una cella di memoria per contenuto R5
store6		.blkw	1		; riservo una cella di memoria per contenuto R6

;stringaS	.stringz "Buon Natale 25 Dicembre 2015" 			; (2)
;stringaS	.stringz "Ho 10 penne da 50 cent per totale di 6,10 IVA inc" 	; (3)
stringaS	.stringz "Ultra Verifica 1,1 ciao 11,2 ciao 1 2 ciao 12 . 0,0"	; (6)

cifra_x30	.fill	#-48		; valore decimale opposto della cifra x30 (esa)
cifra_x39	.fill	#-57  		; valore decimale opposto della cifra x39 (esa)
virgola		.fill	#-44 		; valore decimale opposto della cifra x2C (esa)

.end					; fine programma