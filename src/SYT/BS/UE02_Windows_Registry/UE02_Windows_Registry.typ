#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "02_Windows_Registry";



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

Die meisten Anpassungen der Windows Client-Rechner wird man über Benutzerprofile und sogenannte _Gruppenrichtlinien_ machen (siehe spätere Laborübung). Es gibt aber auch Einstellungen, die man über die _Windows Registry_ direkt
durchführen muss. Dafür ist es notwendig, den Aufbau der Windows Registrierungsdatenbank zu kennen. Sie finden eine Kurzerklärung der
_Windows Registry_ in den Zusatzblättern und -folien zu dieser Übung.

*Achtung:*
Es ist stets gefährlich, schreibend in die Registrierung einzugreifen, da bei leichtfertigen Änderungen der Rechner unbrauchbar werden kann! Daher muss man die _Registry_ und die Systemdateien vor den Änderungen sichern (nächster Punkt!).

Ihr heutiges Protokoll -- das Sie während der Übung auf einer virtuellen Maschine mit Windows 11 erstellen -- soll die jeweilige Aufgabenstellung, den Lösungsweg und Antworten auf etwaig gestellte Fragen enthalten. Wichtig sind insbesondere die _vollständigen Pfade_ zu den einzelnen Werten in der Registry _(mit allen Schlüsseln dazwischen)_!

= B~~~ VM
#v(2mm)

Erstellen Sie eine neue virtuelle Maschine:

- Windows 11,

- linked clone,

- Netzwerk: Host only -- damit gibt es weniger Updates

- Snapshot zu Beginn (`init`) nicht vergessen!

= C~~~ Sicherung des Systemzustandes
#v(2mm)

_Hintergrund:_ Unter Windows 11 (sowie in den vorhergehenden Versionen auch) ist eine von
Microsoft empfohlene Methode, die _Registry_-Dateien (und mehr) zu sichern, das Setzen eines _Wiederherstellungspunkts_
_(Restore Point)_, der wichtige Dateien (inkl.
Registrierungsdatenbank) des Systemlaufwerks (typisch C:) in einem reservierten Bereich (Verzeichnis) des Datenträgers in einem _Snapshot_
abspeichert. Ab der Erstellung des Wiederherstellungspunktes führt Windows in diesem geschützten Verzeichnis dann auch ein Änderungsprotokoll _(Change Log)_ mit, das im Falle einer Systemwiederherstellung auf einen früheren Wiederherstellungspunkt ein `Rollback` der vorgenommenen Änderungen erlaubt:

#count[Erstellen Sie einen Wiederherstellungspunkt mit dem Namen `before_registry_changes` (_wie?_) -- aktivieren Sie ggf. vorher die Schutzeinstellung der Systemwiederherstellung für das Laufwerk `C:`!]

#count[Wie groß ist die Platzverbrauch ("derzeitige Belegung") der Wiederherstellungsdateien (nach Erstellen des WHP)? Dokumentieren Sie dies mittels Screenshots im Protokoll!]

Zur Sicherung der Registry kann man alternativ mit dem Programm *regedit* (oder auf der Kommandozeile *reg*) einzelne oder alle Schlüssel in einer `.reg `-Sicherungsdatei abspeichern (und auch wieder einspielen, siehe letzter Punkt dieser Übung).

= D~~~ Windows-Explorer Einstellungen professionalisieren
#v(2mm)

#count[Microsoft verpasst dem Windows-Explorer standardmäßig einige sehr ungünstige Einstellungen. Es empfiehlt sich daher, auf jedem Rechner folgende Einstellungen zu ändern:

- Dateinamenserweiterungen von bekannten Dateien werden nicht angezeigt: Warum ist das aus eigentlich aus Sicherheitsgründen sehr schlecht? 
Lassen Sie daher die _Erweiterungen bekannter Dateien_ anzeigen

