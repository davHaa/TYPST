#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#show: template 

#let filename = "07_Linux_Grundbefehle";


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
Sie verfügen nun bereits über die wichtigsten Grundkenntnisse auf der Windows-Kommandozeile CMD und haben vielleicht auch schon ein paar Gehversuche mit der _Powershell_ gemacht.

Da Sie als Systemadministrator im Server-Umfeld häufig auch mit _Linux_ konfrontiert werden, erarbeiten Sie sich nun  die
wichtigsten Grundlagen zur Administration dieses Betriebssystemes mit der  komfortablen Shell *`bash`*.

== B~~~ Inbetriebnahme der VM
#v(2mm)
Für diese Übung verwenden Sie eine _Kali-Linux-VM_, bei der Sie sich mit 
dem Login-Namen `junioradmin` anmelden.
Das Passwort der Schul-VM lautet wie gewohnt 
ebenfalls `junioradmin`.
Alternativ können Sie diese Übung auch unter dem _WSL_ = _Windows Subsystem for Linux_ (mit Ubuntu oder Debian) machen.  Username/Passwort bei WSL haben Sie bei der Installation vergeben.

== C~~~ Hilfe holen – die Manual Pages
#v(2mm)

#count[
  Schauen Sie sich mit dem Kommando `man` die _Manual Pages_ zu folgenden Befehlen an #footnote[_`man` `Befehl`_]:
`ls`, `pwd`, `cat`, `cp`, `mv`, `rm`, `mkdir`,  `rmdir`, probieren Sie *drei* dieser  Befehle jeweils
nachweislich aus (mit Test-Dateien bzw. Ordnern _-> zu allen Screenshots!_) und
beantworten Sie mit diesem Wissen nun auch die folgende Fragen:]

#count5[Wie kann man innerhalb des Programmes `man` (z.B. beim Aufruf `man ls`)

+ nach einem Text wie z.B. `-p` suchen? _(Tipp: "/...")_
+ zum *n* ächsten Suchtreffer springen?
+ zum vorhergehenden Suchtreffer springen *?*
+ `man` beenden? _(Tipp: *q*(uit))_]

#count[Wozu verwendet man den Befehl `ls`? Wofür dienen die Parameter `-lS` beim Befehl `ls`?]

#count[Was macht der Befehl `pwd`?]

#count[Was macht der Befehl `cat /etc/timezone`?]

#count5[Was macht der Befehl `cp`?

+ Wofür dient der Parameter `-r` beim Befehl `cp`?
+ Was bewirkt beim Befehl `cp` der Parameter `-p`?]

#count[Was macht `mv`? Wofür dient der Parameter `-f` beim Befehl `mv`?]

#count[Wofür dient der Parameter `-p` beim Befehl `mkdir`?]

#count[Wofür dienen die Parameter `-rf` beim Befehl `rm`?

    Was würde bei folgendem Befehl passieren (*nicht ausführen!!*): `rm -rf /` ?  (*don't try this at home!!*)#footnote[besonders nicht mit UEFI: #link("http://heise.de/-3113433")]]

#count[Was bewirkt die Option `-Q` des Befehls `ls`?]

#count[Versuchen Sie herauszubekommen, was der `.` (Punkt) als Dateinamensanfang bewirkt (legen Sie z.B. mit  `echo hallo > .meinedatei` eine solche Datei an und versuchen Sie diese dann mit
`ls` aufzulisten).

Was macht  dementsprechend der Befehl `ls -la`?]

#count[Was bewirken die folgenden Optionen für `ls`:  `-t -r` oder kürzer `-rt`?
Wozu kann also der Befehl `ls -rtl` nützlich sein (siehe auch (log) im nächsten Abschnitt!)?] // Hier muss noch die verkünpfung von log hergestellt werden mit punkt (15)

== D~~~ Grundlegende Befehle der Datei- und Verzeichnisverwaltung
#v(2mm)
Führen Sie folgende Übungen in einem Terminal-Fenster unter dem Benutzerkonto `junioradmin` aus
(geben Sie *alle* verwendeten Befehlszeilen im Protokoll an und _beantworten_ Sie die Fragen!)

#count[Wie lautet der absolute Pfadname des aktuellen Verzeichnisses?]

#count[Wie lautet ihr _Home Directory_ ("Heimatverzeichnis" oder Benutzerverzeichnis)?

    Unter welchem Ordner findet man in der Regel die Benutzerverzeichnisse unter Linux (Zum
    Vergleich: Unter Windows findet man diese unter `\Users`)?]

