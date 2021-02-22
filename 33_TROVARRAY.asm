; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato TROVARRAY riceve nei registri R0 e R1 gli indirizzi delle
prime celle di memoria contenenti due array A e B di numeri interi in complemento a due.
I due array A e B sono ordinati per valori crescenti, non contengono mai più di una volta uno stesso numero e
sono terminati dal valore 0 che NON viene considerato un numero degli array.
Il sottoprogramma inoltre, verifica se la sequenza di numeri che compongono l’array B è presente identica anche
nell’array A oppure no. 
Se la risposta è affermativa, il sottoprogramma restituisce nel registro R0 l’indice dell’elemento di A 
da cui inizia la sequenza trovata (dove il primo elemento ha indice 1, il secondo 2 e così via)
altrimenti restituisce nel registro R0 il valore zero.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

;********* PROGRAMMA TEST ********

.orig		x3000
		LEA	R0, arrayA	; in R0 <- indirizzo arrayA di interi
		LEA	R1, arrayB	; in R1 <- indirizzo arrayB di interi

; ******* SOTTOPROGRAMMA *********

; TROVARRAY				; nome sottoprogramma

		ST	R2, store2	; contenuto R2 -> cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> cella indirizzo store3
		ST	R4, store4	; contenuto R4 -> cella indirizzo store4
		ST	R5, store5	; contenuto R5 -> cella indirizzo store5

		AND	R4,R4,#0	; registro indice arrayA
		ADD	R4,R4,#1	; indice arraya parte da "1"
		AND	R5,R5,#0	; check seq arrayB non trovata in arrayA

	
ciclo		LDR	R3,R1,#0	; in R3 <- valore puntato da R1 (arrayB)
		BRZ	fine_b		; se zero -> sequenza arrayB finita 
		
		LDR	R2,R0,#0	; in R2 valore puntato da R0 (arrayA)
		BRZ	no_seq		; se zero > sequenza arrayA finita
					; ma non finita arrayB -> seq uguale non possibile

		NOT	R3,R3
		ADD	R3,R3,#1	; Ca2 di R3 -> -R3 (per sottrazione/confronto)
		ADD	R3,R2,R3	; confronto (sottraggo) i due elementi
		BRN	primo_min	; se risultato negativo -> primo < secondo
		BRP	no_seq		; se positivo -> no seq perchè primo > secondo
					; altrimenti sono uguali....
		
		ADD	R5,R5,#1	; check seq inizio arrayB trovata in arrayA
		
		ADD	R0,R0,#1	; incremento cella arrayA puntata da R0
		ADD	R1,R1,#1	; incremento cella arrayB puntata da R0
		BRNZP	ciclo		; ripeto il ciclo sino a termine sequenze (/0)
		

primo_min	AND	R5,R5,R5	; verifico conteneuto R5 (check seq)
		BRP	no_seq		; se positivo -> seq uguale non possibile
					; altrimenti....
		ADD	R0,R0,#1	; incremento cella puntata R0 (array A)	
		ADD	R4,R4,#1	; incremento indice (arrayA)
		BRNZP 	ciclo		; ripeto il ciclo per confronto degli array
	
fine_b		AND	R5,R5,R5	; verifico conteneuto R5 (check seq) 
		BRP	output		; se positivo sequenza ok -> output "indice"
					; altrimenti....

no_seq		AND	R4,R4,#0	; azzero registro indice arrayA (specifica)
		
output		ADD	R0,R4,#0	; in R0 -> indice arrayA seq_init oppure zero 

		LD	R2, store2	; in R2 <- contenuto cella indirizzo store2
		LD	R3, store3	; in R3 <- contenuto cella indirizzo store3
		LD	R4, store4	; in R4 <- contenuto cella indirizzo store4
		LD	R5, store5	; in R5 <- contenuto cella indirizzo store5

; 		RET			; ritorno da sottoprogramma

; ***** VAR / COST **********

store2		.blkw	1		; riservo una cella di memoria per contenuto R2
store3		.blkw	1		; riservo una cella di memoria per contenuto R3
store4		.blkw	1		; riservo una cella di memoria per contenuto R4
store5		.blkw	1		; riservo una cella di memoria per contenuto R5

arrayA
		.fill 	#-9
		.fill 	#-5
		.fill 	#2
;		.fill	#3
		.fill 	#6
		.fill 	#12
;		.fill 	#15
;		.fill 	#18
;		.fill 	#20
		.fill	#0
arrayB
;		.fill 	#-9
		.fill 	#-5
		.fill 	#2
;		.fill	#3
		.fill 	#6
;		.fill 	#12
;		.fill 	#15
;		.fill	#18
;		.fill	#21
		.fill	#0

.end					; fine programma
