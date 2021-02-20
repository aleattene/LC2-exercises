; ****** PROGRAMMA TEST *************

.orig		x3000
		LD	R0, primo_num
		LD	R1, sec_num

; ****** SOTTOPROGRAMMA **************

; ANALIZZA_COPPIA
		
		ST	R2, store2

		AND	R2,R2,#0	; registro si/no traboccamento

		AND	R0,R0,R0
		BRZP	primo_pos
		BRN	primo_neg
		
primo_pos	AND	R1,R1,R1
		BRP	conc_pos
		BRNZ	discordi	; discordi -> no rischio traboccamento
		

primo_neg	AND	R1,R1,R1
		BRN	conc_neg
		BRZP	discordi	; discordi -> no rischio traboccamento

conc_pos	ADD	R3,R0,R1	; in R3 <- somma due numeri positivi
		BRZP	no_traboc
		BRN	traboc



discordi	AND	R,R0,#0		
		ADD	R0,R0,#1		; output R0 = 1 (specifica)
no_traboc	ADD 	R2,R2,#0		; output R2 = 0 (specifica)
		BRNZP	fine

trabocc		ADD 	R2,R2,#1		; output R2 = 1 (specifica)

fine		


		LD	R2, store2


; 		RET

; ****** VAR / COST *************

store2		.blkw	1

primo_num
		.fill	#-16
		.fill	#30000
		.fill	#-16000
sec_num
		.fill	#15
		.fill	#25000
		.fill	#-20000

.end