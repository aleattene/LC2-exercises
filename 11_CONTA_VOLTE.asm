; ********* PROGRAMMA TEST *********

.orig		x3000
		LEA	R0, stringa	; in R0 <- indirizzo inizio array stringa (/0)
		LD	R1, car_min	; in R1 <- ASCII esadecimale lettera minuscola

; ********** SOTTOPROGRAMMA *********

; CONTA_VOLTE				; nome sottoprogramma

		ST	R2, store2	; contenuto R2 -> cella indirizzata da store2
		ST	R3, store3	; contenuto R3 -> cella indirizzata da store3
		ST	R4, store4	; contenuto R4 -> cella indirizzata da store4
		ST	R5, store5	; contenuto R5 -> cella indirizzata da store5
		ST	R6, store6	; contenuto R6 -> cella indirizzata da store6

		LD	R2, min_maiu	; in R2 <- differenza minuscolo_maiuscolo
		ADD	R2, R2, R1	; in R2 <- codice ASCI MAIUSCOLA
		NOT 	R2,R2
		ADD	R2,R2,#1	; - MAIUSCOLA

		NOT	R1,R1
		ADD	R1,R1,#1	; - minuscola

		AND	R5,R5,#0	; azzero contatore "minuscole trovate"
		AND	R6,R6,#0	; azzero contatore "MAIUSCOLE trovate"

ciclo		LDR	R3,R0,#0	; in R3 <- contenuto cella puntata da R0
		BRZ	fine		; se zero -> sequenza finita -> fine
		ADD	R0,R0,#1	; incremento scorrimento cella puntata da R0
		ADD	R4,R3,R1	; in R4 <- conf car stringa con minuscola
		BRZ	min_trov	; se zero -> car uguali -> minuscola trovata
		ADD	R4,R3,R2	; in R4 <- conf car stringa con MAIUSCOLA
		BRZ	MAIU_trov	; se zero -> car uguali -> MAIUSCOLA trovata	, 
		BRNP	ciclo		; ripeto ciclo sino a termine sequenza (zero)
			
min_trov	ADD	R5,R5,#1	; incremento contatore "minuscole trovate"
		BRNZP	ciclo		; ripeto ciclo sino a termine sequenza (zero)

MAIU_trov	ADD	R6,R6,#1	; incremento contatore "MAIUSCOLE trovate"
		BRNZP	ciclo		; ripeto ciclo sino a termine sequenza (zero)	

fine		ADD	R0,R6,#0	; in R0 <- contenuto R6 (MAIUSCOLE trovate)
		ADD	R1,R5,#0	; in R1 <- contenuto R5 (minuscole trovate)

		LD	R2, store2	; cont cella indirizzo store2 -> in R2
		LD	R3, store3	; cont cella indirizzo store3 -> in R3
		LD	R4, store4	; cont cella indirizzo store4 -> in R4
		LD	R5, store5	; cont cella indirizzo store5 -> in R5
		LD	R6, store6	; cont cella indirizzo store6 -> in R6

; 		RET			; ritorno da sottoprogramma

; ************ VARIABILI/COSTANTI ***************

min_maiu	.fill -32		; differenza (negativa) minuscolo_maiuscolo

store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4
store5		.blkw	1		; riservo una cella memoria per contenuto R5
store6		.blkw	1		; riservo una cella memoria per contenuto R6

stringa		.stringz "Buon Sabato 7 febbraio 2015"

car_min		.fill x62
		
.end					; fine programma