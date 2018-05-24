.section .data

car:
  .byte 0                # la variabile car e' dichiarata di tipo byte

counter:
	.int 0

.section .text
.global atoi4

.type atoi4, @function  # dichiarazione della funzione Atoi4
                        # la funzione converte una stringa formata da 4 caratteri
              		      # il cui indirizzo si trova in eax
              		      # in un numero che viene restituito nel registro eax
atoi4:   
  pushl %ebx            # salvo il valore corrente di ebx sullo stack
  pushl %ecx            # salvo il valore corrente di ecx sullo stack
  pushl %edx            # salvo il valore corrente di edx sullo stack

  movl %eax, %ecx
  xorl %eax, %eax
  xorl %edx, %edx

  movl $0, counter    	# azzero contatore, altrimenti ciclerebbe solo al primo richiamo della funzione


inizio:

  cmp $4, counter       # ciclo per massimo 4 volte
  je fine               # se il contatore è uguale a 4, salto a "fine"
  incl counter          # altrimenti incremento il contatore

#######

  xorl %ebx, %ebx       
  mov (%ecx,%edx), %bl # somma dei contenuti dei 2 registri e considera il risultato come un puntatore
  movb %bl, car
  subb  $48, car       # converte il codice ASCII della cifra nel numero corrisp.

#######

  movl  $10, %ebx
  pushl %edx	         # salvo nello stack il valore di edx perchè verrà modificato dalla mull
  mull  %ebx           # eax = eax * 10
  popl %edx
                       # sto trascurando i 32 bit piu' significativi del risultato 
                       # della moltiplicazione che sono in edx 
                       # quindi il numero introdotto da tastiera deve essere minore di 2^32

#######
 
  xorl  %ebx, %ebx
  movb  car, %bl       # copio car che va ad occupare il byte meno significativo
                       # di ebx
  addl  %ebx, %eax     # eax = eax + ebx
		                   # NOTA: non si puo' fare direttamente eax=eax+car perche'
                       # eax e' a 32 bit mentre car e' a 8 bit

  incl  %edx
  jmp   inizio


fine:
                      # ripristino dei registri salvati sullo stack
		                  # l'ordine delle pop deve essere inverso delle push
  popl %edx           # ripristino il valore di edx all'inizio della chiamata  
  popl %ecx           # ripristino il valore di ecx all'inizio della chiamata  
  popl %ebx           # ripristino il valore di ebx all'inizio della chiamata
  
  ret
  
  
