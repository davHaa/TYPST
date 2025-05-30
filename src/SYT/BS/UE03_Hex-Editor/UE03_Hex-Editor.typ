#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "03_Hex-Editor";



#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

= A~~~ Szenario -- Auftragsbeschreibung
#v(2mm)

Ein wichtiges Werkzeug zur Analyse und Manipulation von Binärdateien ist der _Hex-Editor_. 
Das ist ein Computerprogramm, mit dem sich die Bytes beliebiger Dateien als Folge von Hexadezimalzahlen darstellen und bearbeiten lassen. 

In dieser Übung werden Sie in einer virtuellen Maschine mit Windows 11 einen einfachen, 
aber effizienten Hex-Editor installieren und mit diesem den Umgang mit Binärdateien erlernen.

Dabei werden Sie ein einfaches Programm hacken und beobachten, welche Informationen das Programm im Arbeitsspeicher ablegt.

= B~~~ VM
#v(2mm)

#count[Benutzen Sie wieder Ihre virtuelle Maschine mit Windwos 11 und gehen Sie zum Snapshoi "init" zurück. Falls Sie keinen Snapshot gemacht haben, gehen Sie folgendermaßen vor:

- Löschen Sie ihre alte Windows 11 VM (_Rechtsklick = RK auf VM_ / _Manage_ / _Delete From Disk_)!

- Linked Clone erstellen

- Snapshot mit dem Namen _init_ erstellen (_RK_ / _Snapshot_ / _Take Snapshot_)
]

#count[Ausgehende Netzwerkverbindungen erlauben
- Netzwerk zunächst auf NAT setzen: (RK auf VM / _Settings_ / _Network Adapter_ / _Network connection_ = NAT]

#count[Windows Updates aussetzen: Melden Sie sich als `junioradmin` an und setzen Sie die Windows-Updates so lange wie möglich aus! Tipp: Windows-Updates Warum sollte man in einer Produktivumgebung (und auch in Laborumgebungen, die mit dem Internet verbunden sind) _immer_ aktuelle Updates einspielen? 

SSPROTOKOLL
]

= C~~~ Installation des Hex-Editors
#v(2mm)

Leider bringt Windows keinen komfortablen Hex-Editor mit. Es gibt aber zahlreiche frei verfügbare Tools für diesen Zweck. Wir werden in dieser Laborübung *HxD* verwenden.

#count[Öffnen Sie den Web-Broswer auf Ihrem Host und gehen Sie auf: #link("https://mh-nexus.de/de/hxd/") 

- Welche ist die derzeit aktuelle Version des Hex-Editors für Windows? 

- Öffnen Sie in der Windows 11 VM ein Powershell-Terminal mit Administratorrechten (Wie? z.B. Tastenkombination dokumentieren!). Aktualisieren Sie die Liste der unterstützten Pakete und installieren Sie im Terminal HxD mit dem Windows-Paketverwaltung `winget`! Hinweis: Falls `winget` auf Ihrem System noch nicht vorhanden ist oder nicht funktioniert, dann laden Sie die zu installierenden Programme von deren Homepage herunter.

	```powershell
		winget source update
		winget install hxd
	```
]

#count[Installieren Sie in gleicher Weise den Editor _notepad++_ in der aktuellen deutschsprachigen Version herunter und installieren Sie diesen in der Windows VM. Mit welchem Kommando haben Sie die Installation durchgeführt?#footnote[Das Paket heißt `notepad++.notepad++`]]

#count[Deaktivieren Sie die Verbindung ins Internet, indem Sie wieder das Netzwerk in den VM-Settings auf Host-only setzen]

= D~~~ Erste Schritte mit dem Hex-Editor
#v(2mm)

