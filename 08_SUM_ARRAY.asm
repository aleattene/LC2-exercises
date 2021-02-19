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