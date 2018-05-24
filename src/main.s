################################################################################
###########  Elaborato Faggion Andrea, Mori Samuele, Valentino Wilma ###########
################################################################################
																				# Legge file e stampa contenuto a video
																				# ./eseguibile nome.txt

.section .data		

  input: .long 0												# Variabile long, viene salvato il puntatore al file di input

  output: .long 0												# Viene salvato il puntatore al file di output
  
  init: .long 0													# Viene salvato init
  																			
  last_init: .long 0										# Viene salvato l'init del ciclo predente 

  reset: .long 0		                    # Viene salvato reset
  																			
  rpm: .long 0													# Viene salvato rpm
  
  alm: .long 0													# Viene salvato alm
  
  mod: .long 0													# Viene salvato mod
  																			
  last_mod: .long 0                     # Viene salvato il mod del ciclo precedente
 
  numb: .long 0										    	# Viene salvato numb	
  
  buff_size: .long 9										# Dimensione del buff
  
  cont: .int 0													# Viene salvato il contatore

#######

.section .bss
  .lcomm buff, 9												# Riserva 9 byte di memoria

#######


.section  .text             						

  .global _start            						# Stesura del main 

_start:
	
	popl %eax															# Prendo il numero degli argomenti dallo stack
	popl %ebx															# Prendo il nome del programma
	popl %ebx															# Prendo il primo argomento	
	
###### Open the first file ######
	
	movl $5, %eax													# sys5 Open
	movl $0, %ecx													
	int $0x80															
	
	movl %eax, input											# Salvo il puntatore al file in input

###### Open the second file ######
	
	popl %ebx															# Prendo il file dove scrivere
	movl $5, %eax													 
	movl $2, %ecx													# sys5
	int $0x80															
	
	movl %eax, output											# Salvo il puntatore del file di output
	
	leal buff, %ecx												# Prendo l'indirizzo del buff, lo metto in ecx
																				# Comincia poi il ciclo del programma

#######

ciclo:
	
	cmp $100, cont												# Se siamo al centunesimo giro salto alla fine
	je fine
 	incl cont															# Altrimenti prosegue incrementando il contatore
 	
###### Leggo il file ######
 	
	movl input, %ebx											# file_descriptor
	movl $3, %eax													# sys3 read
	leal buff, %ecx												# *buf
	movl buff_size, %edx									# *bufsize
	int $0x80															

	test %eax, %eax												# Controllo di fine testo
	jz fine																# Se SI salto alla fine

#######

	movl %ecx, %eax												# Copio la riga letta in eax
	call atoi1														# Call della funzione per convertire UN solo carattere in numero
	movl %eax, init												# Salvo il numero --> init

	cmp $0, %eax            							# Confronto init con 0 
	je Spento															# --> se TRUE il motore è fermo vado alla stampa di 0,00,00
	

#######

	add $2, %ecx            							# Aggiungo 2 al puntatore per poter prendere il bit di reset
	movl %ecx, %eax												# Copio la riga spostata in eax
	call atoi1														# Call della funzione per convertire UN solo carattere in numero
	movl %eax, reset											# Salvo il numero --> reset


	addl $2, %ecx         								# Aggiungo 2 al puntatore per poter prendere i bit di rpm
	movl %ecx, %eax												# Copio la riga spostata in eax
	call atoi4														# Call della funzione per convertire 4 caratteri in numeri
	movl %eax, rpm												# Salvo il numero --> rpm
  
#######
																				# init è 1 controllo in quale stato sono e lo salvo nella sua variabile 
  movl rpm, %eax          							# Carico il valore di rpm in eax e chiamo la funzione
	
	call Controllo_Stato  								# Funzione che compare il valore prendente in eax 
																				# Restituendo la modalita' attuale del motore

#######

  movl %eax, mod												# Valore restituito --> mod
  
  movl last_init, %eax									# Carico last_init per il controllo del caso particolare 
	cmp $0, %eax													# last_init = 0 ? 
	je controllo_caso_particolare 				# Se SI --> jump

#######

  movl mod, %eax												# Carico mod, reset, last_mod e numb 
  movl reset, %ebx      								 
  movl last_mod, %ecx     							
  movl numb, %edx
 
  call Contatore												# Chiamo la funzione per la gestione del contatore e allarme


  movl %ebx, alm												# Salvo --> alm, numb, last_mod 
  movl %edx, numb
  movl %eax, last_mod
  
  
###### Scrivo il file ######
  
stampa:																	# La funzione riceve mod, alm, output, numb

	movl output, %ecx											# Carica il puntatore al file da scrivere e chiama la funzione
	
	
	call Stampa_Riga											# Funzione che scrive riga per riga nel file di output


	movl init, %eax												# Carico init attuale e lo salvo come last_init e ricomincio il ciclo
	movl %eax, last_init									# Salvo --> last_init

	jmp ciclo


Spento:
	
	movl output, %eax											# Siamo nella situazione init = 0
	
  call Sistema_Spento										# Chiamo la funzione di scrittura 0,00,00
    				
  jmp ciclo															# Ricomincia il ciclo
    

controllo_caso_particolare:     				# controllo il caso speciale quando il circuito viene 
	movl $0, %ebx               					# acceso da motore fermo e viene lasciato a motore spento
  movl $0, %edx               					# questo mi impedisce di incrementare il contatore la prima volta
  movl mod, %eax												# carico 0 nei registi che andranno a stampare alm e numb nel file
  jmp stampa


fine:																		# Fine del programma --> Uscita

	movl $1, %eax													# sys1 exit
	movl $0, %ebx		
	int $0x80	 
