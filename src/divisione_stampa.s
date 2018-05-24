.section .data
    
    unita: .long 0					   # Resto divisione
  
    decine: .long 0					   # Risultato divisione
    
    output: .long 0                    # Puntatore al file di output

.section .text
.global Divisione_Stampa

.type Divisione_Stampa, @function      # Dichiarazione della funzione Divisione_Stampa
                                       # La funzione divide un numero intero formato da 2 cifre
		                               # e poi stampa tali cifre sul file di output
		                              
Divisione_Stampa:

    movl %ecx, output                  # Sposto il puntatore al file di output nella variabile OUTPUT
    movl $10, %ebx                     # Metto il numero 10 in %ebx
	movl $0,%edx                       # Metto il numero 0 in %edx
	divl %ebx                          # Divido %eax (%edx è a 0) con %ebx (10).
									   # Il risultato della divisione viene salvato in %eax,
									   # mentre il resto in %edx

#######

    movl %eax, decine                  # Sposto il risultato della divisione in DECINE
    movl %edx, unita                   # Sposto il resto della divisione in UNITA

    addl $48, decine                   # Sommo 48 a DECINE
    addl $48, unita                    # Sommo 48 a UNITA

#######

	movl $4, %eax		               # Scrivo sul file di output DECINE
	movl output, %ebx		           # 
	leal decine, %ecx                  #
	movl $1, %edx                      # sys4 write
	int $0x80		                   # 
	
#######

	movl $4, %eax		               # Scrivo sul file di output UNITA 
	movl output, %ebx		           # 
	leal unita, %ecx                   #
	movl $1, %edx                      # sys4 write
	int $0x80		                   # 
	
	ret
	