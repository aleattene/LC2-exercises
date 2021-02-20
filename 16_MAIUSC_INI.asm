; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Il seguente sottoprogramma denominato MAIUSC_INI riceve nel registro R0 l’indirizzo della
prima cella di una zona di memoria contenente una frase costituita da “parole” (sequenze di caratteri codificati
in codice ASCII) separate l’una dall’altra da un singolo spazio. La stringa è terminata dal valore 0
(corrispondente al carattere NUL).
Se una parola della frase inizia con una lettera minuscola, il sottoprogramma converte tale lettera nella
corrispondente lettera MAIUSCOLA, mentre non fa nulla se la parola inizia con una lettera maiuscola o
con un carattere diverso da una lettera.
Si ricorda che:
- nel codice ASCII, le lettere MAIUSCOLE hanno codifiche decimali da “A”=65 a “Z”=90;
- nel codice ASCII, le lettere minuscole hanno codifiche decimali da “a”=97 a “z”=122;
- nel codice ASCII, il carattere “spazio” ha codifica decimale 32;
- la differenza numerica fra la codifica ASCII di una lettera minuscola e quella della corrispondente
	lettera MAIUSCOLA espressa in notazione decimale è pari a 32.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati

; *********** PROGRAMMA TEST **************

.orig		x3000
		LEA	R0, stringaS
	
; *********** SOTTOPROGRAMMA **************

; MAIUSC_INI		
		ST	R0, store0	; contenuto R0 -> cella indir store 0
		ST	R1, store1	; contenuto R1 -> cella indir store 1
		ST	R2, store2	; contenuto R2 -> cella indir store 2
		ST	R3, store3	; contenuto R3 -> cella indir store 3
		ST	R4, store4	; contenuto R4 -> cella indir store 4
		ST	R5, store5	; contenuto R5 -> cella indir store 5
		ST	R6, store6	; contenuto R6 -> cella indir store 6

		ADD 	R1,R0,#0	; contenuto R0 -> in R1
test_INIT	LDR	R0,R1,#0	; contenuto cella indirizzo R1 -> in R0
		BRZ	inizio		; se zero stringa terminata -> inizio sottopr
		TRAP	x21		; emetto a video carattere ASCII in R0
		ADD	R1,R1,#1	; incremento R1 
		BRNZP   test_INIT	; ripeto ciclo test iniziale

inizio		LD	R0,store0	; recupero indirizzo R0	
		LD	R2, spazio	; in R2 <- codifica ASCII neg spazio (#-32)
		LD	R3, car_a	; in R3 <- codifica ASCCI neg spazio (#-97)
		LD	R6, seq_car	; in R6 <- numero caratteri (#-25)
		BRNZP	verif_INIT	; prima lettera stringa -> verificare subito	

ciclo		ADD	R0,R0,#1	; incremento indirizzo R0
		LDR	R1,R0,#0	; in R1 <- contenuto cella indirizzata da R0
		BRZ	output		; se trovo zero stringa terminata -> fine
		ADD	R4,R2,R1	; verifico spazio
		BRZ	verif_SUCC	; se 0 -> spazio trovato -> verif car successivo
		BRNP	ciclo		; altrimenti continuare scansione stringa

verif_SUCC	ADD	R0,R0,#1	; incremento di 1 indirizzo in R0
verif_INIT	LDR	R1,R0,#0	; contenuto cella indirizzo R0 -> in R1
		ADD	R5,R1,R3	; verifico carattere rispetto a cod_a (#-97)	
		BRN	ciclo		; carattere da non modificare
		BRZ	minusc		; lettera minuscola trovata
		BRP	individua	; evenetuale lettera da individuare

individua	ADD 	R5,R5,R6	; verifico se lettera minuscola o over cod_z (122)
		BRNZ	minusc		; lettera minuscola trovata
		BRP	ciclo		; carattere da non modificare
						
minusc		ADD	R5,R1,R2	; trasformo min in MAIU (cod_MAIU = cod_min - 32) 
		STR	R5,R0,#0	; scrivo contenuto R5 in cella indirizzata R0	
		BRNZP	ciclo 		; continuo a scandire la stringa
				
output		ST	R0, store0_F	; contenuto R0 -> cella indir store 0_F
		LD	R1, store0	; contenuto cella indir store0 -> in R1
		
test_FINE	LDR	R0,R1,#0	; contenuto cella indirizzo R1 -> in R0
		BRZ	fine		; se zero stringa terminata -> fine
		trap	x21		; emetto a video carattere ASCII in R0
		ADD	R1,R1,#1	; incremento R1
		BRNZP   test_FINE	; ripeto ciclo test finale
		
fine		LD	R0, store0_F	; contenuto cella indir store0_F -> in R0
		LD	R1, store1	; contenuto cella indir store1 -> in R1
		LD	R2, store2	; contenuto cella indir store2 -> in R2
		LD	R3, store3	; contenuto cella indir store3 -> in R3
		LD	R4, store4	; contenuto cella indir store4 -> in R4
		LD	R5, store5	; contenuto cella indir store5 -> in R5
		LD	R6, store6	; contenuto cella indir store6 -> in R6

; 		RET			; fine sottoprogramma
		

; *********** VARIABILI SOTTOPROGRAMMA e PROGRAMMA ***********

store0		.blkw	1		; riservo una cella memoria per R0 (INIT)
store0_F	.blkw	1		; riservo una cella memoria per R0 (FINE)
store1		.blkw	1		; riservo una cella memoria per R1
store2		.blkw	1		; riservo una cella memoria per R2
store3		.blkw	1		; riservo una cella memoria per R3
store4		.blkw	1		; riservo una cella memoria per R4
store5		.blkw	1		; riservo una cella memoria per R5
store6		.blkw	1		; riservo una cella memoria per R6

stringaS	.stringz "Oggi e' il 7 luglio 2015"	

spazio		.fill	#-32
car_a		.fill	#-97
seq_car		.fill	#-25

.end					; fine programma