#count[Wichtige System- und Anwendungsereignisse (z.B. Fehler oder Warnungen) werden unterhalb des Ordners `/var/log` in Dateien
(meist mit der Endung `.log`) abgespeichert.

    Wechseln Sie unter Verwendung absoluter Pfadnamen in das Verzeichnis `/var/log` und lassen Sie den Inhalt so auflisten, dass
    die (Log-)Dateien mit allen wesentlichen Details (→ _long listing_) nach der Zeit der letzten Änderung sortiert sind. Dabei
    sollen die neuesten Dateien _zuletzt_ angezeigt werden _(Tipp: "Wie heißt der bekannte Fernsehsender?")_!

    Welche Datei wurde zuletzt geändert und wie groß ist sie?]

#count[Wechseln Sie in das Verzeichnis `/etc`. Wozu dient die dort vorhandene Datei `hostname` und was bedeutet ihr Inhalt?]

#count[Wechseln Sie in das Stamm- (Wurzel-) Verzeichnis. Geben Sie drei unterschiedliche Varianten an, um vom Wurzelverzeichnis `/` in Ihr _Home Directory_ (Benutzerverzeichnis) zu gelangen.]

#count[Ordner anlegen: Erzeugen Sie folgende Verzeichnisstruktur im Heimatverzeichnis (`~`) von `junioradmin` (Statt  `Vorname` setzen Sie Ihren Vornamen ein):]

```
        UebungsVerzeichnis__YY___Vorname
        |
        +- dir1
        |  |
        |  +- dir11
        |  |
        |  +- dir12
        |
        +- dir2
           |
           +- dir21
           |
           +- dir22
```

#count[Wechseln Sie wieder in ihr _Home Directory_ (Benutzerverzeichnis) und erzeugen Sie nun dort einen weiteren Verzeichnisbaum mit dem Namen `UebungsVerzeichnis__YYYY__`. Dieser soll die selben Unterverzeichnisse wie oben enthalten.
_Wichtig:_ Erzeugen Sie diesen Verzeichnisbaum _unter Verwendung absoluter Pfadnamen_ und _ohne das aktuelle Verzeichnis zu wechseln_.
Nutzen Sie dabei die Möglichkeiten der `bash`! (_Cursortasten, Befehlszeile editieren, …_)]

#count5[ Dateien anlegen:
+ _Erzeugen_ Sie mit der Befehlszeile `echo DateiInhalt1 > Datei1`eine Datei in ihrem Heimatverzeichni (Benutzerverzeichnis). Erzeugen Sie analog weitere Dateien mit den entsprechenden Dateiinhalten und den Dateinamen `Datei11`, `Datei12`, sowie `Datei2`, `Datei21`, `Datei22`.
+ _Kopieren_ Sie nun jeweils jede der erzeugten Dateien in den entsprechenden Unterordner mit der gleichen Nummerierung im Verzeichnisbaum unter  `UebungsVerzeichnis__YY___Vorname` ( z.B.  `Datei21`  →   `dir21`).
+ _Verschieben_ Sie nun zusätzlich jeweils jede der erzeugten Dateien in den entsprechenden Unterordner mit der gleichen Nummerierung im Verzeichnisbaum unter `UebungsVerzeichnis__YYYY__`. // Funktioniert nicht weil 2525 steht
+ Überprüfen Sie die Ergebnisse Ihrer Arbeit regelmäßig durch `ls -lR` …
+ _Wichtig_: Geben Sie dieses (letzte) rekursive Listing (ausgehend von `~`) am Ende in Ihr Protokoll (ähnlich dem `tree`-Listing unter Windows)!]

== E~~~ Grundlegende Befehle für Benutzerinformationen
#v(2mm)

#count5[Lernen Sie mit Hilfe der `man`_-Pages_ bzw. durch Ausprobieren folgende Befehle kennen und schreiben Sie ins Protokoll, „was diese machen“:

+ `whoami`
+ `who`   _(bei Verwendung von WSL: evtl. keine sinnvolle Ausgabe, also online recherchieren!)_
+ `w` 	 _(bei Verwendung von WSL: evtl. keine sinnvolle Ausgabe, also online recherchieren!)_
+ `id`]

== F~~~ Bonus: _(Heavy - nur für Leute, die Lesen können)_
#v(2mm)

#count[Lassen Sie sich das aktuelle Datum und die Systemzeit mit voll ausgeschriebenem Wochentag und Monat anzeigen: zum Beispiel  "`__HEUTIGER_DATUMSSTRING__`"

//<!-- mypp.py macht aus __HEUTIGER_DATUMSSTRING__: "`Heute ist Donnerstag, der 11. Jänner __YYYY__. Es ist 10 Uhr 49 und 03 Sekunden.`". --> 

Tipp: Schauen Sie sich die `man`-Pages des Befehls `date` an!]
//<!-- date +"Heute ist %A, der %d. %B %Y. Es ist %H Uhr %M und %S Sekunden." -->

Viel Spaß!