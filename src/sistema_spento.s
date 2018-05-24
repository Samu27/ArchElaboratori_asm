.section .data

string:                                # string da stampare
    .ascii "0,00,00\n"

.section .text
.global Sistema_Spento

.type Sistema_Spento, @function        # Dichiarazione della funzione Sistema_Spento
                                       # Stampa la stringa "0,00,00\n" sul file di output
                                       # Quando il sistema e' spento

Sistema_Spento:

  pushl %ebx                           # salvo il valore corrente di ebx sullo stack
  pushl %ecx                           # salvo il valore corrente di ecx sullo stack
  pushl %edx                           # salvo il valore corrente di edx sullo stack

  movl %eax, %ebx		               # sposto il puntatore al file di output in %ebx
  
  movl $4, %eax		                   # Stampo la stringa "0,00,00\n"
  leal string, %ecx                    #
  movl $8, %edx                        #
  int $0x80		                       # sys4 write
	

fine:
                                      # ripristino dei registri salvati sullo stack
		                              # l'ordine delle pop deve essere inverso delle push
  popl %edx                           # ripristino il valore di edx all'inizio della chiamata  
  popl %ecx                           # ripristino il valore di ecx all'inizio della chiamata  
  popl %ebx                           # ripristino il valore di ebx all'inizio della chiamata
  
  ret 
