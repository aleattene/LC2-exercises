; ************** DESCRIZIONE SOTTOPROGRAMMA **************

Il seguente sottoprogramma denominato SUM riceve nei registri R0 e R1 due numeri a 16 bit in
complemento a due e restituisce:
- nel registro R0 la somma dei due numeri
- nel registo R1 il valore:
	-  0 se la somma è corretta;
	-  1 se si è verificato overflow;
	- -1 se si è verficato underflow.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

; ************** ESEMPI FUNZIONAMENTO SOTTOPROGRAMMA **************

	INPUT 			OUTPUT
	R0 	 15000 		R0 	 14000
	R1 	 -1000 		R1 	     0

	R0 	 20000 		R0 	-24536
	R1 	 21000 		R1 	     1

	R0 	-25000 		R0 	 18536
	R1 	-22000 		R1 	    -1

; ************** PROGRAMMA TEST **************

.orig		x3000
		LD	R0, num_1	; in R0 <- contenuto cella ind num_1		
		LD	R1, num_2	; in R1 <- contenuto cella ind num_2	

; ************** SOTTOPROGRAMMA **************

; SUM					; nome del sottoprogramma
		
		AND	R0,R0,R0	; verifico contenuto R0
		BRZ	corretto	; no rischio traboccamento
		BRN	num1_neg	; primo numero negativo
		BRP	num1_pos	; primo numero positivo

num1_neg	AND	R1,R1,R1	; verifico contenuto R1
		BRZP	corretto	; no rischio traboccamento
		BRN	conc_neg	; rischio underflow
		
num1_pos	AND	R1,R1,R1	; verifico contenuto R1
		BRNZ	corretto	; no rischio traboccamento
		BRP	conc_pos	; rischio overflow

conc_neg	ADD	R0,R0,R1	; in R0 <- somma R0 + R1
		BRN	corretto	; se risultato negativo -> corretto
		BRZP	underflow	; se risultato nullo/positivo -> underflow
		
conc_pos	ADD	R0,R0,R1	; in R0 <- somma R0 + R1
		BRP	corretto	; se risultato positivo -> corretto
		BRNZ	overflow	; se risultato nullo/negativo -> overflow 
	
corretto	ADD	R0,R0,R1	; in R0 <- somma R0 + R1
		AND	R1,R1,#0	; azzero R1 -> output R1 = 0 (specifica)
		BRNZP	fine		; somma terminata -> fine

underflow	AND	R1,R1,#0	; azzero R1 (registro output)
		ADD	R1,R1,#-1	; underflow -> output R1 = -1 (specifica)
		BRNZP	fine		; somma terminata -> fine

overflow	AND	R1,R1,#0	; azzero R1 (registro output)
		ADD	R1,R1,#1	; overflow -> output R1 = 1 (specifica)
		BRNZP	fine		; somma terminata -> fine

fine		AND 	R2,R2,#0	; azzeramento "di comodo" (per "fine")
		
		; RET			: ritorno da sottoprogramma

; *********** VARIABILI *************

num_1		.fill	#15000
;num_1		.fill	#20000
;num_1		.fill	#-25000

num_2		.fill	#-1000
;num_2		.fill	#21000
;num_2		.fill	#-22000

.end					; fine programma
