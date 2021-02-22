; ************ DESCRIZIONE SOTTOPROGRAMMA ************+

Il seguente sottoprogramma denominato CONTACIFRE riceve:
- nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente una stringa S di caratteri
ASCII (terminata da 0, ovvero il carattere NUL);
- nel registro R1 l’indirizzo della prima di un gruppo di 10 celle libere che costituiscono l’array C.
Il sottoprogramma inoltre, inserisce nel primo elemento di C quante volte il carattere ASCII corrispondente alla cifra
decimale 0 compare nella stringa S, nel secondo elemento di C quante volte compare il carattere 1 nella stringa
S, e così via fino al carattere 9. 
Si ricorda che le 10 cifre decimali hanno codifiche ASCII da x30 (in decimale 48) per lo 0 
a x39 (in decimale 57) per il 9.
Nonostante l'utilizzo di altri registri della CPU, il sottoprogramma restituisce 
il controllo al programma chiamante senza che tali registri risultino alterati.

;************* PROGRAMMA TEST **************
.orig		x3000  
      		LEA	R0, stringaS	; acquisisco in R0 indirizzo prima cella Stringa (primo carattere) 
					; della stringa S
     		LEA     R1, arrayC      ; acquisisco in R1 l'indirizzo prima cella arrayC (10 celle)
		
;************* SOTTOPROGRAMMA **************

; CONTACIFRE				; nome sottoprogramma

		ST	R2, store2	; scrivo contenuto R2 nella cella indirizzo store2
		ST	R3, store3	; scrivo contenuto R3 nella cella indirizzo store3
		ST	R4, store4	; scrivo contenuto R4 nella cella indirizzo store4
		ST	R5, store5	; scrivo contenuto R5 nella cella indirizzo store5
		ST	R6, store6	; scrivo contenuto R6 nella cella indirizzo store6

		AND	R6,R6,#0	; registro contatore per occorrenze cifre trovate
                
		LEA 	R2, cifra_1	; acquisisco in R2 l'indirizzo della prima cifra decimale
					; da conteggiare (x30/#48)
	        LDR     R3,R2,#0     	; metto in R3 il valore contenuto alla cella di indirizzo R2
		             
ciclo_S  	LDR     R4,R0,#0	; acquisisco in R4 il contenuuo della cella avente
					; indirizzo contenuto in R0 (ovvero acquisisco il codice 
					; ASCII del carattere della Stringa S)
                BRz     cifra_succ	; se trovo il NUL (zero) la stringa è terminata quindi passo
					; alla scrittura nell'arrayC del conteggio cifre ed alla
					; verifica della cifra decimale successiva
					; altrimenti....
                ADD     R0,R0,#1	; incremento indirizzo carattere stringa S (contenuto in R0)
                                        ; e vado a confrontare i due caratteri (di cifra e stringa)
                                        
                NOT     R4,R4          
                ADD     R4,R4,#1	; Ca2 valore contenuto in R4 (codice ASCII carattere "negativo")
 		
		ADD     R5,R3,R4   	; metto in R5 il confronto tra i due valori (cifra e carattere)
		
		BRz     cifra_trovata	; se ottengo zero i valori sono uguali quindi
					; ho trovato "corrispondenza tra i due caratteri"
                BRnp    ciclo_S		; altrimenti....proseguo il ciclo sino a fine stringa

cifra_trovata   ADD	R6,R6,#1      	; incremento contatore occorrenze per cifra trovata
		BRnzp   ciclo_S		; proseguo il ciclo sino a fine stringa
                    
cifra_succ      STR	R6,R1,#0	; scrivo il contenuto di R6 (contatore) nella cella indirizzo R1
                ADD     R1,R1,#1	; incremento l'indirizzo della cella arrayC indirizzo R1
                AND     R6,R6,#0	; azzero il contatore occorrenze R6
                ADD     R2,R2,#1     	; passo alla cifra successiva (incrementando indirizzo R2)                     
                LDR	R3,R2,#0        ; metto in R3 il valore contenuto alla cella di indirizzo R2
                BRz     fine   		; se trovo zero terminate cifre -> vado a fine sottoprogramma
                LEA	R0, stringaS	; ri-acquisisco in R0 indirizzo prima cella stringa S (primo carattere)
		BRp     ciclo_S		; altrimenti....ripeto il ciclo di verifca corrispondenza cifre-carattere

fine           	LD	R2, store2	; scrivo in R2 contenuto cella indirizzo store2
		LD	R3, store3	; scrivo in R3 contenuto cella indirizzo store3
		LD	R4, store4	; scrivo in R4 contenuto cella indirizzo store4
		LD	R5, store5	; scrivo in R5 contenuto cella indirizzo store5
		LD	R6, store6	; scrivo in R6 contenuto cella indirizzo store6
                
;               RET				; ritorno da sottoprogramma

;********** VARIABILI PROGRAMMA e SOTTOPROGRAMMA ************

arrayC          .blkw #10

store2		.blkw	1		; riservo una cella memoria per contenuto R2
store3		.blkw	1		; riservo una cella memoria per contenuto R2
store4		.blkw	1		; riservo una cella memoria per contenuto R2
store5		.blkw	1		; riservo una cella memoria per contenuto R2
store6		.blkw	1		; riservo una cella memoria per contenuto R2

cifra_1         .fill #48		; codifica ASCII della cifra 0
                .fill #49		; codifica ASCII della cifra 1
                .fill #50		; codifica ASCII della cifra 2
                .fill #51		; codifica ASCII della cifra 3
                .fill #52		; codifica ASCII della cifra 4
                .fill #53		; codifica ASCII della cifra 5
                .fill #54		; codifica ASCII della cifra 6
                .fill #55		; codifica ASCII della cifra 7
                .fill #56		; codifica ASCII della cifra 8
                .fill #57		; codifica ASCII della cifra 9
                .fill #0		; cidifica ASCII del carattere NUL (terminatore)

;stringaS       .stringz "Oggi è il 13 settembre 2016, che si può scrivere anche 13/09/2016"
;stringaS	.stringz "La festa della mamma cade sempre in una domenica di maggio"
stringaS	.stringz "Ecco una strana sequenza di cifre: 0 11 222 33 4 55 666 7777 88888 999999"	
                   
.end						; fine programma
