; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato CONTA_MIN_UGU_MAG riceve:
- nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente una sequenza di numeri
	codificati in complemento a 2 su 16 bit. La sequenza, non ordinata, è terminata dal valore 0 
	(che non fa parte della sequenza);
- nel registro R1 un valore da confrontare codificato in complemento a 2 su 16 bit.
Il sottoprogramma inoltre, restituisce:
- nel registro R0 il conteggio dei numeri della sequenza minori del valore da confrontare;
- nel registro R1 il conteggio dei numeri della sequenza uguali al valore da confrontare;
- nel registro R2 il conteggio dei numeri della sequenza maggiori del valore da confrontare.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; *********** PROGRAMMA TEST ************

.orig		x3000
		LEA	R0, arrayN
		LD	R1, num_conf

; *********** SOTTOPROGRAMMA *************

; CONTA_MINU_UGU_MAG			; nome sottoprogramma
		
		ST	R3, store3	; contenuto R3 -> in cella indir store3
		ST	R4, store4	; contenuto R4 -> in cella indir store4
		ST	R5, store5	; contenuto R5 -> in cella indir store5
		ST	R6, store6	; contenuto R6 -> in cella indir store6

		AND 	R4,R4,#0	; azzero registro contatore num uguali
		AND 	R5,R5,#0	; azzero registro contatore num maggiori
		AND 	R6,R6,#0	; azzero registro contatore num minori
				
ciclo		LDR	R2,R0,#0	; in R2 <- contenuto cella indirizzo in R0
		BRZ	fine		; se trovo 0 (seq finita) -> fine sottoprogramma
		ADD	R0,R0,#1	; incremento di 1 indirizzo arrayN (in R0)
		NOT	R2,R2
		ADD	R2,R2,#1	; Ca2 num_sequenza per confronto con num-conf
		ADD	R3,R1,R2	; confronto tra i due numeri
		BRZ	uguali		; se ottengo zero i due numeri sono uguali
		BRN	maggiore	; se ottengo negativo num_seq > num_conf
		BRP	minore		; se ottengo positivo num_seq < num_conf
		
uguali		ADD	R4,R4,#1	; incremento registro contatore num uguali
		BRNZP	ciclo		; rieseguo il ciclo sino a fine arrayN

maggiore	ADD	R5,R5,#1	; incremento registro contatore num maggiori
		BRNZP	ciclo		; rieseguo il ciclo sino a fine arrayN

minore		ADD	R6,R6,#1	; incremento registro contatore num minori
		BRNZP	ciclo		; rieseguo il ciclo sino a fine arrayN

fine		ADD	R0,R6,#0	; contenuto R6 -> output R0 (come da specifica)
		ADD	R1,R4,#0	; contenuto R4 -> output R1 (come da specifica)
		ADD	R2,R5,#0	; contenuto R5 -> output R2 (come da specifica)

		LD	R3, store3	; contenuto cella indir store3 -> in R3
		LD	R4, store4	; contenuto cella indir store4 -> in R4
		LD	R5, store5	; contenuto cella indir store5 -> in R5
		LD	R6, store6	; contenuto cella indir store6 -> in R6

;		RET			; ritorno da sottoprogramma

; ************** VARIABILI SOTTOPROGRAMMA e PROGRAMMA TEST **************

store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4
store5		.blkw	1		; riservo una cella memoria per contenuto R5
store6		.blkw	1		; riservo una cella memoria per contenuto R6

arrayN		.fill #112
		.fill #-27
		.fill #-12
;		.fill #12
		.fill #-20
		.fill #-12
		.fill #-15
;		.fill #15
		.fill #0
num_conf	.fill #-12
;num_conf	.fill #12

.end					; FINE programma
