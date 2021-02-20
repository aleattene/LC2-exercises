; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato CONTA_N_Z_P riceve:
- nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente in ciascuna cella un numero
	a 16 bit in complemento a 2 (quindi compreso fra -32.768 e + 32.767);
- nel registro R1 l'indirizzo dell'ultima cella della suddetta zona di memoria.
Il sottoprogramma inoltre, restituisce:
- nel registro R0 il conteggio dei numeri della sequenza negativi;
- nel registro R1 il conteggio dei numeri della sequenza nulli;
- nel registro R2 il conteggio dei numeri della sequenza positivi.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ************ ESEMPIO FUNZIONAMENTO SOTTOPROGRAMMA ************

           INPUT 				 OUTPUT
R0    x3408	x3408 	-56 		R0     2 	x3408  	 -56
R1    x340D 	x3409 	 15 		R1     1 	x3409  	  15
      		x340A    -9 		R2     3 	x340A 	  -9
		x340B 	  0 				x340B 	   0
		x340C 	 27 				x340C 	  27
		x340D 	 12 				x340D 	  12

; ********** PROGRAMMA TEST **********

.orig 		x3000
		LEA	R0, arrayINIT	; acquisico in R0 indirizzo inizio zona di memoria
		LEA	R1, arrayFINE	; acquisico in R1 indirizzo inizio zona di memoria

; ********* SOTTOPROGRAMMA **********

; CONTA_N_Z_P				; nome del sottoprogramma
		
		ST	R3,store3	; nella cella di indirizzo store 3 -> contenuto R3
		ST	R4,store4	; nella cella di indirizzo store 4 -> contenuto R4
		ST	R5,store5	; nella cella di indirizzo store 5 -> contenuto R5
		ST	R6,store6	; nella cella di indirizzo store 6 -> contenuto R6

		AND	R4,R4,#0	; azzero R4 = contatore numeri negativi
		AND	R5,R5,#0	; azzero R5 = contatore numeri nulli
		AND	R6,R6,#0	; azzero R6 = contatore numeri positivi		
		
		NOT	R1,R1		
		ADD	R1,R1,#1	; indirizzo arrayFINE "negativo" per confronto successivo			
	
ciclo		ADD	R3,R1,R0	; in R3 differenza indirizzi memoria 
		ADD	R3,R3,#-1	; num celle effettive di memoria da "scandire"
		BRZ	fine		; quando sono a zero "sequenza scandita completamente"
		
		LDR	R2,R0,#0	; in R2 -> valore cella di indirizzo contenuto in R0
		BRN	num_neg		; se trovo un numero negativo vado a num_neg
		BRZ	num_nul		; se trovo un numero nullo vado a num_nul
		BRP	num_pos		; se trovo un numero positivo vado a num_pos

num_neg		ADD	R0,R0,#1	; incremento di 1 indirizzo "array sequenza numerica"
		ADD	R4,R4,#1	; incremento di 1 contatore numeri negativi
		BRNZP	ciclo		; proseguo la scanzione della sequenza celle memoria

num_nul		ADD	R0,R0,#1	; incremento di 1 indirizzo "array sequenza numerica"
		ADD	R5,R5,#1	; incremento di 1 contatore numeri nulli
		BRNZP	ciclo		; proseguo la scanzione della sequenza celle memoria

num_pos		ADD	R0,R0,#1	; incremento di 1 indirizzo "array sequenza numerica"
		ADD	R6,R6,#1	; incremento di 1 contatore numeri positivi
		BRNZP	ciclo		; proseguo la scanzione della sequenza celle memoria

fine		ADD	R0,R4,#0	; contenuto R4 -> output R0 (come da specifica)
		ADD	R1,R5,#0	; contenuto R5 -> output R1 (come da specifica)
		ADD	R2,R6,#0	; contenuto R6 -> output R2 (come da specifica)
		
		LD	R3,store3	; contenuto cella indirizzo store3 -> R3
		LD	R4,store4	; contenuto cella indirizzo store4 -> R4
		LD	R5,store5	; contenuto cella indirizzo store5 -> R5
		LD	R6,store6	; contenuto cella indirizzo store6 -> R6

; 		RET			: ritorno da sottoprogramma

; ************** VARIABILI SOTTOPROGRAMMA e PROGRAMMA ************

store3		.blkw 1			; riservo una cella di memoria per contenuto R3
store4		.blkw 1			; riservo una cella di memoria per contenuto R4
store5		.blkw 1			; riservo una cella di memoria per contenuto R5
store6		.blkw 1			; riservo una cella di memoria per contenuto R6

arrayINIT	.fill	#-56
		.fill	#15
		.fill	#-9
		.fill	#0
		.fill	#27
arrayFINE	.fill	#12	

.end					; fine del programma
