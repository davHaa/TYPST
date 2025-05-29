#import "../resources/SEW_Template.typ": create_page_template
#import "../resources/SEW_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/SEW_Template.typ": count, count2, count6; 
#show: template 

#let filename = "03_CSV";

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ Lesen von CSV-Dateien
#v(2mm)
Format: #link("https://de.wikipedia.org/wiki/CSV_%28Dateiformat%29")[https://de.wikipedia.org/wiki/CSV_%28Dateiformat%29]

Zusatzinfo:
- #link("https://donatstudios.com/Falsehoods-Programmers-Believe-About-CSVs")[https://donatstudios.com/Falsehoods-Programmers-Believe-About-CSVs>]
- #link("https://tools.ietf.org/html/rfc4180")[https://tools.ietf.org/html/rfc4180]

== B~~~ Aufgabe
#v(2mm)
- *Abgabe*: im Github-Repository / Module `ue03` -- Package `csv`
- Schreibe eine Klasse `CSVReader`.
- Zu jeder Aufgabe sollte es mindestens zwei Testfälle geben (JUnit).
- Schon ab der ersten Version ist wegen der Erweiterungen eine Statemachine (FSM) mit
 Enums (mit `abstract` Methoden)  zu verwenden.
- Pro Aufgabe mindestens ein `git commit` mit sinnvoller Message.

== B.1~~~ Einfache Version
#v(2mm)
Eingabe besteht nur aus einer Zeile, Trennzeichen ist das Komma.
\
Beispiel: `«one,two,three»` liefert das String Array: `["one", "two", "three"]`

== B.2~~~ Mit Stringbegrenzer
#v(2mm)
Felder können auch mit einem Stringbegrenzer-Zeichen umgeben werden -- innerhalb der Begrenzungszeichen sind dann alle Zeichen zulässig. Die Begrenzungszeichen werden
*nicht* in das Ergebnis übernommen.

Standard-Stringbegrenzer ist das Anführungszeichen (`"`).

Achtung: der Stringbegrenzer muss am Anfang und Ende eines Feldes stehen

- ein Stringbegrenzer mitten in einem Feld ohne Stringbegrenzer ist zulässig
- Text nach dem _abschließenden_ Stringbegrenzer ist nicht zulässig (Illegal Argument-Exception)
- ein fehlender Stringbegrenzer am Ende ist auch ein Fehler

Beispiele: 

- `«"uno",dos,"tres, cuatro",cin"co"»` liefert: `["uno", "dos", "tres, cuatro", "cinco"]`
- `«"nicht"ok»` liefert Illegal Argument-Exception
- `«"nicht ok»` liefert Illegal Argument-Exception

== B.3~~~ Stringbegrenzer in den Daten
#v(2mm)
Wenn der Stringbegrenzer selbst in den Daten enthalten ist, muss dieser verdoppelt werden.

Beispiel: `«"ein,s","zw""ei",drei»` liefert das String Array: `["ein,s", "zw\"ei", "drei"]`

== B.4~~~ Feature `skip initial space`
#v(2mm)
Die FSM entfernt führende Leerzeichen und Tabulatoren (`Character.isWhitespace()`) in den Feldern.
\
`«  "ab,cd"»` ist gültig.

== B.5~~~ Konfiguration
#v(2mm)
Verbesserte Version, alle Zeichen sind im Konstruktor *einstellbar*.

- `delimiter` -- Trennzeichen zwischen den Feldern
- `doublequote` -- Stringbegrenzer
- `skipinitialspace` -- soll Whitespace entfernt werden: ja oder nein?

== B.6~~~ neue Klasse `CSVFileReader`
#v(2mm)
Der Konstruktor bekommt einen Dateinamen.

Mit der Methode `next()` erhält man den nächsten Datensatz (eine gesplittete Zeile)
aus der Datei.

*Wichtig*: im Konstruktor alle Zeilen einlesen ist eine schlechte Idee.

Überlege

- Wie man End-of-File erkennt bzw. weitergibt (_Tipp_: ähnlich `readline()`)?
- Was man mit `IOException`s macht?


== B.7~~~ Erweiterungen
- wenn man das Interface `Closeable` implementiert kann man `try(...)` verwenden
- wenn man das Interface `Iterable` implementiert kann man eine `for each`-Schleife verwenden

== C~~~ Erweiterungen
#v(2mm)
Einlesen von CSV-Datei -- _Adjazenzmatrix_ mit Knoten und Kantengewichten (kann man als _Weglänge_ zwischen zwei Punkten interpretieren)

```
;A;B;C;D;E;F;G;H
A;;4;7;8;;;;
B;4;;;;5;3;;
C;7;;;2;;;1;
D;8;5;2;;1;;2;
E;;3;;1;;1;;5
F;;3;;;1;;;1
G;;;1;2;;;;1
H;;;;;5;1;1;
```

soll folgende Information ausgeben:
```
A: nach B:4, nach C:7, nach D:8
B: ...
...
```
Wichtig: Fehlererkennung bei _schlechten_ Dateien.