- Zeigen Sie den "Vollständigen Pfad in der Titelleiste" an
- Lassen Sie _versteckte Dateien und Ordner_ anzeigen 
- Lassen Sie _geschützte Systemdateien_ anzeigen
- Blenden Sie "leere Laufwerke" nicht aus
- Lassen Sie "Vorherige Ordnerfenster bei der Anmeldung wiederherstellen"
- Lassen Sie im "Navigationsbereich Alle Ordner anzeigen"]

= E~~~ Import von `.reg`-Dateien
#v(2mm)

Manchmal werden Dateien bereitgestellt, die man direkt in die Registry einspielen kann.

#count[Öffnen Sie den Explorer und erstellen Sie auf Ihrem Desktop eine Textdatei mit Ihrem Familiennamen als Dateinamen!
]

#count[Kopieren Sie die Datei `Altes Kontextmenü aktivieren.reg` aus der beigefügten `.zip`-Datei auf Ihrem Desktop!

- Öffnen Sie diese Datei mittels Doppelklick aus dem Explorer!
- Welche Warnungen werden angezeigt?
- Warum ist das Importieren von Registry-Einstellungen über ein `.reg`-File aus dem Internet gefährlich]

#count[Diese Änderung ist nicht sofort wirksam -- Dazu muss man sich entweder nochmals neu anmelden oder den Desktop neu starten. Wir starten den Desktop manuell neu -- dies ist manchmal nützlich, wenn die Anzeige von Windows nicht korrekt funktioniert oder wenn Registry-Einträge nicht sofort wirksam sind:

- Starten Sie den Task-Manager (welche Tastenkombination?)
- Wählen Sie "Mehr Details" aus und danach den "Windows Explorer"
- Klicken Sie auf "Neustart"!]

= F~~~ Manuelle Änderungen in der Windows Registrierung
#v(2mm)

Diese Theorie-Frage kann man auch durch praktische Recherche beantworten:

#count[Welche Berechtigungen können Sie auf Registry-Elemente vergeben und wie? Auf welche Elemente der Registry können _überhaupt_ Berechtigungen vergeben werden (_Tipp:_ Vorbesprechung/bereitgestellte Unterlagen konsultieren oder einfach versuchen, die Berechtigungen von Elementen mit *regedit* zu ändern)?]

_Alle_ folgenden Abfragen und Änderungen sind direkt über Einträge in der _Windows
Registry_ (z.B. mit *regedit* oder mit der _Powershell_) vorzunehmen. Bitte geben
Sie _unbedingt_ stets an, _welche Registry-Pfade_, z.B. `HKLM\Hardware\...` Sie verwenden,
welche Dateneinträge für einen bestimmten _Wert_ Sie vornehmen und wann diese Einstellung
aktiv wird! Zeigen Sie jeweils anhand eines geeigneten Screenshots im Protokoll, was Ihre Änderungen bewirken!

#count[
  Nun stellen Sie ein Hintergrundbild mit eines Feldhamsters#footnote[https://naturschutzbund.at/tier-des-jahres.html] in der Registry ein, indem Sie nachfolgende Schritte anwenden.
	_Hinweis:_ Windows unterstützt für das Hintergrundbild allerdings nicht jedes Dateiformat -- dann ist der Hintergrund schwarz. Daher empfiehlt es sich, einen Screenshot des gewünschten Bildes anzufertigen und diesen abzuspeichern. 

	- Mit welcher Tastenkombination können Sie das Snipping-Tool aufrufen?
	- Wie lautet der absolute Pfad des gespeicherten Screenshots?
	- Öffnen Sie diese Datei in Paint und schreiben Sie mit dem Text-Tool in großen Buchstaben "_Tiername_ von _IhrVorname_ am _heutiges Datum_".
	- Wie aktivieren Sie dieses Hintergrundbild für den aktuellen Benutzer direkt in der Registry und wann wird das aktiv?
	
    __SSPROTOKOLL__
]

