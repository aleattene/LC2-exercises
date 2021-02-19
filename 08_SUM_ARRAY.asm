; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato SUM_ARRAY riceve:
- nei registri R0 e R1 gli indirizzi delle prime celle di due array di interi (cioè di due zone di memoria
	contenenti due sequenze di numeri a 16 bit in complemento a due); le sequenze hanno uguale
	lunghezza e sono terminate dal valore 0 (zero) che non fa parte dei valori da considerare
- nel registro R2 l’indirizzo della prima cella di una zona di memoria libera, di lunghezza pari a quella
delle sequenze di cui sopra.
Il sottoprogramma inoltre:
- somma a ciascun numero della sequenza puntata da R0 il corrispondente numero nella sequenza
	puntata da R1 e sostituisce tale somma ai numeri della sequenza puntata da R0;
- inserisce in ciascuna cella della zona di memoria puntata da R2 i valori:
	-  0 se la somma dei corrispondenti valori puntati da R0 e R1 è corretta;
	-  1 se si è verificato overflow;
	- -1 se si è verficato underflow.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

************ ESEMPIO FUNZIONAMENTO SOTTOPROGRAMMA ************

	   INPUT				  OUTPUT
R0   X3408	x3408 	   112 		R0      -	x3408 	   100
R1   X340D 	x3409 	 20000 		R1 	-	x3409	-24536
R2   X3412 	x340A 	-25000 		R2 	-	x340A 	 18536
		x340B 	    45 				x340B 	    60
		x340C 	     0 				x340C  	     0
		x340D 	   -12 				x340D 	   -12
		x340E 	 21000 				x340E 	 21000
		x340F 	-22000 				x340F 	-22000
		x3410 	    15 				x3410 	    15
		x3411 	     0 				x3411 	     0
		x3412 	     -				x3412        0
		x3413 	     -				x3413 	     1
		x3414        -				x3414 	    -1
		x3415 	     -				x3415 	     0

; ********** PROGRAMMA TEST *************

.orig		X3000
		LEA	R0, array_1	; in R0 <- indirizzo inizio array_1
		LEA	R1, array_2	; in R1 <- indirizzo inizio array_2
		LEA	R2, array_3	; in R2 <- indirizzo inizio array_3

; ********** SOTTOPROGRAMMA *************
		
; SUM_ARRAY				; nome sottoprogramma

		ST	R3, store3	; contenuto R3 -> in cella ind store3
		ST	R4, store4	; contenuto R4 -> in cella ind store4
		ST	R5, store5	; contenuto R5 -> in cella ind store5
		
		AND 	R5,R5,#0	; azzero registro indicatore traboccamenti

		ADD	R3,R0,#0	; in R3 <- indirizzo contenuto in R0 (array_1)
ciclo		LDR	R0,R3,#0	; in R0 <- valore cella puntata da R3 (ex R0)
		BRZ	fine		; se zero -> sequenza terminata -> fine
		BRP	num1_pos	; primo numero positivo
		BRN	num1_neg	; primo numero negativo
	
num1_pos	ADD	R3,R3,#1	; incremento indirizzo array_1
		LDR	R4,R1,#0	; in R4 <- valore cella puntata da R1
		BRZ	fine
		BRP	conc_pos	; rischio overflow
		BRN	discordi	; no rischio traboccamento

num1_neg	ADD	R3,R3,#1	; incremento indirizzo array_1
		LDR	R4,R1,#0	; in R4 <- valore cella puntata da R1
		BRZ	fine		; se zero -> sequenza terminata -> fine
		BRN	conc_neg	; rischio underflow
		BRP	discordi	; no rischio traboccamento		
		
conc_pos	ADD	R1,R1,#1	; incremento indirizzo array_2
		ADD	R0,R0,R4	; in R0 <- somma R0 + R4 (cont array 2)
		BRP	output		; se risultato positivo -> corretto -> output
		BRNZ	overflow	; se risultato nullo/negativo -> overflow

conc_neg	ADD	R1,R1,#1	; incremento indirizzo array_2
		ADD	R0,R0,R4	; in R0 <- somma R0 + R4 (cont array 2); 
		BRN	output		; se risultato negativo -> corretto -> output
		BRZP	underflow	; se risultato nullo/positivo -> ounderflow

discordi	ADD	R1,R1,#1	; incremento indirizzo array_2
		ADD	R0,R0,R4	; in R0 <- somma R0 + R4 (cont array 2); 
		BRNZP	output		; vado in output (come da specifica)
	
overflow	ADD	R5,R5,#1	; registro traboccamenti = 1 (specifica overflow)
		BRNZP	output		; vado in output (come da specifica)

underflow	ADD	R5,R5,#-1	; registro traboccamenti = -1 (specifica underflow)
		BRNZP	output		; vado in output (come da specifica)

output		STR	R5,R2,#0	; contenuto R5 -> cella indirizzata R2 (array_3)
		ADD	R2,R2,#1	; incremento indirizzo array_3
		AND 	R5,R5,#0	; azzero registro indicatore traboccamenti
		BRNZP	ciclo		; ripeto ciclo sino a terminare sequenza (array_1)

fine		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store4 -> in R4
		LD	R5, store5	; contenuto cella indirizzo store5 -> in R4

; 		RET			; ritorno da sottoprogramma

; ************ VARIABILI ****************

store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4
store5		.blkw	1		; riservo una cella memoria per contenuto R5

array_1		.fill #112
		.fill #20000
		.fill #-25000
		.fill #45
		.fill #0

array_2		.fill #-12
		.fill #21000
		.fill #-22000
		.fill #15
		.fill #0

array_3		.blkw	4

.end					; fine programma
