; ********* PROGRAMMA TEST *********

.orig		x3000
		LEA	R0, arrayA	; in R0 <- indirizzo inizio arrayA (/0)
		LEA	R1, arrayT	; in R1 <- indirizzo inizio arrayT (vuoto)

; ******** SOTTOPROGRAMMA **********

; TARTAGLIA				; nome sottoprogramma

		ST	R2, store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3
		
		AND 	R2,R2,#0	; azzero registro per T[1] e T[N+1]
		ADD	R2,R2,#1	; registro per T[1] e T[N+1] impostato a 1 
		
		STR	R2,R1,#0	; T[1] = 1 -> in cella puntata da R1 (arrayT)
		
ciclo		ADD	R1,R1,#1	; incremento cella puntata da R1 (arrayT)
		
		LDR	R3,R0,#0	; in R3 <- primo elemento regola Tartaglia
		
		LDR	R4,R0,#1	; in R4 <- secondo elemento regola Tartaglia
		BRZ	fine		; se zero sequenza finita -> fine (T[N+1])
					; altrimenti....
		ADD	R4,R3,R4	; in R4 <- somma due elementi (alias T[I]) 
		STR	R4,R1,#0	; cont R4 -> in cella puntata da R1 (arrayT)	
		ADD	R0,R0,#1	; incremento cella puntata da Ro (arrayA)
		BRNZP	ciclo		; ripeto controllo arrayA sino fine seq (/0)
		
fine		STR	R2,R1,#0	; T[N+1] -> 1 -> ultima cella puntata da R1
		
		LD	R2, store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
	
; 		RET			; ritorno da sottoprogramma

; ******* VAR / COST *************

store2		.blkw	1		; riservo una cella di memoria per contenuto R2
store3		.blkw	1		; riservo una cella di memoria per contenuto R3

arrayA		.fill	#1		; riempo arrayA fittizio per programma test
		.fill	#3
		.fill	#3
		.fill	#1
		.fill	#0

arrayT		.blkw	5		; riservo 5 celle di memoria per arrayT

.end					; fine programma