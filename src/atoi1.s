.section .data

car:
  .byte 0                   # la variabile car e' dichiarata di tipo byte

.section .text
.global atoi1

.type atoi1, @function      # dichiarazione della funzione Atoi1
                            # la funzione converte un singolo carattere
		                        # il cui indirizzo si trova in eax
		                        # in un numero che viene restituito nel registro eax
atoi1:   
  pushl %ebx                # salvo il valore corrente di ebx sullo stack
  pushl %ecx                # salvo il valore corrente di ecx sullo stack
  pushl %edx                # salvo il valore corrente di edx sullo stack

  movl %eax, %ecx           # sposto il carattere da convertire in ecx
  
  xorl %eax, %eax           
  xorl %edx, %edx           # pulisco eax, edx, ebx
  xorl %ebx, %ebx

#######

  mov (%ecx,%edx), %bl      # somma dei contenuti dei 2 registri e considera il risultato come un puntatore
  movb %bl, car
  subb  $48, car            # converte il codice ASCII della cifra nel numero corrisp.

#######

  xorl  %ebx, %ebx
  movb  car, %bl            # copio car che va ad occupare il byte meno significativo
                            # di ebx
  addl  %ebx, %eax          # eax = eax + ebx
		                        # NOTA: non si puo' fare direttamente eax=eax+car perche'
                            # eax e' a 32 bit mentre car e' a 8 bit

fine:
                            # ripristino dei registri salvati sullo stack
		                        # l'ordine delle pop deve essere inverso delle push
  popl %edx                 # ripristino il valore di edx all'inizio della chiamata  
  popl %ecx                 # ripristino il valore di ecx all'inizio della chiamata  
  popl %ebx                 # ripristino il valore di ebx all'inizio della chiamata
  
  ret 
  