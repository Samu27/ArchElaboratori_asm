# Elaborato2 Assembly - Sistemi operativi

Secondo elaborato di Sistemi Operativi, Università di Verona.
Linguaggio Assembly.

### Specifiche elaborato

Si sviluppi un programma Assembly che effettua il monitoraggio di un motore a combustione interna. Ricevendo come input il numero di giri/minuto del motore (RPM) e, una volta impostate le soglie minima e massima per il funzionamento ottimale, il programma fornisce in uscita una modalita’ di funzionamento del motore: sotto-giri (SG), in regime ottimale (OPT) o fuori-giri (FG). Si vuole inoltre avere in uscita da quanto tempo il sistema si trova nello stato attuale ed un ulteriore output di allarme che vale 1 se e soltanto se il sistema si trova in stato FG da piu’ di 15 secondi (cicli di clock).
Il programma deve essere lanciato da riga di comando con due stringhe come parametri, la prima stringa identifica il nome del file .txt da usare come input, la seconda quello da usare come output: 
```
./run filenameInput.txt filenameOutput.txt
```
Il programma deve leggere il contenuto di filenameInput.txt contenente in ogni riga i seguenti valori: INIT,RESET,RPM
- INIT: valore binario, quando vale 0 il programma deve restituire una linea composta di soli 0; quando vale 1 il programma deve fornire in uscita tutti i valori come da specifica.
- RESET: valore binario, se posto a 1 il contatore dei secondi deve essere posto a zero.
- RPM: valore del numero di giri ricevuto dal rilevatore (valore massimo 6500).

Il programma deve restituire i risultati del calcolo in filenameOutput.txt in cui ogni riga contiene: ALM,MOD,NUMB
- MOD: indica in quale modalita’ di funzionamento si trova l'apparecchio al momento corrente (00 spento, 01 SG, 10 OPT, 11 FG)
- NUMB: indica i secondi trascorsi nell attuale modalita’.
- ALM: valore binario, messo a 1 se viene superato il tempo limite in FG.

I valori delle soglie sono i seguenti:
- RPM < 2000 → SG
- 2000 ≤ RPM ≤ 4000 → OPT
- RPM > 4000 → FG

Assieme al presente documento sono forniti due files di test testinput.txt e testoutput.txt. Per un voto sufficiente sull’elaborato e’ richiesto il perfetto funzionamento del programma su questi due files. Ai fini del test del progetto, verranno usati in fase di esame dei files diversi, che tuttavia avranno le stesse caratteristiche di quelli di esempio ed una lunghezza non superiore alle 100 righe.

Per maggiori informazioni: [relazione.pdf](relazione.pdf)

### Autori

* **Samuele Mori** - [Samu27](https://github.com/Samu27)
* **Andrea Faggion**
* **Wilma Valentino**

### Licenza

Questo progetto è sotto la licenza GPL_v3 - guarda il file [LICENSE.md](LICENSE.md) per ulteriori informazioni
