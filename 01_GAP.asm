
; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato GAP riceve nel registro R0 l’indirizzo della prima cella
di un array di interi, ovvero di una zona di memoria contenente una sequenza di numeri 
a 16 bit in complemento a due, non ordinati.
La sequenza è terminata dal valore 0 (zero) che non fa parte dei valori da considerare.
Il sottoprogramma restituisce nel registro R0 la differenza fra il valore massimo 
e il valore minimo dei numeri della sequenza (trascurando eventuali problemi 
di overflow/underflow).
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.


; ************ PROGRAMMA TEST ************

.orig		x3000
		LEA	R0, array		; in R0 <- indirizzo inizio array interi (/0)

; ************ SOTTOPROGRAMMA ************

; GAP						; nome sottoprogramma

		ST	R1, store1		; contenuto R1 -> cella indirizzo store 1
		ST	R2, store2		; contenuto R2 -> cella indirizzo store 2
		ST	R3, store3		; contenuto R3 -> cella indirizzo store 3
		ST	R4, store4		; contenuto R4 -> cella indirizzo store 4
		ST	R5, store5		; contenuto R5 -> cella indirizzo store 5
		
		AND	R2,R2,#0		; inizializzo a zero registro MAX 
		AND	R3,R3,#0		; inizializzo a zero registro min
						; inizializzazioni necessarie in caso di 
						; sequenza vuota -> altrim errore label fine
	
		LDR	R1,R0,#0		; in R1 <- cont cella (prima) indirizzata da R0
		BRZ	fine			; se zero -> sequenza terminata -> fine
		ADD	R2,R1,#0		; in R2 (MAX) <- contenuto prima cella array
		ADD	R3,R1,#0		; in R3 (min) <- contenuto prima cella array

ciclo		ADD	R0,R0,#1		; incremento indirizzamento cella (in R0)
		LDR	R1,R0,#0		; leggo valore successivo array interi
		BRZ	fine			; se zero -> sequenza terminata -> fine

		NOT	R4,R1			; in R4 <- R1 negato 
		ADD	R4,R4,#1		; in R4 <- Ca2 di R1 (alias -R1)
		
		ADD	R5,R2,R4		; in R5 <- risultato confronto "MAX-numero"
		BRZP	val_min			; se nullo/positivo "Max > numero", quindi
						; passare a valutare il minimo -> val_min
						; altrimenti....					
		ADD	R2,R1,#0		; se negativo "numero > MAX" quindi newMAX
		
val_min		ADD	R5,R3,R4		; in R5 <- risultato confronto "min-numero"
		BRNZ	ciclo			; se nullo/negativo "min > numero", quindi
						; valutare numero successivo array -> ciclo
						; altrimenti.....
		ADD	R3,R1,#0		; se positivo "numero < min" quindi newmin
		
		BRNZP	ciclo			; si prosegue ciclo sino a fine sequenza (/0)

fine		NOT	R3,R3
		ADD	R3,R3,#1		; Ca2 del min (-min)
		ADD	R0,R2,R3		; in R0 <- (valore Max - valore Min) 	
			
		LD	R1, store1		; contenuto cella indirizzo store1 -> in R1
		LD	R2, store2		; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3		; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4		; contenuto cella indirizzo store4 -> in R4
		LD	R5, store5		; contenuto cella indirizzo store5 -> in R5		
		
; 		RET				; ritorno da sottoprogramma

; ************ VAR / COST ****************
	
store1		.blkw	1			; riservo una cella memoria per contenuto R1
store2		.blkw	1			; riservo una cella memoria per contenuto R2
store3		.blkw	1			; riservo una cella memoria per contenuto R3
store4		.blkw	1			; riservo una cella memoria per contenuto R4
store5		.blkw	1			; riservo una cella memoria per contenuto R5

array		.fill	#112
		.fill	#-27
		.fill	#-15
		.fill	#45
		.fill	#15
		.fill	#0
	
.end						; fine programma
