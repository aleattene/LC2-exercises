; ********* PROGRAMMA TEST ************

.orig		x3000
		LD	R0,intero	; porto in R0 il valore intero N

; ********** SOTTOPROGRAMMA ***********

;SEQMOD					; nome sottoprogramma
		ST	R1,store1	; scrivo contenuto R1 in cella di indirizzo store1
		ST	R2,store2	; scrivo contenuto R2 in cella di indirizzo store2
		ST	R3,store3	; scrivo contenuto R3 in cella di indirizzo store3

		AND	R0,R0,R0	; verifico il valore presente in R0
		BRNZ	out_zero	; se trovo N minore o uguale a zero vado a output zero

; da qui in numero N è positivo

		ADD	R0,R0,#-2	; verifico se il numero è 1 (Brn) oppure 2 (Brz)
		BRNZ	out_uno		; se trovo N uguale a 1 o 2 vado ad output_1
		
; da qui il numero N è maggiore di 2
		
		AND	R1,R1,#0	; azzero il registro R1 (Sn-2)
		AND	R2,R2,#0	; azzero il registro R2 (Sn-1)
		ADD 	R1,R1,#1	; imposto R1 come Sn-2 = 1
		ADD 	R2,R2,#1	; imposto R2 come Sn-1 = 1
ciclo		AND	R3,R3,#0	; azzero registro Sn
		ADD	R1,R1,R1	; imposto R1 come 2(Sn-2)
		NOT	R1,R1		;
		ADD	R1,R1,#1	; imposto R1 come -2(SN-2)
		AND	R2,R2,R2	; verifico il valore di R2 (Sn-1)
		BRN	val_ass		; se negativo devo calcolare valore assoluto

		ADD	R3,R2,R1	; risultato Sn
		ADD	R0,R0,-1	; riduco di uno il valore di R0
		BRZ	out_n		; se ottengo zero la sequenza è terminata e vado ad emetterla in output
		ADD	R1,R2,#0	; Sn-1 diventa Sn-2
		ADD	R2,R3,#0	; Sn diventa Sn-1
		BRNZP	ciclo

val_ass		NOT 	R2,R2
		ADD	R2,R2,#1	; imposto R2 come valore assoluto di (Sn-1)
		ADD	R3,R2,R1	; calcolo Sn = |Sn-1|-2(Sn-2)
		ADD	R0,R0,-1	; riduco di uno il valore di R0 (sequenza)
		BRZ	out_n		; se ottengo zero la sequenza è terminata e vado ad emetterla in output
					; altrimenti
		NOT 	R2,R2
		ADD	R2,R2,#1	; ripristino il registro R2 da |Sn-1| a (Sn-1)
		ADD	R1,R2,#0	; Sn-1 diventa Sn-2
		ADD	R2,R3,#0	; Sn diventa Sn-1
		BRNZP	ciclo		; si ripete il ciclo sino al termine della sequenza (R0 = 0)
				
out_zero	AND	R0,R0,#0	; azzero R0 e restituisco in output zero (specifiche)
		BRNZP   fine		; vado a fine sottoprogramma

out_uno		AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R0,#1	; imposto R0 pari ad 1 e restituisco in output 1 (specifiche)
		BRNZP   fine		; vado a fine sottoprogramma
	
out_n		AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R3,#0	; porto il R0 il valore di R3 (Sn calcolata)
		BRNZP   fine		; vado a fine sottoprogramma

fine		LD	R1,store1	; porto in R1 il contenuto cella indirizzo store1
		LD	R2,store2	; porto in R2 il contenuto cella indirizzo store2
		LD	R3,store3	; porto in R2 il contenuto cella indirizzo store2

;		RET			; ritorno da sottoprogramma

; ************ VARIABILI SOTTORPOGRAMMA e PROGRAMMA *************

store1		.blkw	1		; riservo una cella memoria per contenuto R1
store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3


;intero		.fill	#-4
;intero		.fill	#2
intero		.fill	#6

.end					; fine programma