#count[
  *Pimp your PC*: Beeindrucken Sie Ihre Freunde mit dem neuesten und tollsten Prozessor (über _Systemsteuerung → System_ herauslesbar)!
    Ändern Sie dazu die Beschreibung Ihres Prozessors in der Registry auf etwas Eindrucksvolles, etwa einen flotten Serverprozessor mit 96-Kernen von Intel
    (`*IhrFamilienname* Intel Xeon 6972P `)...

    __SSPROTOKOLL__
]

#count[Welche Programme werden auf diesem Computer _automatisch gestartet_ und _wann_ passiert das? Nennen Sie zumindest zwei! 

Relevante Registry-Einträge _(vollständiger Pfad -- wie immer -- ins Protokoll!)_? 

*Anmerkung*: es gibt noch viel mehr Stellen, an denen automatisch gestartete Software gespeichert wird. Diese kann man sich mit dem Programm *autoruns* der Sysinternals-Suite ansehen.]

#count[Fügen Sie den Taschenrechner *calc.exe* für den derzeit eingeloggten User zum Autostart über die Registry hinzu und testen Sie die Automatik (_wie?_).

_Tipp:_ Schauen Sie sich z.B. ähnliche systemweite
Einträge unter `HKLM` als Beispiel an und machen Sie den Analogieschluss für `HKCU`!]

#count[
  Über die Registry kann man auch einen Ordner dauerhaft als Laufwerk einbinden: Im Schlüssel

```
	HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices
	HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices
```

    Erstellen Sie eine neue Zeichenfolge namens `x:` und weisen Sie ihr als Wert

```
	\??\c:\users\junioradmin\Desktop
```

    zu. Das `\??\` am Anfang ist kein Tippfehler, sondern muss so sein.
    Nach einem Windows-Neustart zeigt der Explorer das zusätzliche Laufwerk#footnote[Um es wieder zu entfernen, brauchen Sie nur
    die in der Registry erstellte Zeichenfolge wieder zu löschen].

    __SSPROTOKOLL__
]

#count[
  Erweitern Sie das Kontextmenü des Explorers um die Option "Öffnen
     mit Lieblingseditor von _IhrVorname_" (das könnte z.B. _Notepad_ sein)!

     _Tipp:_ Schlüssel
```
     HKEY_CLASSES_ROOT\*\shell\Öffnen mit Lieblingseditor von IhrVorname\command
```
     anlegen und dort den `(Standard)`-Wert (das ist der "namenlose" Wert) auf
     `notepad.exe %1` setzen (_IhrVorname_ steht für Ihren _tatsächlichen_ Vornamen)!
     Funktioniert das bei Ihnen? Rechtsklick im Explorer auf eie Datei -- dann "_Weitere Optionen anzeigen_" 
	 __SSPROTOKOLL__
]

= G~~~ Sichern und Einspielen eines Registry-Schlüssels
#v(2mm)

== G.1~~~ Sichern
#v(2mm)

#count[
  Exportieren Sie den Registry-Schlüssel `HKCU\Control Panel\Desktop` mit *regedit*
]

#count[Welches Format (was für ein Dateityp?) hat die *.reg*-Datei (_Tipp:_ mit Lieblingseditor öffnen)?]

== G.1~~~ _Bonus_: Einspielen
#v(2mm)

_Testen der Backup-Funktion:_

#count[
  Machen Sie nun eine passende
    Registry-Änderung (z.B. den Desktop Hintergrund) und
    verifizieren Sie diese _(→ Protokoll!)_.
]

#count[
  Jetzt importieren Sie wieder den Schlüssel --
    wurde Ihre Änderung aus der *.reg*-Datei erfolgreich zurückgesetzt?
]

_Testen der Änderungsfunktion:_

#count[ Ändern Sie den Registry-Eintrag (z.B. den Desktop Hintergrund) in der *.reg*-Datei und
    importieren
    Sie die Datei wieder (_Tipp für angehende Gurus:_ Das geht auch mit

    ```
    reg import dateiname.reg
    ```

    auf der Kommandozeile).

    Wozu kann man diese *.reg*-Dateien noch gut gebrauchen?
]

_Viel Spaß!_
