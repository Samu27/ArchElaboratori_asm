.section .text
.global Contatore

.type Contatore, @function       # dichiarazione della funzione Contatore
                                 # La funzione riceve in ebx il valore di reset, in eax mod, in ecx last_mod e in edx il valore di numb
                                 # La funzione modifica NUMB in base ai valori di RESET (se a 1, NUMB=0)
		                         # e di MOD e LAST_MOD. Se MOD = 11 e NUMB > 14, imposta ALM a 1
		                  
Contatore:

    cmp $1, %ebx                 # Controllo il RESET
    je Reset_Attivo              # se RESET è uguale a 1, salto a Reset_Attivo

                                 # Reset NON attivo
                                 # Controllo di non aver cambiato Stato

    cmp %eax, %ecx               # Confronto MOD e LAST_MOD
    je Incremento_Cont           # Se uguali --> incremento NUMB
    
                                 # Altrimenti ho cambiato stato e posso impostare ALM e NUMB a 0


Reset_Attivo:                    # Qui si imposta Alm e Cont a 0 nei 2 casi sopra
    
                                 # Reset attivato --> imposto ALM a 0 e NUMB a 00
    movl $0, %ebx                # ALM impostato
    movl $0, %edx                # NUMB Resettato
    ret
    
    
Incremento_Cont:

    incl %edx                    # NUMB Incrementato
    movl $0, %ebx
    
                                 # Controllo se siamo in FG e se devo far suonare l'allarme
    cmp $11, %eax                # Confronto MOD e 11
    je Ipotesi_Allarme           # Se uguali vado in Ipotesi_Allarme
    ret                          # Altrimenti ret
    
    
Ipotesi_Allarme:

    cmp $14, %edx                # Confronto NUMB e 14
    jg Allarme_ON                # Se NUMB è maggiore di 14 vado in Allarme_ON
    ret                          # Altrimenti ret
    
    
Allarme_ON:

    movl $1, %ebx                # Imposto ALM a 1
    ret
    