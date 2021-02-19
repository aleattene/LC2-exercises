; ********* DESCRIZIONE SOTTOPROGRAMMA **********
Il seguente sottoprogramma denominato SUM_ASS_ARRAY riceve:
- nei registri R0 e R1 gli indirizzi delle prime celle di due array di interi 
	(cioè di due zone di memoria contenenti due sequenze di numeri a 16 bit in 
	complemento a due); le sequenze hanno uguale lunghezza e sono terminate dal valore 0 (zero) 
	che non fa parte dei valori da considerare;
- nel registro R2 l’indirizzo della prima cella di una zona di memoria libera, di lunghezza pari a 
	quella delle sequenze di cui sopra.
Il sottoprogramma somma il valore assoluto di ciascun numero della sequenza puntata da R0 con il
valore assoluto del corrispondente numero nella sequenza puntata da R1 e inserisce tale somma nella
corrispondente cella della zona di memoria puntata da R2. 
Non viene effettuato il controllo di eventuali overflow.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ********* PROGRAMMA TEST **********

.orig		x3000
		LEA	R0, array_1	; in R0 <- indirizzo iniziale array_1
		LEA	R1, array_2	; in R1 <- indirizzo iniziale array_2
		LEA	R2, array_3	; in R2 <- indirizzo iniziale array_3
		
; ********** SOTTOPROGRAMMA **********

; SUM_ASS_ARRAY				; nome sottoprogramma

		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3
		ST	R4, store4	; contenuto R4 -> in cella indirizzo store4
		ST	R5, store5	; contenuto R5 -> in cella indirizzo store5				

ciclo		LDR	R3,R0,#0	; in R3 <- contenuto cella indirizzata da R0
		BRZ	fine		; se zero -> sequenza finita -> fine
		BRN	val_ass1	; se negativo -> calcolare valore assoluto
					; altrimenti prosegui.....	
num1_pos	LDR	R4,R1,#0	; in R4 <- contenuto cella indirizzata da R1
		BRZ 	fine		; se zero -> sequenza finita -> fine
		BRN	val_ass2	; se negativo -> calcolare valore assoluto
					; altrimenti prosegui.....

somma		ADD	R5,R3,R4	; in R5 <- somma |R3| + |R4|
		STR	R5,R2,#0	; contenuto R5 -> cella indirizzata da R2
		ADD	R0,R0,#1	; incremento una cella array_1 (indir in R0)
		ADD	R1,R1,#1	; incremento una cella array_2 (indir in R1)
		ADD	R2,R2,#1	; incremento una cella array_3 (indir in R3)
		BRNZP	ciclo		; eseguo il ciclo sino a fine sequenza (zero)

val_ass1	NOT	R3,R3		
		ADD	R3,R3,#1	; valore assoluto di R3 (alias Ca2 di R3)
		BRNZP	num1_pos	; primo pos -> si passa al secondo numero

val_ass2	NOT	R4,R4
		ADD	R4,R4,#1	; valore assoluto di R4 (alias Ca2 di R3)
		BRNZP	somma		; si passa alla somma di due num positivi

fine		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store4 -> in R4
		LD	R5, store5	; contenuto cella indirizzo store5 -> in R5

; 		RET			; ritorno da sottoprogramma

; ************* VARIABILI **************

store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4
store5		.blkw	1		; riservo una cella memoria per contenuto R5

array_1		.fill #12
		.fill #-12
		.fill #32767
		.fill #-32767
		.fill #0

array_2		.fill #3
		.fill #-3
		.fill #1
		.fill #1
		.fill #0

array_3		.blkw	4

.end					; fine programma
