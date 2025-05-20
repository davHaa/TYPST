#import "../resources/BS_Template.typ": create_page_template
#import "@preview/numbly:0.1.0": numbly

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
kann unter Windows mit der #emph[Microsoft Management Console], ähnlich einem Baukastensystem, sein eigenes Kon-
figurationstool bauen (die MMC-Technologie wird nämlich von zahlreichen Microsoft-Verwaltungswerkzeugen
verwendet).

In dieser Übung stellen Sie sich Ihre eigene “Admin-Toolbox” für Windows 11 (das funktioniert seit vielen
Windows Versionen, dh. auch unter Windows 10), erkunden eine Reihe nützlicher Werkzeuge und lernen, wie
man wichtige Meldungen des Systems in der Ereignisanzeige (Systemprotokoll – #emph[Event Log]) nachlesen kann.
Bitte beantworten Sie alle Fragen und schreiben Sie alle relevanten Schritte in Ihr Protokoll und fügen Sie ggf.
Screenshotsein!

#emph[Tipp]: Mit dem Windows-#emph[Snipping-Tool] können Sie sehr einfach einen Bildschirm-Ausschnitt “abfotografieren”.
Dieser #emph[Screenshot] wird automatisch in der Zwischenablage gespeichert und steht sofort auch außerhalb der
virtuellen Maschine auf Ihrem Linux-Host zur Verfügung.

== B~~~ Inbetriebnahme der VM und Kennenlernen des Windows 11 #emph[User Interfaces]
#v(2mm)
Erstellen Sie wenn notwendig eine neue virtuelle Windows 11-Maschine (ein virtueller PC als #emph[Linked Clone],
siehe Anleitung) und melden Sie sich mit Admin-Rechten (User/Passwort: #strong[junioradmin]) an!

#set enum( //Nummerierung 
  full:true, 
  numbering: numbly("{1:(1)}", "{2:a})","{1:(5)}" )
)
+ Ändern Sie den Namen des Computers auf UE01-#emph[IhrFamilienname-IhrVorname (Tipp: Systemsteuerung →
Kleine Symbole → System → Erweiterte Systemeinstellungen] oder schneller: Tastenkombination #strong[Windows+ Pause])! Wie lautete der Standardname? Was ist notwendig, damit die Änderung des Computernamens tatsächlich durchgeführt wird? Dokumentieren Sie hier anhand eines Screenshots, dass Ihr Rechner erfolgreich umbenannt wurde!

+ Jetzt ist ein guter Zeitpunkt um einen #emph[Snapshot] zu erstellen. VMware speichert den Zustand der virtuellen Maschine (Festplatte und Einstellungen), man kann jederzeit zu diesem Zustand #emph[zurückkehren]. Machen Sie den Snapshot mit dem Namen “init” am besten bei heruntergefahrener VM! Dokumentieren Sie die Schritte, um einen Snapshot zu erstellen!

+ Machen Sie sich mit dem Windows 11 #emph[User Interface] vertraut. Dokumentieren und merken Sie sich, wie man folgende Werkzeuge möglichst #emph[schnell] aufrufen kann! (#emph[Tipp]: Nutzen Sie das Handout über Windows-Tastenkombinationen!)

  + Erweitertes Kontextmenü (Quicklink zu den wichtigsten
  + Verwaltungswerkzeugen im Desktop)
  + Explorer -Fenster öffnen Hauptfenster
  + Einstellungen (Modern UI Style)
  + Systemsteuerung (klassisch)
  + Task-Manager
  + Systemeigenschaften (Info-Feld “System”)
  + Geräte-Manager
  + Terminal = Kommandozeile: ist seit Windows 10 1703 (Creators + Update) nicht mehr CMD sondern die Powershell
  + Snipping-Tool, um einen Screenshot in die Zwischenablage zu kopieren
  + Bonus: Fügen Sie 2 virtuelle Desktops hinzu, starten Sie im ersten der neuen virtuellen Desktops den Taschenrechner calc.exe und im anderen den Task-Manager. Wozu sind virtuelle Desktops nützlich?



+ Welche Windows-Version (mit genauer Build-Nummer) haben Sie installiert? Mit welchem Programm (das
Sie mit Windows-R starten können) haben Sie das ermittelt?
 

