#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2; 
#show: template 

#let filename = "01_Windows_MMC";


#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ Admin-Toolbox
#v(2mm)
Als Systemadmin möchte man alle wichtigen Werkzeuge zur Systemverwaltung gerne an einer Stelle haben. Man
kann unter Windows mit der _Microsoft Management Console_, ähnlich einem Baukastensystem, sein eigenes Kon-
figurationstool bauen (die MMC-Technologie wird nämlich von zahlreichen Microsoft-Verwaltungswerkzeugen
verwendet).

In dieser Übung stellen Sie sich Ihre eigene “Admin-Toolbox” für Windows 11 (das funktioniert seit vielen
Windows Versionen, dh. auch unter Windows 10), erkunden eine Reihe nützlicher Werkzeuge und lernen, wie
man wichtige Meldungen des Systems in der Ereignisanzeige (Systemprotokoll – _Event Log_) nachlesen kann.
Bitte beantworten Sie alle Fragen und schreiben Sie alle relevanten Schritte in Ihr Protokoll und fügen Sie ggf.
Screenshotsein!

_Tipp_: Mit dem Windows-_Snipping-Tool_ können Sie sehr einfach einen Bildschirm-Ausschnitt “abfotografieren”.
Dieser _Screenshot_ wird automatisch in der Zwischenablage gespeichert und steht sofort auch außerhalb der
virtuellen Maschine auf Ihrem Linux-Host zur Verfügung.

== B~~~ Inbetriebnahme der VM und Kennenlernen des Windows 11 _User Interfaces_
#v(2mm)
Erstellen Sie wenn notwendig eine neue virtuelle Windows 11-Maschine (ein virtueller PC als _Linked Clone_,
siehe Anleitung) und melden Sie sich mit Admin-Rechten (User/Passwort: `junioradmin`) an!

#count[
Ändern Sie den Namen des Computers auf UE01-_IhrFamilienname-IhrVorname (Tipp: Systemsteuerung →
Kleine Symbole → System → Erweiterte Systemeinstellungen_ oder schneller: Tastenkombination `Windows+ Pause)`! Wie lautete der Standardname? Was ist notwendig, damit die Änderung des Computernamens tatsächlich durchgeführt wird? Dokumentieren Sie hier anhand eines Screenshots#footnote[Im Linux Desktop können Sie mit der Tastenkombination `STRG + Shift + Druck` einen rechteckigen Bildschirmbereich in die Zwischenablage kopieren!], dass Ihr Rechner erfolgreich umbenannt wurde!
]
#count[Jetzt ist ein guter Zeitpunkt um einen _Snapshot_ zu erstellen. VMware speichert den Zustand der virtuellen Maschine (Festplatte und Einstellungen), man kann jederzeit zu diesem Zustand _zurückkehren_. Machen Sie den Snapshot mit dem Namen “init” am besten bei heruntergefahrener VM!

Dokumentieren Sie die Schritte, um einen Snapshot zu erstellen!]

#count[
  Machen Sie sich mit dem Windows 11 _User Interface_ vertraut. Dokumentieren und merken Sie sich, wie man folgende Werkzeuge möglichst _schnell_ aufrufen kann! (_Tipp_: Nutzen Sie das Handout über Windows-Tastenkombinationen!)

  + Erweitertes Kontextmenü (_Quicklink_ zu den wichtigsten Verwaltungswerkzeugen im _Desktop_)
  + Explorer -Fenster öffnen Hauptfenster
  + Einstellungen (Modern UI Style)
  + Systemsteuerung (klassisch)
  + Task-Manager
  + Systemeigenschaften (_Info-Feld “System”_)
  + Geräte-Manager
  + Terminal = Kommandozeile: ist seit Windows 10 1703 (Creators + Update) nicht mehr CMD sondern die _Powershell_
  + Snipping-Tool, um einen Screenshot in die Zwischenablage zu kopieren
  + Bonus: Fügen Sie 2 virtuelle Desktops hinzu, starten Sie im ersten der neuen virtuellen Desktops den Taschenrechner `calc.exe` und im anderen den Task-Manager. Wozu sind virtuelle Desktops nützlich?
]
#count[
  Welche Windows-Version (mit genauer _Build-Nummer_) haben Sie installiert? Mit welchem Programm (das Sie mit Windows-R starten können) haben Sie das ermittelt?
]

= C~~~ Microsoft Management Console 

== C.1~~~ Allgemeines zu MMC
#v(2mm)
#count1[
  Beantworten Sie z.B. durch Internet-Recherche die folgenden Fragen zur MMC:

  + Wozu dient die MMC? 
  + Was ist ein _Snap-in_?
  + Nennen Sie zwei Beispiele vorgefertigter System-Tools, welche die MMC nutzen!

]
 
== C.2~~~ Anlegen einer eigenen MMC
#v(2mm)
#count[
 
