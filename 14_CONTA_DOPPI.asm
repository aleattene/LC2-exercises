; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato CONTA_DOPPI riceve nel registro R0 l’indirizzo della
prima cella di una zona di memoria contenente una sequenza di numeri a 16 bit in complemento a 2; 
il valore 0 (zero) termina la sequenza e non ne fa parte.
Il sottoprogramma inoltre, restituisce nel registro R0 il conteggio di quante volte un numero 
della sequenza è seguito dal suo doppio.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ************ ESEMPIO FUNZIONAMENTO SOTTOPROGRAMMA ************

	   INPUT				OUTPUT
R0    x3408 	x3408 	   5 		R0    3 	x3408 	    5
		x3409 	  10 				x3409 	   10
		x340A 	  -3 				x340A 	   -3
		x340B 	  -6 				x340B 	   -6
		x340C 	 -12 				x340C 	  -12
		x340D 	   0 				x340D 	    0

; ********** PROGRAMMA TEST ************

.orig		x3000
		LEA	R0, arrayN	; in R0 <- indirizzo inizio arrayN

; ********** SOTTOPROGRAMMA ************

; CONTA_DOPPI				; nome sottoprogramma

		ST	R1, store1	; contenuto R1 -> in cella indirizzo store1
		ST	R2, store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3
		ST	R4, store4	; contenuto R4 -> in cella indirizzo store4
		
		AND	R4,R4,#0	; azzero registro contatore per doppi
	
		LDR	R1,R0,#0	; in R1 <- contenuto cella ind R0
		BRZ	fine		; se trovo zero sequenza terminata -> fine
		ADD	R0,R0,#1	; incremento di 1 indirizzo array N (in R0)
ciclo		LDR	R2,R0,#0	; in R1 <- contenuto cella ind R0 + 1
		BRZ	fine		; se trovo zero sequenza terminata -> fine
		ADD	R0,R0,#1	; incremento di 1 indirizzo array N (in R0)
		NOT 	R1,R1
		ADD	R1,R1,#1	; Ca2 primo numero per confronto successivo 
		ADD	R3,R2,R1	; primo confronto numeri (ottengo event.metà)
		ADD	R3,R3,R1	; secondo confronto numeri
		BRZ	doppio		; se ottengo zero -> n+1 = 2 n
		ADD	R1,R2,#0	; altrimenti si avanza (a partire da n+1)
					; ovvero secondo numero diventa primo numero
		BRNZP	ciclo		; .... e si ripete il ciclo
		
doppio		ADD	R4,R4,#1	; incremento contatore numeri successivi doppi
		ADD	R1,R2,#0	; si avanza (a partire da n+1), ovvero secondo
					; numero diventa primo numero
		BRNZP	ciclo		; ..... e si ripete il ciclo

fine		ADD	R0,R4,#0	; contenuto R4 -> in R0 (come da specifica)

		LD	R1, store1	; contenuto cella indirizzo store1 -> in R1
		LD	R2, store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store4 -> in R4	

;		RET			; ritorno da sottoprogramma

; ********** VARIABILI SOTTOPROGRAMMA e PROGRAMMA *************

store1		.blkw	1		; riservo una cella memoria per contenuto R1
store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4

arrayN		.fill #5
		.fill #10
		.fill #-3
		.fill #-6
		.fill #-12
		.fill #0

.end					; fine programma
