#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4; 
#show: template 

#let filename = "00_Computer_Grundlagen";


#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)


= A~~~ Einführung

== A.1~~~ Geschichte

Warum 8085?

Link: #link("https://www.ordersomewherechaos.com/rosso/fetish/m102/web100/docs/intel-8085-overview.html")

Genese: 
4004 → 4040 → 8008 → 8080 → *8085* → 8086 → 8088 → 80186 →
80286 → 80386 → 80486 → Pentium → Pentium Pro → ...

Über Registerarchitektur:
“We can store data directly inside the CPU.
The 8085 has seven 8-bit registers. Each register can store a value from
00h to 0FFh (0 to 255).
Unless otherwise specified, a constant which is always numberic is in decimal form. If appended
with a character *h* it is assumed to be in hexadecimal form.  If a hex
constant starts with an alpha-char (A..F) don't forget to include the number *0* in the begining, since that will help the assembler to differentiate between a label and a constant.#footnote[Note that many other programming languages (like Java or C++) denote numbers beginning with a *0* digit as octal numbers!]

The registers are designated by single letters: A, B, C, D, E, H and L. They are not all created equal, and are used for different purposes.”

Ein Tutorial, das die Programmierung des 8085 auf einem echten Computer beschreibt (Radioshack’s TandyModel 100) findet sich auf: #link("https://www.ordersomewherechaos.com/rosso/fetish/m102/web100/docs/assemb-tutorial.html")

== A.2~~~ Aufbau einer Zeile:

`Label:  Befehl Operand ; optionaler Kommentar`

*Label*
:   Name für Speicheradresse. Labels sind optional und können für Variablen oder Sprungziele verwendet werden.

*Befehl*
:   Was ist zu tun? Meist auf einige (drei) Buchstaben abgekürzt, #link("http://de.wikipedia.org/wiki/Mnemonik")[sogenannte mnemonische Symbole]
     (Mnemonic)

      

*Operand (= Parameter)*
:   Was sind die Werte (Operanden = Parameter) für den Befehl (0, 1 oder 2
     Werte oder Registernamen)?

*Kommentar*
:   Wird mit *;* eingeleitet

Jeder Befehl wird vom Assembler in eine Zahl (Opcode) umgewandelt. Die Operanden (= Parameter) werden entweder in den Befehl „hineinkodiert“ oder in den nächsten Speicherstellen abgelegt. Im Speicher stehen nur Zahlen ohne Hinweis auf deren Bedeutung (Code oder Daten–> von Neumann-Architektur!).
 
Tipp: Üblicherweise werden Befehle ohne Label zur besseren Lesbarkeit eingerückt.

== A.3~~~ Miniprogramm

#count4[*Gnusim8085* starten, _Datei / New_ erzeugt folgendes Programmgerüst:]
    
       ```Assembler
       ;<Program title>
              JMP start
              ;data
              ;code 
       start: NOP
              HLT
       ```
#count4[Übersetzen: _Assembler / Assemblieren_]

- Speichern als: *ue1.asm* (Endung muss angegeben werden!)

#count4[Ergebnis betrachten: _Assembler / Listing_ anzeigen]

Hinweise:

- Beim Assemblerlisting steht am Anfang der Zeile die Adresse, dann der übersetzte Befehl als Opcode gefolgt von eventuellen Operanden (Werten bzw. Adressen).

- Assembler ist nicht case-sensitive.

-  Die Startadresse ist vom Prozessor, einer eventuell vorhandenen Firmware bzw. Betriebssystem abhängig kann man im GNUSim8085 einstellen (Laden bei…)#footnote[Mit _Laden bei_ akzeptiert der Simulator leider nur Dezimalwerte.]. 

- Nach einem Label muss (bei diesem Assembler) immer ein Befehl kommen, darum steht in den Beispielen „`start: NOP`“.

- Der Befehl „`H`a`LT`“ ist für das Beenden der Simulation wichtig, normalerweise läuft ein Prozessor „ewig”.

= B~~~ Die konkreten Aufgaben

Das Durchführungsprotokoll zur Übung muss folgendes enthalten _(das liefern Sie als Ergebnis Ihrer Arbeit!)_:

- Antworten auf alle gestellten Fragen.
- *Alle* Beispiele als Assemblerlisting eingefügt.
-   Einige Fragen sind mit _Internetrecherche_ bzw. _Bonusfrage_
    gekennzeichnet. Diese Fragen sollten erst nach dem Beenden der Übung
    bzw. während der Ausarbeitung des Protokolls beantwortet werden.
-   Einige Beispiele sind als Bonusaufgaben gekennzeichnet. 
    Diese Fragen können vorerst übersprungen werden – Super-Profis lösen aber auch diese Probleme....

_Viel Spaß!_

== B.1~~~ Erstes Programm

*Gnusim8085* starten, erstes Programm wie oben.

« Listing hier einfügen, in einer *`Schriftart mit fixer Breite`* formatieren und farblich hervorheben!»

_Tipps (Keyboard-Shortcuts):_

-   Strg-L zeigt *L* isting an (wenn Programm gerade nicht läuft), Alt-F4
    schließt Listing-Fenster wieder 
