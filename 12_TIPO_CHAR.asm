; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato TIPO_CAR riceve nel registro R0 il codice ASCII standard
di un carattere (quindi un valore decimale compreso fra 0 e 127, estremi inclusi) e restituisce
nel registro R1 un numero che indichi il tipo di carattere ricevuto in ingresso, ovvero:
- 1 se il carattere è un carattere di controllo (codifica ASCII minore del numero decimale 32);
- 2 se il carattere è una cifra (codifica ASCII compresa fra i numeri decimali 48 e 57, estremi inclusi);
- 3 se il carattere è una lettera maiuscola (codifica ASCII compresa fra i numeri decimali 65 e 90, estremi
	inclusi);
- 4 se il carattere è una lettera minuscola (codifica ASCII compresa fra i numeri decimali 97 e 122, estremi
	inclusi);
- 5 se il carattere non è nessuno dei tipi precedenti.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ********** PROGRAMMA TEST *********

.orig		x3000
		LD	R0, car		; in R0 <- ASCII decimale carattere ingresso
			
; ********** SOTTOPROGRAMMA *********
			
; TIPO_CAR				; nome sottoprogramma

		ST	R2, store2	; contenuto R2 -> cella indirizzata store2		
		ST	R3, store3	; contenuto R3 -> cella indirizzata store3
		ST	R4, store4	; contenuto R4 -> cella indirizzata store4
		ST	R5, store5	; contenuto R5 -> cella indirizzata store5
		ST	R6, store6	; contenuto R6 -> cella indirizzata store6						
	
		AND	R1,R1,#0	; azzeramento registro output "tipo carattere"
		
		LD	R2, contr_1	; in R2 valore -31 (da costante contr_1)
		ADD	R3,R0,R2	; in R3 -> confr ASCII_car e ASCII_car 0 - 31
		BRNZ	car_cont	; se risultato nullo/negativo -> car controllo 
		
		LD	R4, contr_2	; in R2 valore -47 (da costante contr_2)		
		ADD	R3,R0,R4	; in R3 -> confr ASCII_car e ASCII_car 32 - 47
		BRNZ	no_car		; se risultato nullo/negativo -> no carattere 
		
		ADD	R4,R4,#-10	; in R2 valore -57
		ADD	R3,R0,R4	; in R3 -> confr ASCII_car e ASCII_car 48 - 57
		BRNZ	cifra		; se risultato nullo/negativo -> cifra 
		
		ADD	R4,R4,#-7	; in R2 valore -64
		ADD	R3,R0,R4	; in R3 -> confr ASCII_car e ASCII_car 58 - 64	
		BRNZ	no_car		; se risultato nullo/negativo -> no carattere 
		
		LD	R5, contr_3	; in R2 valore -90 (da costante contr_3)
		ADD	R3,R0,R5	; in R3 -> confr ASCII_car e ASCII_car 65 - 90
		BRNZ	MAIU		; se risultato nullo/negativo -> MAIUSCOLA 
		
		ADD	R4,R4,#-6	; in R2 valore -96
		ADD	R3,R0,R4	; in R3 -> confr ASCII_car e ASCII_car 91 - 96
		BRNZ	no_car		; se risultato nullo/negativo -no carattere
		
		LD	R6, contr_4	; in R6 valore -122 (da costante contr_4)
		ADD	R3,R0,R6	; in R3 -> confr ASCII_car e ASCII_car 97 - 122
		BRNZ	minu		; se risultato nullo/negativo -> minuscola 
		BRP	no_car		; se risultato positivo -> car controllo 

car_cont	ADD R1,R1,#1		; output R1 = 1 (come da specifica)
		BRNZP	fine

cifra		ADD R1,R1,#2		; output R1 = 2 (come da specifica)
		BRNZP	fine

MAIU		ADD R1,R1,#3		; output R1 = 3 (come da specifica)
		BRNZP	fine

minu		ADD R1,R1,#4		; output R1 = 4 (come da specifica)
		BRNZP	fine

no_car		ADD R1,R1,#5		; output R1 = 5 (come da specifica)
		
fine		LD	R2, store2	; contenuto cella indirizzata store2 -> in R2
		LD	R3, store3	; contenuto cella indirizzata store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzata store4 -> in R4
		LD	R5, store5	; contenuto cella indirizzata store5 -> in R5
		LD	R6, store6	; contenuto cella indirizzata store6 -> in R6

; 		RET			; ritorno da sottoprogramma

; ********** VARIABILI **************

contr_1		.fill	#-31		; costante per intervallo ASCII 0 - 31
contr_2		.fill	#-47		; costante per intervallo ASCII 32 - 47
contr_3		.fill	#-90		; costante per intervallo ASCII 65 - 90
contr_4		.fill	#-122		; costante per intervallo ASCII 97 - 122

store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R3
store4		.blkw	1		; riservo una cella memoria per contenuto R4
store5		.blkw	1		; riservo una cella memoria per contenuto R5
store6		.blkw	1		; riservo una cella memoria per contenuto R6

;car		.fill	#109
;car		.fill	#36
;car		.fill	#55
;car		.fill	#75
;car		.fill	#10
;car		.fill	#57
car		.fill	#122	
;car		.fill	#123

.end					; fine programma