Rufen Sie eine leere MMC-Konsole auf und fügen Sie die folgenden
    Snap-Ins (bzw. "Ordner") hinzu (alle für den lokalen Computer), 
    damit folgende Baumstruktur entsteht (lesen ):
]


  *Achtung*: Die Untergruppen von "Ereignisanzeige" sind als Teil des Snap-Ins bereits vordefiniert, also vorhanden! Die "Ordner" ``` Hardware hrFamilienname_System ``` und `NetzwerkYY` müssen Sie aber selbst anlegen!

  *Tipp*: Wo notwendig, erst den Ordner mit dem vorläufigen Namen `Ordner` hinzufügen, dann  den Ordner entsprechend umbenennen, etwa `Hardware`, `IhrFamilienname_System` ... Sodann fügen Sie das gewünschte Snap-In dem Ordner hinzu, indem Sie als `Übergeordnetes Snap-In` den Ordnernamen (_nicht_ `Konsolenstamm`) angeben!

  ```

     - Konsolenstamm 
       - Ereignisanzeige 
          |- Benutzerdefinierte Ansichten
          |- Windows-Protokolle
          |- Anwendungs- und Dienstprotokolle
          |- Abonnements
       - Hardware
          |- Geräte-Manager
          |- Datenträgerverwaltung 
       - IhrFamilienname_System
          |- Lokale Benutzer und Gruppen
          |- Freigegebene Ordner
          |- Dienste
          |- Leistung(-süberwachung)
       - Netzwerk__YY__
          |- Windows Defender Firewall mit erweiterter Sicherheit


```

Fügen Sie ein Screenshot in Ihr Protokoll!

#count1[
  Speichern der Konsole: Geben Sie Ihrer Konsole den 
     Namen `Die traumhafte Konsole von IhrVorname IhrFamilienname anno |YYYY|` und speichern Sie Ihre Konsole mit dem 
     Dateinamen `dtk.msc` (unter dem vorgeschlagenen Standardpfad) ab!

     + _Wo_ ist die Datei `dtk.msc` im Dateisystem abgelegt? _(Absoluter Pfad gesucht, also_ `C:\Users\...\dtk.msc`_- Tipp : Speichern unter → Eigenschaften → Ort)_

     + Wie können Sie diese angepasste Konsole also wieder aufrufen _(zum Testen vorher alle Fenster schließen)_?]


== C.3~~~ MMC Snap-Ins
#v(2mm)
#count1[
Erkunden Sie die einzelnen Snap-Ins:
     
         + _Geräte-Manager:_

          + Wie kann man den Netzwerkzugriff über einen bestimmten
            Netzwerkadapter gänzlich unterbinden (ohne ihn ganz zu
            entfernen/deinstallieren)? 

          + Probieren Sie das aus -- wie testen Sie das?

     +  _Freigaben:_

        Man kann einzelne Ordner anderen Computern im Netzwerk über
        sogenannte _Freigaben_ verfügbar machen -- Benutzer von anderen
        Computern können dann auf diese Ordner über ein sogenanntes
        _Netzwerklaufwerk_ zugreifen, sofern sie die nötigen Freigabe
        und Dateisystem-(NTFS)-Rechte haben.
        + Was kann man mit Hilfe des Snap-ins "Freigegebene Ordner” so
            alles machen (zum Beispiel ansehen)?

        +  _(Daraus:)_ Welche Ordner werden automatisch (aber nur für
            Administratoren) im Netzwerk freigegeben? 
            _Zum Nachdenken:_ Ist das ein Sicherheitsproblem?

    +  _Dienste:_

      Dienste (_Services_) sind Programme, die vom Betriebssystem meist automatisch gestartet werden und "im Hintergrund werken", d.h. normalerweise nicht mit dem Benutzer interagieren:
      + Welche vier Einstellungen zum Starttyp kann man zu den einzelnen Diensten(_Service_) im Snap-in _Dienste_ vornehmen?

      + Starten Sie den Drucker-Spooler (`Druckwarteschlange`) neu! 
            + Wie haben Sie das gemacht?
            + Wann/Warum wird man das in der Praxis evtl. machen?
      +   Verhindern Sie, dass Windows-Media-Player in der Lage ist,
            über das Netzwerk Audio/Video-Dateien an _Universal-Plug-and-Play-(UPnP)_-Media-Streaming-Geräte (wie z.B. die Xbox) weiterzugeben!
      +   _Bonusaufgabe für Sicherheitsbewusste_: Schalten Sie die           Windows-Telemetrie-Dienst (Benutzererfahrungen und Telemetrie im verbundenen Modus) dauerhaft ab!
    +  _Leistung:_
    
        Starten Sie den _Ressourcen-Monitor_ aus dem
        Leistungs-Snap-In! Wie vergleicht sich der Informationsgehalt
        mit dem (Ihnen vermutlich bekannten) _Task Manager_?
]
#count[

   Schnellzugriff auf Snap-Ins: 

    Mit welchem tatsächlichen Namen kann man die
    folgenden Snap-Ins (mitsamt einer MMC-Instanz) *direkt* ausführen 
	  (mit der Tastenkombination `Windows + R` )?

    _Tipp_: Suchen Sie Dateien namens `*.msc` unter
    `C:\Windows\System32` mit der Explorer-Suchfunktion!

    
    Beispiel: Ereignisanzeige → `eventvwr.msc` _(Testen!)_

      Geräte-Manager → ...
    
      Datenträgerverwaltung → ...
    
      Lokale Benutzer und Gruppen → ...
    
      Lokale Sicherheitsrichtlinie → ...
]