-   Strg-R (*R* eset) initialisiert alles auf Einschalt-Status (Inhalt des Speichers 
	und der Register wird auf Null gesetzt). An besten immer vor dem Starten eines
    Assembler-Programmes ausführen.  
-   F8 assembliert (übersetzt Assembler-Mnemonics in Maschinensprache) 
-   F5 (oder Pfeil-Icon) führt einen Programmschritt aus

#count1[Beantworte folgende Fragen:

+ An welcher Speicherstelle beginnt unser Programm (standardmäßig#footnote[sofern man nicht mittels _Laden bei_ einen andere Adresse definiert])?

+ Welchen Opcode hat `NOP` (No Operation)?

+ Welchen Opcode hat `JMP`?

+ Wo steht das Sprungziel beim Befehl `JMP`?

+ Wiederholung GINF: Erkläre den Unterschied zwischen „little endian“ und „big endian“!
 
+ *Bonusfrage:* Woher kommt dieser Ausdruck?
 
+ Wie viele verschiedene Befehle (Opcodes) kann es beim 8085 (theoretisch) maximal geben (mit Begründung)?]

#count1[Starte das Programm mit `Fehlerdiagnose / Schritt in` oder `F5`
+ Was passiert nach einem weiteren _Schritt in den Code_?
+ Was steht allgemein im Register `PC`? Wann ändert sich dieser Wert jeweils?
+ Was ist ein Register eigentlich?
]

== B.2~~~ Erste Befehle

#count[Ergänzen Sie folgende Befehle nach dem Start des Programms (vor dem `HLT`):]

```Assembler
          MVI A, YYh
          MVI C, 0EDh 
          MOV D, A
```
#count1[Übersetzen Sie das Programm und führen Sie es schrittweise aus.
    Beobachten Sie links die Anzeige der Register.

    Beantworten Sie folgende Fragen (getrennt für _jeden_ der drei
    Befehle):

+ Welchen Opcode hat der Befehl?
+ Was macht der Befehl? Beobachten Sie dazu die Änderungen der Register und Flags und beschreiben Sie diese in eigenen Worten!
+ Warum gibt es zwei Opcodes für `MVI`?]

_Tipp:_ Unter
#link("http://web8085.appspot.com/help/index.html")
findet man eine Beschreibung aller Befehle.


== B.3~~~Variablen

Reservieren von Speicher:

*DB* _Define Byte_ – einzelne Speicherstellen mit Startwert

*DS* _Define Size_ – viele Speicherstellen _(Array of Bytes)_, Größe wird in Byte angegeben

_Wichtig_ Eine von Neumann-CPU kennt nur Speicher, sie unterscheidet nicht zwischen Programm und Variablen. Der gesamte Speicher besteht für die CPU aus Bytes, ob mehrere Bytes (z.B. einen 16- oder 32-bit Wert) ein Array, einen String oder Opcodes darstellen, liegt in der Logik des Programms!

#count[Schreiben Sie folgendes Programm:]

```Assembler
         JMP start
;data
var1:    DB 195
var2:    DB 2, 66
var3:    DS 8

;code
start:   NOP
         LDA  var2
         INR  A
         STA  var3+3
         HLT
```

#count1[Beantworte folgende Fragen
+ Welche Adressen haben die Variablen (rechts unter _Daten_)?
+ Welche Werte stehen im Speicher (rechts unter Speicher) ab der
Start-Adresse 4200H? Tipp: Gehen Sie am besten vom Assembler-Listing aus
und geben Sie für jede Adresse den Wert sowie eine kurze Beschreibung an!
+ Wie kann man Datenwerte und Befehle („das Programm“) unterscheiden?
    Im Detail: Wie kann man den Wert bei 4200h (Welcher?) und den Wert in 4203h (welcher?) unterscheiden?
+ Was machen die Befehle `LDA`, `STA` und `INR`?
       _Tipp:_ Den Inhalt der Variablen sieht man rechts unter Daten _bzw.
         Speicher_!

+ Wann wird `var3+3` ausgerechnet _(siehe dazu auch nächster Punkt)_?

+ *Wiederholung GINF*: Erklären Sie die Begriffe bzw. den #link("https://www.quora.com/What-are-the-differences-between-compile-time-and-run-time", [Unterschied]): „run time“ und „compile time“!
          
+ Wie viele Taktzyklen dauert die Ausführung des Programms (_ohne_ den abschließenden `HLT`-Befehl)? Verwenden Sie dazu die Tabelle aus dem GINF-Unterricht bzw. Handout zur Laborübung!
          
+ Jemand überschreibt die ersten drei Byte des übersetzten Programmes mit `00`. Was passiert, wenn man anschließend das Programm auf einer 8085 CPU#footnote[Mit unserem Simulator kann man dieses Szenario nicht ausprobieren, weil dieser den Prozessor leider nicht perfekt simuliert.] startet?]

