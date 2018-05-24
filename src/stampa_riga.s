.section .data

  virgola: .ascii ","                 # Stringa formata dal carattere "," (virgola)

  newline: .ascii "\n"                # Stringa formata dal carattere "\n" (new line)
  
  output: .long 0                     # Variabile long, viene salvato il puntatore al file di output
  
  alm: .long 0                        # Variabile long, viene salvato ALM

  mod: .long 0                        # Variabile long, viene salvato MOD

  numb: .long 0                       # Variabile long, viene salvato NUMB

  

.section .text
.global Stampa_Riga

.type Stampa_Riga, @function         # Dichiarazione della funzione Stampa_Riga
                                     # Stampa su file:
		                             # ALM, il carattere virgola, MOD, il carattere virgola, 
		                             # NUMB e il carattere new line
		   
Stampa_Riga:

    movl %eax, mod                   # Salvo il contenuto di %eax (mod) nella variabile MOD
    movl %ebx, alm                   # Salvo il contenuto di %ebx (alm) nella variabile ALM
    movl %ecx, output                # Salvo il contenuto di %ecx (puntatore al file di output) nella variabile OUTPUT
    movl %edx, numb                  # Salvo il contenuto di %edx (numb) nella variabile NUMB

    addl $48, alm                    # Sommo 48 ad ALM

#######

	movl $4, %eax		             # 
	movl output, %ebx	       	     # Stampo ALM
	leal alm, %ecx                   #
	movl $1, %edx                    # sys4 write
	int $0x80		                 # 

#######

	movl $4, %eax		             # Stampa virgola
	movl output, %ebx	 	         # 
	leal virgola, %ecx               # sys4 write
	movl $1, %edx                    #
	int $0x80		                 # 


#######

    movl mod, %eax                   # Stampo MOD usando la funzione Divisione_Stampa
    movl output, %ecx                #
    call Divisione_Stampa            #
    
#######

	movl $4, %eax					 # Stampa virgola
	movl output, %ebx				 # 
	leal virgola, %ecx				 # sys4 write
	movl $1, %edx					 #
	int $0x80						 # 

#######

    movl numb, %eax                  # Stampo NUMB usando la funzione Divisione_Stampa
    movl output, %ecx                #
    call Divisione_Stampa            #
    
#######

	movl $4, %eax					 # Stampa new line (\n)
	movl output, %ebx		         #
	leal newline, %ecx               # sys4 write
	movl $1, %edx                    #
	int $0x80				    	 #


fine:

  ret
