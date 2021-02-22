; ******** PROGRAMMA TEST **********

.orig		x3000
		LEA	R0, arrayA	; in R0 indirizzo inizio arrayA (N interi)
		LEA	R1, arrayR	; in R2 inizio arrayR (vuoto lunghezza N)
		
; ******** SOTTOPROGRAMMA *********

; SEGNO_ARRAY				; nome sottoprogramma

		ST	R2, store2	; contenuto R2 -> in cella indirizzo store2
		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3			
		
ciclo		AND	R3,R3,#0	; azzero R3 -> utilizzabile per output MAXN
		
		LDR	R2,R0,#0	; in R2 valore cella puntata da R0
		BRZ	fine		; se trovo zero -> array terminato -> fine
		BRP	positivo	; se numero positivo -> vado a positivo
		NOT	R2,R2
		ADD	R2,R2,#1	; Ca2 di R2 (verifico cosa ottengo)....
		BRP	negativo	; da NEGATIVO -> Ca2 -> POSITIVO -> R2 negativo
		BRN	scrivo		; da NEGATIVO -> Ca2 -> NEGATIVO -> R2 MAXN ...
					; ... quindi scrivo direttamente ouptut "zero"
					
positivo	ADD	R3,R3,#1	; in R3 -> valore 1 per output (specifica)
		BRNZP 	scrivo		; vado a scrivere valore R3 in arrayR

negativo	ADD	R3,R3,#-1	; in R3 -> valore -1 per output (specifica)
		BRNZP 	scrivo		; vado a scrivere valore R3 in arrayR

scrivo		STR	R3,R1,#0	; valore R3 -> in cella arrayR puntata da R1
		ADD	R1,R1,#1	; incremento cella puntata da R1
		ADD	R0,R0,#1	; incremento cella puntata da R0
		BRNZP 	ciclo		; rieseguo il ciclo sino a termine arrayA (/0)

fine		LD	R2, store2	; contenuto cella indirizzo store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3

; 		RET			; ritorno da sottoprogramma
	
; ******** VAR / COST ***********

store2		.blkw	1		; riservo una cella di memoria per contenuto R2
store3		.blkw	1		; riservo una cella di memoria per contenuto R3

arrayA		.fill	#1
		.fill	#-32768
		.fill	#-5
		.fill	#12
		.fill	#0
arrayR		.blkw	#4		; riservo 4 celle memoria per arrayR

.end					; fine programma