#count[In notepad++: Erstellen Sie eine Datei namens `####_windows.txt` (`####` ist Ihre vierstellige Nummer) mit mehreren Textzeilen (und beliebigem Inhalt). Bei _Bearbeiten_ / _Format Zeilenende_#footnote[in englischen Versionen von notepad++ heißt dieser Menüpunkt _Edit / EOL convention_]  wählen Sie _Windows_ (falls dieses ausgegraut ist, wurde dieser Wert bereits eingestellt)! Öffnen Sie Ihre Textdatei mit HxD! 

- Wozu dient die blau dargestellte oberste Zeile sowie die linke Spalte?
- Was bedeutet _Offset?_
- Erklären Sie, was in der Mitte der Ausgabe des Hex-Editors angezeigt wird!
- Was wird unter _Dekodierter Text_ ausgegeben?
]

#count[Suchen Sie den Zeilenumbruch! Wie lautet der Hexadezimalwert des Zeichens / der Zeichen für den Zeilenumbruch?]

#count[Wählen Sie nun in  _notepad++_ als _Format Zeilenende_ _UNIX_ und speichern Sie die Datei unter dem Namen `####_unix.txt`! 
- Wie wird der Zeilenumbruch jetzt im Hex-Editor dargestellt?	
- Wie speichert der Macintosh den Zeilenumbruch?
]

#count[Kopieren Sie die Datei `hexedittest1.exe` in Ihre Windows-VM!

Recherchieren Sie, was eine `exe`-Datei ist (kann auch zu Hause gemacht werden)?]

#count[Öffnen Sie `hexedittest1.exe` mit dem Hex-Editor!
- Mit welchen beiden Zeichen (magic-number) beginnt die Datei und warum? Tipp: #link("https://de.wikipedia.org/wiki/MZ-Datei")	
- Welchen Wert hat das Zeichen an der Stelle `0x945A` (hexadezimal)?]

= E~~~ Unser erstes gehacktes Programm
#v(2mm)

#count[Öffnen Sie eine Windows-Kommandozeile (`powershell` oder `cmd`)! Führen Sie anschließend das Programm `hexedittest1.exe` fertig aus! 
- Was macht das Programm schlecht und ist daher aus Security-Sicht höchst problematisch?
- Was könnte ein böswilligerer Zuseher so alles mit Ihrem Passwort anstellen?]

#count[Wir wollen nun das Programm "hacken", das heißt ohne Änderung des Quelltextes manipulieren!

- Machen Sie eine Sicherheitskopie von `hexedittest1.exe` (z.B. `hexedittest1copy.exe`)!
- Ändern Sie nun `hexedittest1.exe`, sodass die Ausgabe des Programmes lautet: _ITSI Demoprogramm -- gehackt von IhrVorname IhrNachname_. Tipp: Hex-Editor! Achtung! *Die Dateigröße darf sich dabei nicht ändern* -- Sie müssen daher den Text überschreiben (und nicht einfügen)!#footnote[Den Grund dafür lernen Sie in Systemtechnik / Grundlagen der Informatik] 
- Starten Sie das manipulierte Programm und dokumentieren Sie Ihren Hack mit einem Screenshot im Protokoll!
]

= F~~~ Manipulation am laufenden Programm
#v(2mm)

Abschließend wollen wir untersuchen, welche Informationen das ausgeführte Programm im Arbeitsspeicher ablegt.
Wie Sie (hoffentlich) aus dem Systemtechnik-Unterricht bereits wissen, werden die Daten eines ablaufenden Programmes (z.B. Werte von Variablen) im Arbeitsspeicher 
abgelegt#footnote[Ausnahmen dafür sind jene Variablen, die von einem optimierenden Compiler ausschließlich in ein Register gepfercht wurden]. 
Sie haben (als angehender Security-Experte wahrscheinlich mit Entsetzen) festgestellt, dass unser Testprogramm die eingegebenen Passwörter wenig vertraulich behandelt. 

