.section .text
.global Controllo_Stato

.type Controllo_Stato, @function     # Dichiarazione della funzione Controllo_Stato
                                     # In base al valore di RPM, ritorna MOD (lo stato attuale)

Controllo_Stato:

    cmp $0, %eax                     # Comparo RPM a 0
    je STATO_FERMO                   # Se salta nel STATO FERMO 
                                     # Altrimenti controllo in quale altro stato e'
#######

    cmp $2000, %eax                  # Comparo RPM a 2000
    jl STATO_SG                      # Se RPM < 2000 salto in SG 
                                     # Altrimenti controllo se siamo in FG o OTP
#######

    cmp $4000, %eax                  # Comparo RPM a 4000
    jg STATO_FG                      # Se RPM > 4000 salto in FG  
                                     
#######                              # Altrimenti siamo in OTP e continuiamo col codice
                                     
    movl $10, %eax                   # Imposto 10 in stato attuale perchè siamo in stato OPT
    ret


STATO_FERMO :                        # Imposto 00 in stato attuale e ritorno

   movl $00, %eax
   ret
  
    
STATO_SG :                           # Imposto 01 in stato attuale e ritorno

    movl $01, %eax
    ret
 
    
STATO_FG :                           # Imposto 11 in stato attuale e ritorno

    movl $11, %eax
    ret
