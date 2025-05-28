#import "../resources/BS_Template.typ": create_page_template

#let filename = "UE00_Computer_Grundlagen";


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

 Genese: 4004 → 4040 → 8008 → 8080 → *8085* →8086 →8088→80186→80286→80386→80486→Pentium
 →Pentium Pro → …

Über Registerarchitektur: “We can store data directly inside the CPU. The 8085 has seven 8-bit registers. Each register can store a value from 00h to 0FFh (0 to 255). Unless otherwise specified, a constant which is always numberic is in decimal form.If appended with a character *h* it is assumed to be in hexadecimal form. If a hex constant starts with an alpha-char (A..F) don’t forget to include the number *0* in the begining, since that will help the assembler to differentiate between a label and a constant. #footnote Note that many other programming languages (like Java or C++) denote numbers beginning with a 0 digit as octal 

The registers are designated by single letters: A, B, C, D, E, H and L. They are not all created equal, and are used for different purposes.”

Ein Tutorial, das die Programmierung des 8085 auf einem echten Computer beschreibt (Radioshack’s TandyModel 100) findet sich auf: #link("https://www.ordersomewherechaos.com/rosso/fetish/m102/web100/docs/assemb-tutorial.html")

== A.2~~~ Aufbau einer Zeile:

 Label: Befehl Operand ; optionaler Kommentar

 *Label* Name für Speicheradresse. Labels sindb optional und können für Variablen oder Sprungziele verwendet werden.

*Befehl* Was ist zu tun? Meist auf einige (drei) Buchstaben abgekürzt, sogenannte mnemonische Symbole (Mnemonic)

*Operand* (= *Parameter*) Was sind die Werte (Operanden = Parameter) für den Befehl (0, 1 oder 2 Werte oder Registernamen)?

*Kommentar* Wird mit ; eingeleitet

Jeder Befehl wird vom Assembler in eine Zahl (Opcode) umgewandelt. Die Operanden (= Parameter) werden entweder in den Befehl „hineinkodiert“ oder in den nächsten Speicherstellen abgelegt. Im Speicher stehen nur Zahlen ohne Hinweis auf deren Bedeutung (Code oder Daten–> von Neumann-Architektur!).
 
Tipp: Üblicherweise werden Befehle ohne Label zur besseren Lesbarkeit eingerückt.

== A.3~~~ Miniprogramm

 a.~~~~~~ *Gnusim8085* starten, Datei / New erzeugt folgendes Programmgerüst:

 ```
     ;<Program title>
            JMP start
            ;data
            ;code
     start: NOP
            HLT
``` 
b.~~~~~~ Übersetzen: Assembler / Assemblieren



- Speichern als: ue1.asm (Endung muss angegeben werden!)

c.~~~~~~ Ergebnis betrachten: Assembler / Listing anzeigen

Hinweise:

- Beim Assemblerlisting steht am Anfang der Zeile die Adresse, dann der übersetzte Befehl als Opcode gefolgt von eventuellen Operanden (Werten bzw. Adressen).

- Assembler ist nicht case-sensitive.

-  Die Startadresse ist vom Prozessor, einer eventuell vorhandenen Firmware bzw. Betriebssystem abhängig kann man im GNUSim8085 einstellen (Laden bei…). 

- Nach einem Label muss (bei diesem Assembler) immer ein Befehl kommen, darum steht in den Beispielen „start: NOP“.

- Der Befehl „HaLT“ ist für das Beenden der Simulation wichtig, normalerweise läuft ein Prozessor „ewig”.

= B~~~ Die konkreten Aufgaben

Das Durchführungsprotokoll zur Übung muss folgendes enthalten (das liefern Sie als Ergebnis Ihrer Arbeit!):

- Antworten auf alle gestellten Fragen.

- *Alle* Beispiele als Assemblerlisting eingefügt.

- Einige Fragen sind mit Internetrecherche bzw. Bonusfrage gekennzeichnet. Diese Fragen sollten erst nach dem Beenden der Übung bzw. während der Ausarbeitung des Protokolls beantwortet werden.

