; ********* PROGRAMMA TEST ***********

.orig		x3000
		LEA	R0, stringa	; indirizzo stringa (array) -> in R0

; ******** SOTTOPROGRAMMA ***********

; KCAL					; nome sottoprogramma

		ST	R1, store1	; contenuto R1 in cella indirizzo store1
		ST	R2, store2	; contenuto R2 in cella indirizzo store2
		ST	R3, store3	; contenuto R3 in cella indirizzo store3
		ST	R4, store4	; contenuto R4 in cella indirizzo store4
		ST	R5, store5	; contenuto R5 in cella indirizzo store5
		ST	R6, store6	; contenuto R6 in cella indirizzo store6

		LD R2, car_P		; in R2 <- contenuto cella indirizzo car_P
		LD R3, car_F 		; in R3 <- contenuto cella indirizzo car_F
		LD R4, car_S 		; in R4 <- contenuto cella indirizzo car_S

		AND	R6,R6,#0	; inizializzo a zero R6 (contatore Kcal)
		
ciclo		LDR	R1,R0,#0	; in R1 <- valore puntato da R0
		BRZ	fine		; se trovo zero -> stringa terminata -> fine
		ADD	R0,R0,#1	; incremento di una cella indirizzo in R0
		
		ADD	R5,R1,R2	; verifico se "P" -> se trovo -> piano
		BRZ	piano		; se risultato è zero ho trovato "P"
		
		ADD	R5,R1,R3	; verifico se "F"-> se trovo -> fossato
		BRZ	fossato		; se risultato è zero ho trovato "F"
		
		ADD	R5,R1,R4	; verifico se "S" -> se trovo -> salita
		BRZ	salita		; se risultato è zero ho trovato "S"
		
		BRNP	ciclo		; non ho trovato nè "P", ne "F", nè "S"
					; (non previsto espliticamente da specifica)

piano		ADD	R6,R6,#1	; incremento contatore di 1 Kcal
		brnzp	ciclo		; ritorno a scandire la stringa

fossato		ADD	R6,R6,#2	; incremento contatore di 2 Kcal
		brnzp	ciclo		; ritorno a scandire la stringa

salita		ADD	R6,R6,#4	; incremento contatore di 4 Kcal
		brnzp	ciclo		; ritorno a scandire la stringa

fine		ADD	R0,R6,#0	; contenuto R6 -> in R0 (come da specifica)
		
		LD	R1, store1	; contenuto cella indirizzo store 1 -> in R1
		LD	R2, store2	; contenuto cella indirizzo store 2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store 3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store 4 -> in R4
		LD	R5, store5	; contenuto cella indirizzo store 5 -> in R5
		LD	R6, store6	; contenuto cella indirizzo store 6 -> in R6

; 	RET

; *********** VARIABILI ************

stringa		.stringz "PPFPSPFSSP"

car_P		.fill	#-80		; codice ASCII (negativo) carattere "P"
car_F		.fill	#-70		; codice ASCII (negativo) carattere "F"
car_S		.fill	#-83		; codice ASCII (negativo) carattere "S"

store1		.blkw	1		; riservo una cella memoria per contenuto R1
store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4
store5		.blkw	1		; riservo una cella memoria per contenuto R5
store6		.blkw	1		; riservo una cella memoria per contenuto R6

.end					; fine programma