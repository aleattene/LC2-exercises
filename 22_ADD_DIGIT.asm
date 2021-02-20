; *********** PROGRAMMA TEST *************

.orig		x3000
		LD	R0, num_pos	; in R0 <- numero intero positivo
		LD	R1, car_cifra	; in R1 <- carattere ASCII cifra 
					; decimale C (esadecimale x30-x39)

; ********** SOTTOPROGRAMMA **************

; ADD_DIGIT				; nome sottoprogramma

		ST	R2, store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3
		ST	R4, store4	; contenuto R4 -> in cella indirizzo store4
		
		LD	R4, cesa_ndec	; in R4 <- valore decimale -48
					; per trasformare carattere-cifra in cifra
					; decimale corrispondente
		
		AND	R2,R2,#0	; azzero registro contatore R2
		ADD	R2,R2,#8	; impostazione iniziale contatore
					; (ricordare -> numero somme meno due)
		ADD	R3,R0,R0	; in R3 -> sequenza somme (moltiplicazione)

ciclo_C10	ADD	R3,R3,R0	; in R3 -> sequenza somme (moltiplicazione)
		ADD	R2,R2,#-1	; decremento contatore
		BRZ	fine_C10	; se zero -> moltiplicazione terminata
		BRP	ciclo_C10	; se positivo -> proseguire moltiplicazione

fine_C10	ADD	R1,R1,R4	; in R1 <- cifra_car trasformata in decimale
		ADD	R0,R3,R1	; in R0 <- output finale (come da specifiche)
		
		LD	R2, store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store4 -> in R4

; 		RET			; ritorno da sottoprogramma

; ************ VARIABILI *****************	

store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4

cesa_ndec	.fill	#-48		; valore che permette di trasformare un 
					; carattere cifra in una cifra decimale

;num_pos	.fill	#5
num_pos		.fill	#57	

;car_cifra	.fill	x37
car_cifra	.fill	x32

.end					; fine programma