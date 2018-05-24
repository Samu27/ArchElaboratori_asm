EXE=run.x
AS=as
LD=ld
FLAGS= -gstabs --32 #per assemblare a 32 bit
SRC_DIR= src
OBJ= atoi1.o atoi4.o contatore.o controllo_stato.o divisione_stampa.o main.o sistema_spento.o stampa_riga.o

$(EXE): $(OBJ)
	$(LD) -m elf_i386 -o $(EXE) $(OBJ)	#per linkare a 32 bit
	rm -f *.o core
atoi1.o: $(SRC_DIR)/atoi1.s
	$(AS) $(FLAGS) -o $@ $<
atoi4.o: $(SRC_DIR)/atoi4.s
	$(AS) $(FLAGS) -o $@ $<
contatore.o: $(SRC_DIR)/contatore.s
	$(AS) $(FLAGS) -o $@ $<
controllo_stato.o: $(SRC_DIR)/controllo_stato.s
	$(AS) $(FLAGS) -o $@ $<
divisione_stampa.o: $(SRC_DIR)/divisione_stampa.s
	$(AS) $(FLAGS) -o $@ $<
main.o: $(SRC_DIR)/main.s
	$(AS) $(FLAGS) -o $@ $<
sistema_spento.o: $(SRC_DIR)/sistema_spento.s
	$(AS) $(FLAGS) -o $@ $<
stampa_riga.o: $(SRC_DIR)/stampa_riga.s
	$(AS) $(FLAGS) -o $@ $<
clean:
	rm -f *.o core
clean_exe:
	rm -f *.o $(EXE) core
