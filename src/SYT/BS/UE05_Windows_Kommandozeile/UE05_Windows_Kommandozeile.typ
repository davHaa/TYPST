#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#show: template 

#let filename = "05_Windows_Kommandozeile";

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ Ziel der Übung
#v(2mm)
Bevor Sie sich als Systemadministrator gekonnt auf der klassischen
Windows-Befehlszeile bewegen, müssen Sie sich erst einmal einige
Grundlagen aneignen. Diese werden wir uns in dieser Übung erarbeiten!
Die wesentlich moderne Windows-*Powershell* (als Nachfolger von
`cmd.exe`) schauen wir uns etwas später an.

== B~~~ Inbetriebnahme der VM und Vorüberlegungen
#v(2mm)
#set enum( //Nummerierung 
  full:true, 
  numbering: numbly("{1:(1)}", "{2:a})")
)

Für diese Übung verwenden Sie Ihre gewohnte Windows 11 VM _(Linked Clone)_.
Sie können die Übung auch nativ auf Ihrem Rechner ausführen, falls Sie Windows 10 oder neuer benutzen.
Beantworten Sie alle gestellten Fragen und dokumentieren Sie sämtliche Befehle
sowie die Befehlsausgaben!

+ Nennen Sie drei Gründe, warum man mit der Kommandozeile arbeitet!


== C~~~ Einführung in die Windows Command Line (`cmd`)
== C.1~~~ Der Befehl `help`
#v(2mm)
#set enum( //Nummerierung 
  full:true, 
  start: 2,
  numbering: numbly("{1:(1)}", "{2:a})")
)

+ Sie können auf der Kommandozeile für viele einfache Befehle auch mit
    `help Befehlsname` Hilfe zur Verwendung des jeweiligen
    Befehls erhalten.

    → Was macht etwa der Befehl `prompt`?  _Tipp:_ `help prompt`

+ Überprüfen Sie Ihre Erkenntnis z.B. mit dieser Befehlszeile:

        `prompt Dein Wunsch ist mir Befehl!`

    _Tipp:_ Die Original-Eingabeaufforderung erhalten Sie zurück mit `prompt $p$g`!
 
== C.2~~~ Eingebaute Befehls-Hilfe
#v(2mm)
Die meisten Befehle der Kommandozeile geben auch selbst bereitwillig Auskunft
über ihre Verwendung, indem man die Option `/?` (und sonst nichts)
an den Befehl anhängt – verwenden Sie das für die folgenden Fragen:

#set enum( //Nummerierung 
  full: true,
  start: 4,
  numbering: numbly("{1:(1)}", "{2:1}"),
)

