; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato SEQ riceve nel registro R0 il numero intero N e 
restituisce sempre in R0 l’ennesimo termine S(N) della sequenza definita nel seguente modo:
				S(N) = S(N-1) – 2 x S(N-2)
con S1 = 1 e S2 = 1. Si ipotizza inoltre che S(N) = 0 per N ≤ 0
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ************ ESEMPI FUNZIONAMENTO SOTTOPROGRAMMA ************

  INPUT 1	  OUTPUT 1
R0  	 9 	R0 	-17
   
  INPUT 2	  OUTPUT 2
R0	 2 	R0 	  1

  INPUT 3	  OUTPUT 3
R0 	-4 	R0 	  0

;******** PROGRAMMA ***********

.orig		X3000
		LD	R0,intero	; metto in R0 il valore intero N
		
;********** SOTTOPROGRAMMA ***********
		
; SEQ					; nome sottoprogramma
		ST	R1,store1	; scrivo contenuto R1 nella cella indirizzo store1
		ST	R2,store2	; scrivo contenuto R2 nella cella indirizzo store2
		ST	R3,store3	; scrivo contenuto R3 nella cella indirizzo store3
		ST	R4,store4	; scrivo contenuto R4 nella cella indirizzo store4
			
		AND	R0,R0,R0	; verifico il valore di R0
		BRnz	Sn_out_0	; se trovo numero negativo o nullo vado ad output_zero

;qui numero positivo maggiore di zero
		
		ADD 	R0,R0,#-2	; verifico se il valore di R0 è 1 (BRn) oppure 2 (BRz)
		BRnz	S12_out1	; se trovo un negativo o nullo vado ad output_1

; qui numero maggiore di 2

		AND	R1,R1,#0	; azzero il registro R1
		ADD	R1,R1,#1	; imposto S(n-2) pari ad 1
		AND	R2,R2,#0	; azzero il registro R2
		ADD	R2,R2,#1	; imposto S(n-1) pari ad 1
		AND	R3,R3,#0	; azzero il registro R3
ciclo		ADD	R3,R1,R1	; calcolo 2(Sn-2)
		NOT 	R3,R3		; 
		ADD	R3,R3,#1	; calcolo -2(Sn-2)
		ADD	R4,R2,R3	; in R4 metto Sn = (Sn-1)-2(Sn-2)
		ADD	R0,R0,#-1	; tolgo 1 al valore di R0 (decremento di 1 R0)
		BRZ	Sn_out_n	; se trovo valore nullo, sequenza finita, vado emettere output Sn	
		ADD	R1,R2,#0	; altrimenti S(n-1) diventa S(n-2)
		ADD	R2,R4,#0	; Sn diventa S(n-1)
		BRNZP	ciclo		; e si ripete il ciclo sin quando R0 non è uguale a zero
					; ovvero è terminata la sequenza da calcolare
			
S12_out1	AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R0,#1	; imposto il registri R0 ad 1 (come da specifiche)
		brnzp	fine		; e vado a fine sottoprogramma
		
Sn_out_0	AND	R0,R0,#0	; imposto il registro R0 a zero (come da specifiche)
		brnzp	fine		; e vado a fine sottoprogramma
		
	
Sn_out_n	AND	R0,R0,#0	; azzero il registro R0
		ADD	R0,R0,R4	; metto in R0 il valore di R4 (valore sequenza Sn ottenuta)
		brnzp	fine		; e vado a fine sottoprogramma

fine		LD	R1,store1	; metto in R1 il valore contenuto nelle cella di indir. store1
		LD	R2,store2	; metto in R2 il valore contenuto nelle cella di indir. store2
		LD	R3,store3	; metto in R3 il valore contenuto nelle cella di indir. store3
		LD	R4,store4	; metto in R4 il valore contenuto nelle cella di indir. store4

; 		RET

;********** VARIABILI ***********

intero		.fill	#9
;intero		.fill	#2
;intero		.fill	#-4

store1		.blkw	1
store2		.blkw	1
store3		.blkw	1
store4		.blkw	1

.end
