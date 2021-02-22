  ; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato CERCA_POS riceve:
- nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente in ciascuna cella un numero
	a 16 bit in complemento a 2 (il valore 0 – zero – indica il termine della sequenza);
- nel registro R1 un numero a 16 bit in complemento a 2.
Il sottoprogramma inoltre, restituisce nel registro R0 la posizione del numero ricevuto nel registro R1 all'interno
della sequenza (dove il primo numero della sequenza ha posizione 1, il secondo 2, ecc.). 
Se il numero cercato non esiste nella sequenza, il sottoprogramma restituisce il valore 0.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ************ ESEMPIO FUNZIONAMENTO SOTTOPROGRAMMA ************

           INPUT 			         OUTPUT
R0    x3408	x3408   -56 		R0     3 	x3408    -56
R1 	 -9 	x3409 	 15 				x3409 	  15
		x340A 	 -9 				x340A 	  -9
		x340B 	 12 				x340B 	  12
		x340C  	 27 				x340C 	  27
		x340D 	  0 				x340D 	   0

; ********** PROGRAMMA TEST **********

.orig		x3000
		LEA	R0,arrayM	; in R0 indirizzo arrayM
		LD	R1, num		; in R1 numero a 16 bit

; ********* SOTTOPROGRAMMA ***********

; CERCA_POS	
		ST	R2,store2	; contenuto R2 in cella indirizzo store2
		ST	R3,store3	; contenuto R3 in cella indirizzo store3
		ST	R4,store4	; contenuto R4 in cella indirizzo store4

		AND	R3,R3,#0	; inizializzo a zero il registro contatore R3
		AND	R4,R4,#0	; azzero il contatore R4
		
ciclo		LDR	R2,R0,#0	; in R2 valore della cella di indirizzo contenuto in R0
		BRZ	fine_zero	; se trovo uno zero vado a fine sottoprogramma (outputzero)
					; altrimenti.....
		AND	R1,R1,R1	; verifico il contenuto di R1 
		BRZ	fine_zero	; se trovo uno zero vado a fine sottoprogramma (outputzero)
					; altrimenti.....
		ADD	R0,R0,#1	; incremento indirizzo arrayM
		ADD	R3,R3,#1	; incremento il contatore di 1 (indice parte da 1)
		NOT 	R1,R1
		ADD	R1,R1,#1	; Ca2 numero contenuto in R1 per confronto (sottrazione)
		ADD	R4,R2,R1	; confronto i due numeri
		BRZ	fine		; se ottengo zero i due numeri sono uguali
					; quindi esco e riporto l'indice della sequenza
		BRNP	ciclo		; altrimenti ripeto ciclo (scorro arrayM sino a term. zero)

fine_zero	AND	R3,R3,#0	; azzero contatore R3 (perchè valore non trovato)
fine		ADD	R0,R3,#0	; contenuto R3 in R0 (come da specifica)

		LD	R2,store2	; ripristino cont cella indir store2 in R2
		LD	R3,store3	; ripristino cont cella indir store3 in R3
		LD	R4,store4	; ripristino cont cella indir store4 in R4

;		RET			; ritorno da sottoprogramma


;********** VARIABILI SOTTORPOGRAMMA e PROGRAMMA **********

store2		.blkw 1			; riservo cella memoria per contenuto R2
store3		.blkw 1			; riservo cella memoria per contenuto R3
store4		.blkw 1			; riservo cella memoria per contenuto R4


arrayM		.fill	#-56
		.fill	#15
		.fill	#-9
		.fill	#12
		.fill	#27
		.fill	#0

;num		.fill	#-56
;num		.fill	#15
num		.fill	#-9
;num		.fill	#12
;num		.fill	#27
;num		.fill	#100
;num		.fill	#0

.end					; fine del programma