== B.4~~~ Spaß mit Flaggen: Addition

 #count[Was macht das folgende Programm? – Ergänzen Sie jede Zeile mit einem Kommentar]

 ```Assembler
         JMP start
;data
v1:      DB YY
v2:      DB 100
r:       DB 0

;code
start:   NOP
         LDA  v2
         MOV  B, A
         LDA  v1
         ADD  B
         STA  r

         HLT
```

#count1[ Welcher Wert steht jeweils am Ende in (der Speicherstelle) `r` und im C-Flag _(Carry)_?
+ Beim Wert `v1 = YY`?
+ Was passiert, wenn man `v1` auf den Wert `1YY` ändert?
+ Was passiert, wenn man `v1` auf den Wert `2YY` ändert? 
+ *Bonus:* Wie erklären Sie sich dieses eigenartige Verhalten von c?]

#count[Was macht folgender Programmteil?]

```Assembler
         MVI A, 0YYh
         MVI B, 011h
         STC
         ADC B
```
#count1[Addieren
+ Was ist der Unterschied zwischen den Befehlen `ADD` und `ADC`?
+ Welche Bedeutung hat das _Carry_-Flag (Bit)? Wofür kann man das verwenden?]

== B.5~~~ Schleife

```Assembler
         MVI A, 02h
         DCR A
         DCR A
         DCR A
```

#count1[Fragen
+ Was macht `DCR`?
+ Welcher Wert steht am Ende in A? 
+ Wie erkennt man, dass A den Wert 0 erreicht hat? Welche Flags werden bei `DCR` gesetzt?]

#count[Was macht das folgende Programm – ergänzen Sie jede Zeile mit einem Kommentar]

```Assembler
         MVI A, 03h
loop:    DCR A
         JNZ  loop
```
#count[Schreiben Sie ein Programm, das von 1 bis 8 hinauf zählt. 

Tipp: `CMP`, `CPI` _(Compare Immediate)_]

== B.6~~~ Unterprogramm

#count1[Was macht das folgende Programm? Ergänzen Sie wieder jede Zeile mit einem Kommentar!

```Assembler
         JMP start 

; Unterprogramm
subprog: ADD A
         RET

; Hauptprogramm
start:   NOP
    
         MVI A, 0YYh
         CALL subprog
         CALL subprog

         HLT
```
Detailfragen:
+ Untersuchen Sie, was nach dem ersten `CALL` passiert? 
 + Welche Register haben sich geändert? 
 + Was steht in den Speicheradressen (*Tipp*:
        Rechts bei _Speicher_ ab 0FFF0H oder bei `Stapel (Stack)`schauen!)
+ Was passiert bei `RET`?

+ Was bewirkt das Unterprogramm (und welcher Name wäre daher anstatt des Labels `subprog` besser geeignet)?
+ *Internetrecherche* bzw. Wiederholung GINF: Was ist ein #link("https://de.wikipedia.org/wiki/Stapelspeicher", [Stack-Speicher])? Wozu wird er hier verwendet?
]

== B.7~~~ 16-Bit Addition

Gesucht ist ein Programm das zwei 16-Bit Werte addiert

#count1[Überlegungen:

+ Wie viele Bytes braucht man für 16 Bit?
+ Wie viele Speicherstellen braucht man für einen 16-bit Wert?
+ In welcher Reihenfolge speichert man diese Werte?
+ Wozu dient noch einmal das _Carry_-Flag?
+ *Bonusaufgabe* (nicht schwierig, wenn man in GINF zugehört hat): Schreiben Sie das Programm!]

  Hinweise:

- _Tipp_: Wie in der Volksschule! Jeweils eine Stelle (hier ein Byte)addieren – versuchen Sie den Ablauf vorher zu beschreiben und daraus das Programm zu entwickeln.

- Übertrag nicht vergessen, d.h. verwenden Sie `ADD` und/oder `ADC`!

- Das Carry-Flag wird nur von wenigen Befehlen geändert, man kann z.B. Werte aus dem Speicher laden und zurückspeichern ohne dieses Flag zu beeinflussen.

== B.8~~~ Indirekte Adressierung

#count[*Internetrecherche* bzw. Wiederholung aus GINF: Was ist ein Zeiger (Pointer)?]

Der 8085 verfügt über ein _Pseudo_-Register `M`. Dieses verweist auf die Speicherstelle, deren 16-Bit-Adresse im Registerpaar `H` und `L` steht.

#count1[Was macht das folgende Programm? – ergänzen Sie jede Zeile mit einem Kommentar!

+ Welcher Wert steht am Ende in `A` und warum?]

```Assembler
         JMP start

;data
werte:   DB 2, 3, 5, 7, 11, 0

;code
start:   NOP

         LXI  H, werte
         MOV  A, M
         INX  H
         ADD  M
         INX  H
         ADD  M 

         HLT
```
#count1[*Bonusaufgabe*: Erweitern Sie das Programm:
+ Addieren Sie in einer Schleife alle Werte bis zum Wert `0`(Endekennung), verwenden Sie ein weiteres Register als Hilfsvariable für die Zwischensumme.

+ MOV ändert keine Flags, verwenden Sie `CMP` oder `CPI` *(Compare Immediate)* oder `SUB` bzw. `SUI` (Subtraktion)]

_Happy coding!_