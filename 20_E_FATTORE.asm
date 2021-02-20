; ********** PROGRAMMA TEST *************

.orig		x3000
		LD	R0, int_pos_N	; acquisisco in R0 un num intero positivo N
		LD	R1, int_pos_F	; acquisisco in R1 un num intero positivo F
		
; ********* SOTTORPROGRAMMA *************

; E_FATTORE	
		ST	R2, store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3
		ST	R4, store4	; contenuto R4 -> in cella indirizzo store4
				
		AND	R2,R2,#0	; azzero il registro contatore
		NOT 	R0,R0
		ADD	R0,R0,#1	; Ca2 valore R0 per confronto
		ADD	R4,R1,#0	; contenuto R1 -> contenuto R4
ciclo		ADD	R3,R4,R0	; confronto tra numero F e N
		BRZ	output_ok	; se risultato zero "divisione perfetta"
		BRP	output_zero	; se risultato positivo "non divisibilità"
					; se negativo bisogna proseguire sin quando
					; non si ottiene uno zero o un positivo
		ADD 	R4,R4,R1	; incremento di F il valore di R4
		ADD	R2,R2,#1	; incremento di 1 il contatore R2
		BRNZP	ciclo		; ripeto il ciclo sino ad ottenere
					; un risultato nullo o negativo nel confronto

output_ok	ADD	R0,R2,#1	; contenuto R2 + 1 -> in R0 (come da specifica)	
		BRNZP	fine		; vado a fine sottoprogramma
	
output_zero	AND	R0,R0,#0	; output R0 = 0 (come da sapecifica)
		BRNZP	fine		; vado a fine sottoprogramma

fine		LD	R2, store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store4 -> in R4

;		RET			; ritorno da sottoprogramma

; ********** VARIABILI SOTTOPROGRAMMA e PROGRAMMA ***********

store2		.blkw 1			; riservo una cella memoria per contenuto R2
store3		.blkw 1			; riservo una cella memoria per contenuto R2
store4		.blkw 1			; riservo una cella memoria per contenuto R2

int_pos_N	.fill #100
;int_pos_F	.fill #5	
;int_pos_F	.fill #6
;int_pos_F	.fill #1
int_pos_F	.fill #110

.end