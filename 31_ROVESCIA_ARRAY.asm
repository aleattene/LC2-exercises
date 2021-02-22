; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato ROVESCIA_ARRAY riceve:
- nel registro R0 l’indirizzo della prima cella di un array A di N interi (cioè di una zona di memoria
	simbolicamente indicata con il nome A contenente una sequenza di N numeri a 16 bit 
	in complemento a due). 
	La sequenza è terminata dal valore 0 (zero) che non fa parte dei valori considerati;
- nel registro R1 l’indirizzo della prima cella di un array vuoto di nome R, 
	cioè di una zona di memoria libera, di lunghezza N.
Il sottoprogramma inoltre, riempie l’array R rovesciando l’ordine degli elementi di A: in altre parole,
il primo elemento di R diventa l’ultimo elemento di A, il secondo elemento di R il penultimo di A, e così via.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ********** PROGRAMMA ***********
.orig		x3000
		LEA	R0, arrayA	; metto IN R0 l'indirizzo di arrayA
		LEA	R1, arrayR	; metto in R1 l'indirizzo di arrayR	


; ******** SOTTOPROGRAMMA *******
	
; ROVESCIA_ARRAY		; nome sottoprogramma

; salvataggio registri
	
		ST	R2, store2	; scrivo contenuto R2 in cella indirizzo store2
		ST	R3, store3	; scrivo contenuto R3 in cella indirizzo store3
	
		NOT	R0,R0
		ADD	R0,R0,#1	; Ca2 per sottrazione tra due indirizzi array A e R
		ADD	R4,R0,R1	; conto valori presenti in arrayA (zero compreso)
				; dalla differenza indirrizzo arrayR e arrayA
		ADD	R4,R4,-2	; valore = numero elementi da sommare a ind inziale arrayR
		NOT	R0,R0
		ADD	R0,R0,#1	; ripristino indirizzo corretto arrayA contenuto in R0

ciclo		LDR	R2,R0,#0	; metto in R2 il primo valore di arrayA (indirizzo contenuto in R0)
		BRZ	fine		; se rilevo uno zo zero vado a fine sottorpogramma
				; altrimenti
		ADD	R0,R0,#1	; incremento di 1 l'indirizzo di ARRAY A
		ADD	R3,R1,R4	; metto in R3 il valore di indirizzo finale di arrayR
		STR	R2,R3,#0	; scrivo il contenuto di R2 (valore di arrayA) nellla cella di indirizzo R3 (indirizzo arrayR)
		ADD	R1,R1,#-1	; decremento di 1 l'indirizzo di arrayA (contenuto in R1)		
		brnzp	ciclo		; e ripeto il ciclo si quando non trovo uno zero in arrayA (contenuto in R2)
		
; qui finito , ripristino registri

fine		LD	R2, store2	; metto in R2 il contenuto della cella di indirizzo store2
		LD	R3, store3	; metto in R3 il contenuto della cella di indirizzo store3

;		RET			; ritorno da sottoprogramma


; ******** VARIABILI PROGRAMMA e SOTTOPROGRAMMA *******

arrayA		.fill	#1
		.fill	#3
		.fill	#-5
		.fill	#12
		.fill	#0	

arrayR	.blkw	4

store2	.blkw	1		; riservo una cella memoria per contenuto R2
store3	.blkw	1		; riservo una cella memoria per contenuto R3
		
.end				; fine programma