- Einige Beispiele sind als Bonusaufgaben gekennzeichnet.Diese Fragen können vorerst übersprungen werden – Super-Profis lösen aber auch diese Probleme….

Viel Spaß!

== B.1~~~ Erstes Programm

*Gnusim8085* starten, erstes Programm wie oben.

« Listing hier einfügen, in einer Schriftart mit fixer Breite formatieren und farblich hervorheben!»

Tipps (Keyboard-Shortcuts):

-  Strg-L zeigt Listing an (wenn Programm gerade nicht läuft), Alt-F4 schließt Listing-Fenster wieder

- Strg-R (Reset) initialisiert alles auf Einschalt-Status (Inhalt des Speichers und der Register wird auf Null gesetzt). An besten immer vor dem Starten eines Assembler-Programmes ausführen.

- F8 assembliert (übersetzt Assembler-Mnemonics in Maschinensprache)

- F5 (oder Pfeil-Icon) führt einen Programmschritt aus

(1)~~~ Beantworte folgende Fragen:

~~~~~~~~~a. An welcher Speicherstelle beginnt unser Programm (standardmäßig)?

~~~~~~~~~b. Welchen Opcode hat NOP (No Operation)?

~~~~~~~~~c. Welchen Opcode hat JMP?

~~~~~~~~~d. Wo steht das Sprungziel beim Befehl JMP?

~~~~~~~~~e. Wiederholung GINF: Erkläre den Unterschied zwischen „little endian“ und „big endian“!
 
~~~~~~~~~f. Bonusfrage: Woher kommt dieser Ausdruck?
 
~~~~~~~~~g. Wie viele verschiedene Befehle (Opcodes) kann es beim 8085 (theoretisch) maximal geben (mit Begründung)?

(2)~~~ Starte das Programm mit Fehlerdiagnose / Schritt in oder F5

~~~~~~~~~a. Was passiert nach einem weiteren Schritt in den Code?

~~~~~~~~~b. Was steht allgemein im Register PC? Wann ändert sich dieser Wert jeweils?

~~~~~~~~~c. Was ist ein Register eigentlich?

== B.2~~~ Erste Befehle

(3)~~~ Ergänzen Sie folgende Befehle nach dem Start des Programms (vor dem HLT):

```
 MVI A, 23h
 MVI C, 0EDh
 MOV D, A
```
(4)~~~ Übersetzen Sie das Programm und führen Sie es schrittweise aus. Beobachten Sie links die Anzeige der Register.

Beantworten Sie folgende Fragen (getrennt für jeden der drei Befehle):

a. Welchen Opcode hat der Befehl?

b. Was macht der Befehl? Beobachten Sie dazu die Änderungen der Register und Flags und beschreiben Sie diese in eigenen Worten!

c. Warum gibt es zwei Opcodes für MVI?

== B.3~~~Variablen

 Reservieren von Speicher:

*DB* Define Byte– einzelne Speicherstellen mit Startwert

*DS* Define Byte– einzelne Speicherstellen mit Startwert

*Wichtig* Eine von Neumann-CPU kennt nur Speicher, sie unterscheidet nicht zwischen Programm und Varia
blen. Der gesamte Speicher besteht für die CPU aus Bytes, ob mehrere Bytes (z.B. einen 16- oder 32-bit Wert) ein Array, einen String oder Opcodes darstellen, liegt in der Logik des Programms!

(5)~~~ Schreiben Sie folgendes Programm:

```
          JMP start
;data
var1: DB 195
var2: DB 2, 66
var3: DS 8
;code

start: NOP
       LDA var2
       INR A
       STA var3+3
       HLT
```
(6)~~~ Beantworte folgende Fragen

a. Welche Adressen haben die Variablen (rechts unter Daten)?

b.  Welche Werte stehen im Speicher (rechts unter Speicher) ab der Start-Adresse 4200H? Tipp: Gehen Sie am besten vom Assembler-Listing aus und geben Sie für jede Adresse den Wert sowie eine kurze Beschreibung an!

Die Speicherstelle 4200H hat den Wert und das bedeutet.(…)
