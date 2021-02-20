; ********* PROGRAMMA TEST *************

.orig		x3000
		LEA	R0, array	; in R0 <- indirizzo inizio array
		LD	R1, stringa	; in R1 <- stringa 16 bit binaria

; ********* SOTTOPROGRAMMA *************

; OR_ARRAY				; nome del sottoprogramma
		
		ST	R2, store2	; contenuto R2 -> in cella ind store2
		ST	R3, store3	; contenuto R3 -> in cella ind store3

		NOT	R1,R1		; NOT stringa confronto in R1 (a) = NOT(a)
ciclo		LDR	R2,R0,#0	; in R2 <- 16 bit della cella ind in R0
		BRZ	fine		; se terminatore -> vado alla fine
		NOT	R2,R2		; NOT stringa in array (b) = NOT(b)
		AND	R3,R2,R1	; NOT(a) AND NOT (b) -> in R3
		NOT 	R3,R3		; NOT (a OR b) -> a OR b
		STR	R3,R0,#0	; scrivo in cella ind R0 il contenuto di R3
		ADD	R0,R0,#1	; incremento ind array (avanzo di una cella)
		BRNZP	ciclo		; ripeto ciclo sino a terminatore (zero)

fine		LD	R2, store2	; contenuto cella ind store2 -> in R2
		LD	R3, store3	; contenuto cella ind store3 -> in R3

; 		RET			; ritorno da sottorpogramma

; *********** VARIABILI ****************

store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3

array		.fill	b0000111100001111
		.fill	b0011001100110011
		.fill	b1100110011001100
		.fill	b0000000000000000

stringa		.fill   b1111000011110000

.end					; fine programma