+ Was macht der Befehl `dir` ? (*Tipp*: `dir /?`)
+ Der Befehl `dir` kann auch nur Dateien und Ordner mit
    bestimmten (angegebenen) Attributen auflisten:
    1.  Mit welcher Option?
    2.  Welche Attribute gibt es da überhaupt?
    3.  Mit diesem Wissen: Wie kann man konkret die versteckten Dateien
        und Ordner im Stammverzeichnis (`\`)
        des Laufwerks `C:` auflisten?

== C.3~~~ Arbeiten mit CMD

#set enum( //Nummerierung 
  full: true,
  start: 6,
  numbering: numbly("{1:(1)}", "{2:a.})"),
)
_Beachte:_

 - Sofern nicht ausdrücklich anders angegeben, sind alle Aufgaben unter der Verwendung der Kommandozeile zu erledigen, nicht mit dem GUI/Explorer! 
 - Dokumentieren Sie im Laborprotokoll, welche Befehlszeilen Sie genau verwendet haben! 
 - Verwenden Sie nach Möglichkeit die Cursortasten, um vorherige Befehle nochmals zu verwenden bzw. um diese zu editieren. 
 - Benutzen Sie die Tabulatortaste zur Vervollständigung von Datei- und Verzeichnisnamen. 


+ Erstellen Sie mittels `cmd.exe` folgenden Verzeichnisbaum (mit
    den Verzeichnissen `DIR_A`, `DIR_Ax` usw.) in einem _Unterverzeichnis_ `ORDNER_XXXX` des Benutzerverzeichnisses von `junioradmin` (also unterhalb `C:\Users\junioradmin`). XXXX

```
       C:
       |
       \
       + Users
         + junioradmin
           + ORDNER_XXXX
             + DIR_A
             |   + DIR_Ax
             |   |   + DIR_Ax1
             |   |   + DIR_Ax2
             |   + DIR_Ay
             |   |   + DIR_Ay1
             |   |   + DIR_Ay2
             |   + DIR_Az
             |       + DIR_Az1
             |       + DIR_Az2
             + AllFiles

```

#set enum( //Nummerierung 
  full: true,
  start: 7,
  numbering: numbly("{1:(1)}", "{2:1.}", "{3: a.}"),
)
+  Erstellen Sie mit dem folgenden Befehl (und einer Umleitung der
    Ausgabe des Befehls `echo`) eine Datei namens `Datei_Ax1.txt` im Verzeichnis
    `ORDNER_XXXX`:\
     ```
     echo Textinhalt von Datei_Ax1 > Datei_Ax1.txt
     ```
+  Erstellen Sie sodann (noch im Ordner `ORDNER_XXXX`) die Dateien
    `Datei_Ax2.txt`, `Datei_Ay1.txt`, `Datei_Ay2.txt`,
    `Datei_Az1.txt `und `Datei_Az2.txt –` verwenden Sie die
    Komfortfunktionen zum Editieren der Kommandozeile _(welche?)._
+  Kopieren Sie nun alle Dateien in die entsprechenden Verzeichnisse,
    also zum Beispiel `Datei_Ay1.txt` in das Verzeichnis
    `ORDNER_XXXX\DIR_A\DIR_Ay\DIR_Ay1`. Wie sieht hierbei der Befehl für das
    Kopieren aus (zumindest ein Beispiel)?
+  Verschieben Sie nach dem Kopieren alle Dateien aus dem Verzeichnis
    `ORDNER_XXXX` in das Unterverzeichnis `AllFiles`. Wie sieht der
    Befehl dazu aus?
+  Stellen Sie fest, was der Befehl `tree` bewirkt (aufrufen!).

     Rufen Sie den Befehl `tree` nun so auf, dass, ausgehend vom
     Order `junioradmin`, Unterordner und Dateien angezeigt
     werden und kontrollieren Sie damit, ob alle Dateien im richtigen
     Verzeichnis sind.

     _Wichtig:_ Ausgabe des `tree`-Befehls in das Protokoll!
     Und auf Moodle/Eduvidual als Screenshot.

+  Wechseln Sie in das Verzeichnis `AllFiles`. Lassen Sie sich
    mit dem Befehl `type` den Inhalt der Datei `Datei_Ax1.txt` anzeigen.

    Kann man sich mit dem Befehl
    `type` den Inhalt aller Dateien anzeigen lassen? Wenn ja, wie
    macht man dies?

+  Finden Sie mit einer Hilfe-Funktion Ihrer Wahl heraus, was die Befehle `time` und `date` machen. Wie kann man diese Befehle ausführen, ohne das Datum oder die Systemzeit eingeben zu müssen?

+  Vergleichen Sie mit der Hilfe die Befehle `copy` und `robocopy`. Welche sind Ihrer Meinung nach die wesentlichsten Vorteile von `robocopy` gegenüber `copy`? Konsultieren Sie ggf. auch das Web, etwa _#link("https://de.wikipedia.org/wiki/Robocopy")[https://de.wikipedia.org/wiki/Robocopy]_.

//Nummerierung fxen
+  Beantworten Sie folgende Fragen:
    1.  Welche Rolle spielen Groß- und Kleinschreibung bei Datei- und
        Ordnernamen?

        a. beim Anlegen?
        b. beim Zugriff?
        c. bei der Anzeige?

    2.  Was bedeuten die Parameter `/S` und `/Q` des Befehls
        `rmdir`?
    3.  Im Verzeichnis `ORDNER_XXXX`: Was würde der Befehl
        `rmdir /S DIR_A` im obigen Beispiel bewirken?
    4.  Besteht ein Unterschied zwischen folgenden Befehlen?

        a.  `mkdir Verzeichnis fuer die Uebungen`
        
        b.  `mkdir "Verzeichnis fuer die Uebungen"`

             Wenn ja, welcher? Wozu kann man diese Erkenntnis eventuell
             nutzen *(Stichwort: Effizientes Arbeiten mit der Kommandozeile)* ?

== D~~~ Umleitung der Ausgabe
#v(2mm)

#set enum( //Nummerierung 
  full: true,
  start: 16,
  numbering: numbly("{1:(1)}", "{2:1.}"),
)
+  Sie kennen bereits den Befehl `tree` – lassen Sie sich erneut
    Ihre Verzeichnisstruktur (unter `ORDNER_XXXX` – mit Dateien) ausgeben.
    Schreiben Sie diese anschließend in die Datei `MyTree.txt`.
    Wie macht man das _(Tipp: `Befehlszeile > Datei`)_ ?
+  Öffnen Sie nun die Datei `MyTree.txt` im Editor
    `Notepad`. Welches Problem kann man evtl. erkennen (siehe GINF)?
    Wie kann das Problem (so vorhanden) gelöst werden?
+  Hängen Sie der Datei (ohne Editor) anschließend folgende zwei Textzeilen an
     (_Tipp:_ Für das ``<Datum>`` verwenden Sie die Ausgabe des Befehls `date` mit der richtigen Option → Befehl ins Protokoll einfügen!):

       `Printed on:`

       `<Datum>`

+  Geben Sie den Text-Inhalt der Datei 1:1 schlussendlich als Anhang in Ihr Übungsprotokoll und laden Sie die Textdatei auch auf Moodle/Eduvidual hoch!

+  Lassen Sie den gesamten Systembaum (ohne Dateien) auf die Konsole
    schreiben. Allerdings so, dass Sie umblättern können (seitenweise).

+  Erzeugen Sie mit `notepad` eine
    Textdatei `unsorted.txt`, die 10 Zeilen enthält, die jeweils
    ein (anderes) Paar „`Nachname Vorname`“ enthält (mit Ihrem Name und dem von 9 Ihrer Mitschüler
	ohne Anführungszeichen) – und zwar unsortiert (also *nicht* in
    alphabetischer Reihenfolge)!
    1.  Wie kann man diese Namen sortiert auf die Konsole ausgeben?
        (_Tipp:_ `sort`)

    2.  Wie kann man eine zweite Datei `sorted.txt` erzeugen, die
        dieselbe Liste an Namen enthält, allerdings in *sortierter*
        Reihenfolge? (_Tipp:_ Ausgabeumleitung)

*Viel Spaß!*