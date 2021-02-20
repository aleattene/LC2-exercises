
Il seguente sottoprogramma denominato DIV riceve nei registri R0 e R1 i due numeri N e D,
entrambi positivi codificati in complemento a due (quindi compresi fra 1 e 32767).
Il sottoprogramma inoltre restituisce nel registro R0 il numero intero Q = N/D, ovvero il quoziente 
arrotondato per difetto della divisione N/D.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

;********* PROGRAMMA ***********

.ORIG		x3000
		LD	R0, interoN	; metto in R0 il numero intero positivo N
		LD	R1, interoD	; metto in R1 il numero intero positivo D
	
;********* SOTTOPROGRAMMA **********

; DIV

		ST	R2,store2	; scrivo il contenuto R2 in cella indirizzo store2
		ST	R3,store3	; scrivo il contenuto R3 in cella indirizzo store3
		ST	R4,store4	; scrivo il contenuto R4 in cella indirizzo store4
			
		AND	R2,R2,#0	; azzero il registro R2 (contatore)
		AND	R3,R3,#0	; azzero il registro R3
		AND	R4,R4,#0	; azzero il registro R4

ciclo		ADD 	R3,R3,R1	; metto in R3 il valore D
		ADD	R2,R2,#1	; incremento il contatore di 1 (R2)
		NOT	R3,R3		
		ADD	R3,R3,#1	; Ca2 di R1 per sottrazione
		ADD	R4,R0,R3	; metto in R4 IL RISULTATO di N (num) - D (div)
		brz	fine		; se ottengo zero ho terminato la divisione "perfetta"
		brn	quodif		; se ottengo negativo ho una divisione "eccessiva"
					; altrimenti devo continuare.....
		NOT	R3,R3		
		ADD	R3,R3,#1	; ripristino il valore di R3 (che prima Ca2 per sottrazione)
		brp	ciclo		; e ripeto il ciclo

quodif		ADD	R2,R2,#-1	; decremento il contatore di 1 (specifica quoz. arr. per difetto)
		BRNZP	fine		; vado alla fine del sottoprogramma

fine		ADD	R0,R2,#0	; metto in R0 il valore di R2 (quoziente)	
				
		LD	R2,store2
		LD	R3,store3
		LD	R4,store4
	
;		RET

;************** VARIABILI PROGRAMMA e SOTTOPROGRAMMA ***********

interoN		.fill	#100
;interoD	.fill	#5
;interoD	.fill	#6
;interoD	.fill	#1
interoD		.fill	#110

store2		.blkw	1		; riservo una cella memoria per registro R2
store3		.blkw	1		; riservo una cella memoria per registro R3
store4		.blkw	1		; riservo una cella memoria per registro R4

.END