#count[
  Wir werden nun mit dem Hex-Editor einen Speicher-Dump#footnote[das ist eine Kopie oder ein Auszug eines Speicherinhaltes] anfertigen und auf diese Weise das eingegebene Passwort ermitteln!  

- Starten Sie `hexedittest1.exe` mittels Doppelklick im Explorer und geben Sie als Passwort Ihren Familiennamen ein, sodass das Programm _"Bitte Taste druecken, um das Programm zu beenden!_" anzeigt! Beenden Sie das Programm jetzt _noch nicht_!

- Öffnen Sie den Hex-Editor, drücken Sie auf das Icon für _Arbeitsspeicher öffnen_ und wählen Sie `hexedittest1.exe` aus!

- Suchen Sie nach dem eingegebenen Passwort im Hex-Editor (_Strg-F_). __SSPROTOKOLL__

- Ändern Sie nun das Passwort im Hex-Editor und schreiben Sie die Änderung in den Arbeitsspeicher zurück (Tipp: _Strg-S_)

- Bonus: Wie viele Zeichen sollten Sie maximal im Hex-Editor für das geänderte Passwort eingeben? Warum? Tipp: sehen Sie sich den Sourcecode(`hexedittest1.cpp`) an!

- Beenden Sie nun das Testprogramm durch einen Tastendruck und beschreiben Sie, was passiert ist!
]

#count[Sie können auch mit Windows-Bordmitteln (als Administrator) in den Speicher anderer Programme blicken:

- Starten Sie `hexedittest1.exe`, geben Sie als Passwort Ihren Familiennamen ein und beenden Sie das Programm _noch nicht_!
- Starten Sie den _Taskmanager_#footnote[Vollprofis verwenden stattdessen den weitaus mächtigeren _Process Explorer_ von Sysinternals] (Welchen Shortcut verwenden Sie dafür?)
- Erstellen Sie einen Memory-Dump = _Speicherabbilddatei_! (Tipp: Rechtsklick auf Prozess)
- Wo (absoluter Pfad) wird der Speicherauszug abgelegt?
- Suchen Sie in der erzeugten Dump-Datei mittels Hex-Editor das eingegebene Passwort! __SSPROTOKOLL__
]

#count[*Achtung:* Memory-Dumps werden häufig automatisch nach einem Programmabsturz generiert, um EntwicklerInnen einen Anhaltspunkt zur Analyse des Problems zu geben. 
Leider bieten solche _Crash-Dumps_ oft auch eine gute Gelegenheit für Hacker. Einem derartigen Angriff mit besonders schwerwiegender Auswirkung ist sogar die Firma Microsoft zum Opfer gefallen: 
siehe Datei im Anhang oder #link("https://www.heise.de/select/ct/2023/22/2325014433560180576").

*Bonus*: Erklären Sie mit eigenen Worten, was bei diesem geschilderten Angriff vorgefallen ist.
]

= G~~~ Analyse des Source-Codes
#v(2mm)

#count[Nachdem wir unser erstes Programm gehackt haben, analysieren wir nun den Quellcode von `hexedittest1.exe`.Dieses kleine Programm wurde in _C_ geschrieben. Im SEW-Unterricht haben Sie zwar die Programmiersprache _Java_ gelernt -- da diese sehr stark von C beeinflusst wurde, wird Ihnen die Analyse des Source-Codes nicht schwerfallen.
]

#count[Recherchieren Sie (können Sie auch in Ruhe zu Hause erledigen):

- Was ist ein Preprocessor?

- Was bewirkt die Preprocessor-Anweisung `#include`?

- Was bewirkt die Preprocessor-Anweisung `#define`?
]

#count[Fügen Sie die Quelldatei `hexedittest1.c` hier im Protokoll ein (eine `nichtproportionale = monospace- "Schreibmaschinenschrift"` verwenden!) und kommentieren Sie die wesentlichen Programmzeilen. Auch diese Aufgabe können Sie zu Hause machen.]

_Viel Spaß!_