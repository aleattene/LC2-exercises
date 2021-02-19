; ************ DESCRIZIONE SOTTOPROGRAMMA ************

Spesso nella scrittura di testi capita di separare le parole con due o più spazi invece di uno, con il risultato di
un’impaginazione irregolare, con parole più o meno lontane le une dalle altre. Per eliminare il problema, il
seguente sottoprogramma denominato COMP_SPAZI riceve:
- nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente una stringa di caratteri
	codificati ASCII (un carattere per cella). La stringa è terminata dal valore 0 
	corrispondente al carattere NUL);
- nel registro R1 l’indirizzo della prima cella di una zona di memoria libera, di dimensioni sufficienti per
	contenere la stringa di caratteri di cui sopra.
Il sottoprogramma inoltre:
- trascrive la stringa dalla zona di memoria puntata da R0 a quella puntata da R1, facendo in modo che
	non esistano spazi doppi o multipli fra le parole. La stringa trascritta vine terminata dal valore 0
	(corrispondente al carattere NUL);
- restituisce nel registro R2 il numero totale di spazi eliminati.
Si ricorda che nel codice ASCII il carattere spazio ha codifica decimale 32 (esadecimale x20).
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

************ ESEMPIO FUNZIONAMENTO SOTTOPROGRAMMA ************

INPUT
R0 punta alla zona di memoria contenente la stringa “Un esempio di frase con spazi multipli tra le parole”

OUTPUT
R1 punta alla zona di memoria contenente la stringa “Un esempio di frase con spazi multipli tra le parole”
R2 contiene il valore 9

; ********* PROGRAMMA TEST *************

.orig		x3000
		LEA	R0, stringaS	; in R0 <- indirizzo inizio stringaS (array)
		LEA	R1, stringaR	; in R1 <- indirizzo inizio stringaR (vuota)

; ********* SOTTOPROGRAMMA *************

; COMP_SPAZI				; nome sottoprogramma

		ST	R3, store3	; contenuto R3 -> in cella indirizzo store3
		ST	R4, store4	; contenuto R4 -> in cella indirizzo store4
		ST	R5, store5	; contenuto R5 -> in cella indirizzo store5

		LD	R2, spazio	; in R2 <- decimanele opposto ASCII "spazio"	
		AND	R5,R5,#0	; azzero contatore spazi inutili (da eliminare)

ciclo		LDR	R3,R0,#0	; in R3 <- ASCII carat puntato da R0 (stringaS)
		BRZ	fine		; se zero sequenza (stringaS) finita -> fine
					; altrimenti....
		ADD	R4,R3,R2	; confronto carattere stringa con  spazio
		BRZ	ver_spazio	; se trovo spazio "verifico" se singolo/multiplo
					; altrimenti.....

scrivi		STR	R3,R1,#0	; scrivo carattere cella stringaS in stringaR
		ADD	R0,R0,#1	; incremento cella puntata da R0 (stringa S)		
		ADD	R1,R1,#1	; incremento cella puntata da R1 (stringa R)
		BRNZP	ciclo		; continuo scansione stringa sino fine (/0)

ver_spazio	LDR	R4,R0,#1	; leggo carattere successivo stringaS
		ADD	R4,R4,R2	; confronto spazio con carattere successivo
		BRZ	el_spazio	; se trovo un altro spazio lo elimino
		BRNP	scrivi		; altrimenti è uno spazio da lasciare...

el_spazio	ADD	R5,R5,#1	; incremento contatore spazi inutili
		ADD	R0,R0,#1	; incremento cella puntata da R0 (stringaS)
		BRNZP	ciclo		; continuo scansione stringa sino fine (/0)
	
fine		AND	R4,R4,#0	; azzero contatore R4 -> per ASCII /0 stringaR
		STR	R4,R1,#0	; contenuto R4 -> in cella puntata da R1 (/0)
		ADD	R2,R5,#0	; in R2 <- valore R5 (contatore spazi inutili)

		LD	R3, store3	; contenuto cella indirizzo store3 -> in R3
		LD	R4, store4	; contenuto cella indirizzo store4 -> in R4
		LD	R5, store5	; contenuto cella indirizzo store5 -> in R5

; 		RET			; ritorno da sottoprogramma

; ********* VAR / COST *************

store3		.blkw	1		; riservo una cella di memora per contenuto R3
store4		.blkw	1		; riservo una cella di memora per contenuto R4
store5		.blkw	1		; riservo una cella di memora per contenuto R5

stringaS	.stringz "Un esempio  di frase  con    spazi   multipli tra le    parole"

stringaR	.blkw	53		; riservo 53 celle memoria per stringaR

spazio		.fill	#-32 		; valore decimale opposto carat ASCII "spazio"

.end					; fine programma
