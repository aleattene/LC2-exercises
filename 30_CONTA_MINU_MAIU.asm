; ****** PROGRAMMA TEST *************

.orig		x3000
		LEA	R0, stringaS	; in R0 <- inizio stringaS (array carat /0)
		LD	R1, ascii_minu	; in R1 <- codice ASCII minuscola


; ****** SOTTOPROGRAMMA **************

; CONTA_MINU_MAIU			; nome sottoprogramma
		
		ST	R2, store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3
		ST	R4, store4	; contenuto R4 -> in cella indirizzo store4
		ST	R5, store5	; contenuto R5 -> in cella indirizzo store5
		ST	R6, store6	; contenuto R6 -> in cella indirizzo store6

		LD 	R2,minu_MAIU	; in R2 <- differenza decimale minu MAIU
		ADD	R2,R1,R2	; in R2 <- codice ASCII MAIUSCOLA
		
		NOT	R2,R2		; per confronto successivo utile Ca2 di R2
		ADD	R2,R2,#1	; -R2 (cod ASCII negativo MAIUSCOLA)

		NOT	R1,R1		; per confronto successivo utile Ca2 di R1
		ADD	R1,R1,#1	; -R1 (cod ASCII negativo minuscola)

		AND	R5,R5,#0	; azzero R5 -> contatore minuscole	
		AND	R6,R6,#0	; azzero R6 -> contatore MAIUSCOLE	
		
ciclo		LDR	R3,R0,#0	; in R3 <- valore cella/car puntata da R0
		BRZ	fine		; se zero (/0) -> fine stringa -> fine
					; altrimenti....
			
		ADD	R4,R3,R1	; in R4 <- confronto "car_stringa/minuscola"			
		BRZ	minu_si		; se risultato zero -> trovata minuscola
					; altrimenti verifico se MAIUSCOLA
		ADD	R4,R3,R2	; in R4 <- confronto "car_stringa/MAIUSCOLA"	
		BRZ	MAIU_si		; se risultato zero -> trovata MAIUSCOLA
					; altrimenti no lettera trovata....
		ADD	R0,R0,#1	; incremnento cella/car puntato da R0
		BRNZP	ciclo		; continuo controllo stringa sino fine (/0)

minu_si		ADD	R5,R5,#1	; incremento contatore minuscole trovate
		ADD	R0,R0,#1	; incremnento cella/car puntato da R0
		BRNZP	ciclo		; continuo controllo stringa sino fine (/0)

MAIU_si		ADD	R6,R6,#1	; incremento contatore MAIUSCOLE trovate
		ADD	R0,R0,#1	; incremnento cella/car puntato da R0
		BRNZP	ciclo		; continuo controllo stringa sino fine (/0)

fine		ADD	R0,R5,#0	; in R0 <- valore R5 (minuscole trovate)
		ADD	R1,R6,#0	; in R1 <- valore R6 (MAIUSCOLE trovate)

		LD	R2, store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store4 -> in R4
		LD	R5, store5	; contenuto cella indirizzo store5 -> in R5
		LD	R6, store6	; contenuto cella indirizzo store6 -> in R6

; 		RET			; ritorno da sottoprogramma

; ****** VAR / COST *************

minu_MAIU	.fill	#-32		; differenza decimale tra minuscola e MAIUSCOLA

store2		.blkw	1		; riservo una cella di memoria per contenuto R2
store3		.blkw	1		; riservo una cella di memoria per contenuto R3
store4		.blkw	1		; riservo una cella di memoria per contenuto R4
store5		.blkw	1		; riservo una cella di memoria per contenuto R5
store6		.blkw	1		; riservo una cella di memoria per contenuto R6

stringaS	.stringz "BUON nON MARTEDI di genNaio 2017 e GeNnaio 2018" ; (3n/4n)

ascii_minu	.fill	#110		; valore decimale lettera "n" (minuscola)

.end					; fine programma test