== D~~~ Systemüberwachung und Protokolle
#v(2mm)

In diesem Teil der Übung werden Sie sich mit der Verwendung des
MMC-_Snap-In Ereignisanzeige (Event Log)_ zur Fehlererkennung und
Systemüberwachung auseinandersetzen -- ein mächtiges Werkzeug, um
Fehlfunktionen und Störungen des Windows-Computers auf die Schliche zu
kommen!

In der Ereignisanzeige protokolliert Windows alles, was es für erwähnenswert hält.
Dazu gehören nicht nur schwere Systemfehler, Probleme bei fehlerhaft konfigurierter Hardware,
Ereignisse wie z.B. Updates oder jeden Start von Windows.
Selbst wenn Windows völlig einwandfrei konfiguriert wurde, werden in der Ereignisanzeige
zahlreiche Einträge über Warnungen und Fehler protokolliert.
Windows stuft nämlich viele harmlose Ereignisse als Fehler oder Warnung ein.
Um nicht die "Nadel im Heuhaufen" suchen zu müssen, sollten Sie daher die Log-Einträge gezielt durchforsten.

== D.1~~~ Benutzerdefinierte Ansicht der Ereignisanzeige

#count[

 Es gibt zahlreiche Ereignisprotokolle -- mit einer
    _Benutzerdefinierten Ansicht_ können Sie Log-Einträge aus den
    verschiedenen Quellen kombinieren, nur bestimmte Ereignisse
    betrachten und filtern:

    Legen Sie eine benutzerdefinierte Ansicht "Wichtige Sachen von IhrName |YYYY|" an, die kritische/wichtige
    Fehler sowie Warnungen aus den Logs (Windows-Protokollen) für "Anwendungen", "System",
    "Sicherheit" sowie "Hardware-Ereignisse" zusammenfasst.
]
#count[
 Wählen Sie eines der nun angezeigten Ereignisse aus und
    dokumentieren Sie exemplarisch den Fehler/die Warnung. Verwenden Sie
    zur besseren Klärung des Ereignisses evtl. auch die Informationsseite
    #link("http://www.eventid.net/")[www.eventid.net].
	Kopieren Sie einen Screenshot des Ereignisses in Ihr Protokoll.
]
#count[
Leeren (= Löschen der Einträge) Sie die Protokolle _(Logs)_ "Anwendung",
    "Sicherheit" und "System" als Vorbereitung für unseren
    Bonus-Übungspunkt.
]
#count[
 Welche Auswahl haben Sie, wenn Sie die Ereignisse löschen?
]

== D.2~~~ Bonus: Lokale Sicherheitsrichtlinie und Sicherheitsprotokollierung

#count1[
Öffnen Sie aus der Systemsteuerung unter "Verwaltung” das _Snap-In_
    "Lokale Sicherheitsrichtlinie".

    + Wie heißt eigentlich die `.msc`-Datei?                     
      _Tipp:_ Das haben Sie vorhin bereits ermittelt! ;-)

    +  Aktivieren Sie die Überwachungsrichtlinie für

      +  Anmeldeereignisse (erfolgreich und fehlgeschlagen),
      +  Anmeldeversuche (fehlgeschlagen) und
      +  Kontenverwaltung (erfolgreich).

    c.  Schließen Sie diese Konsole und wechseln Sie zu Ihrer MMC.
]
#count1[
Anlegen von Benutzerkonten:

    + Erzeugen Sie ein neues Benutzerkonto für sich. Verwenden Sie als Kontonamen Ihren Vornamen
        (klein geschrieben). Das Kennwort soll zunächst gleichlautend
        mit dem Kontonamen sein. Aktivieren Sie aber die Option
        "Benutzer muss Kennwort bei der nächsten Anmeldung ändern".

    + Schließen Sie alle Fenster, melden Sie sich ab, dann mit Ihrem
        neu erstellten Benutzer an _(Sie sollten Ihr Passwort ändern müssen)_.

    + Melden Sie sich anschließend wieder als `junioradmin` an.
        Öffnen Sie Ihre MMC und kontrollieren Sie die Protokollierungen, indem Sie 
        Einträge finden für ...

        +  die Erstellung des neuen Kontos,
        +  die Passwortänderung,
        +  den Login durch den neuen Benutzer!
]
_(Tipp: Suchen Sie im Sicherheitsprotokoll z.B. nach `ändern`, `erstellt` usw.)_. 
          
→ Kopieren Sie die wesentlichen Infos (nach Ihrer Einschätzung) aus den Ereignisprotokolleinträgen in Ihr Laborprotokoll! 

_Viel Spaß!_