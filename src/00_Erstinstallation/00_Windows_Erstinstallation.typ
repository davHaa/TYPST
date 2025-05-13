#import "../template.typ": create_page_template

#let filename = "00_Windows_Erstinstallation"

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)


== A~~~ Zielsetzung
#v(2mm)
Vorbereitend für die folgenden Laborübungen wollen wir:

- uns mit der Umgebung zur Rechnervirtualisierung im Labor vertraut machen,
- einen ersten virtuellen Computer ("Virtuelle Maschine", VM) selbst "bauen" und
- darauf ein aktuelles Windows (von einer virtuellen Installations-DVD) installieren.

~~~#emph[Bemerkung:] In den folgenden Laborübungen werden wir von vorbereiteten virtuellen Maschinen einfach eine
~~~Kopie für den Eigengebrauch machen (sog. #emph[Cloning]), damit wir nicht immer selbst installieren müssen.

Im Anschluss werden wir einige Kenndaten auf unserem virtuellen PC ermitteln und in einem ersten Labor-
Protokoll dokumentieren.

== B~~~ Durchführung
#v(2mm)
Ihr Übungsprotokoll soll, sofern nicht anders angegeben, in kurzen Stichworten alle notwendigen Schritte zur
Durchführung der Übung dokumentieren, so dass eine andere Person anhand des Protokolls die gesamte Übung
problemlos später nachvollziehen kann (die Bewertung erfolgt aufgrund von Korrektheit, Vollständigkeit und
Form). Ferner sollte das Protokoll Ihre Antworten auf alle gestellten Fragen enthalten.

#strong[Wichtig:] Sie dürfen sich bei einem allfälligen Interview auf Ihr Protokoll beziehen (#emph[Sie können also während des Betreuergesprächs auch etwas kurz in Ihrem Protokoll nachlesen)].

== C~~~ Inbetriebnahme der VM
#v(2mm)
Ihr freundlicher Labor-Lehrer wird Ihnen die wichtigsten Schritte auf einem Testsystem vorführen – im wesent-
lichen ist der Ablauf folgendermaßen:

(1) Virtualisierungs-Software (ein sog. Typ II-Hypervisor) auf dem Host-System “finden” und starten – im Folgenden, falls unter (2) nicht anders angegeben, die Standardvorgaben ausgewählt lassen. 

(2) Mit der Virtualisierungs-Software (bei uns derzeit VMware Workstation) einen passenden virtuellen Computer (VM) bauen, also:

a) Eine neue VM (New Virtual Machine → Custom (Advanced)) anlegen (das Betriebssystem installierennwir später - I will install operating system later)

a) Als Betriebssystem wählen Sie Microsoft Windows → Windows 11 x64

c) Benennen Sie die VM gleich nach unserem Laborstandard, also etwa
Windows11_Pro_Edu_Nachname_Vorname_UE01

d) Firmware Type UEFI

e) Die Anzahl der CPUs/Prozessorkerne, Größe des RAMs (Arbeitsspeicher) usw. auswählen., u.a.

~~~~ i. 1 Prozessor/2 Cores

~~~~ ii. RAM = 4 GiB

f) Host-Only Netzwerkverbindung – damit ist die VM über ein privates Netz mit unserem (richtigen) Host-Computer verbunden, kann aber nicht das Internet erreichen – damit werden keine Updates gesucht und die Installation ist wesentlich schneller beendet.

g) Eine neue – leere – virtuelle Festplatte (die im Host-System einfach eine Datei ist) “bauen” und an
den PC anschließen (wir werden das Betriebssystem erst später – siehe weiter unten – installieren):

~~~~i. Größe: 40 GiB

~~~~ii. Nicht vor-alloziert, sondern dynamisch wachsend (Allocate all disk space now nicht anwählen!)

(3) Eine Windows-Installations-DVD (als “ISO-Image” – das ist eine 1:1-Kopie einer echten DVD, deren Bits
und Bytes sequentiell – also nacheinander – 1:1 in einer Datei abgespeichert wurden) in das virtuelle
CD/DVD-Laufwerk der VM “einlegen” – geben Sie in den Einstellungen der VM den absoluten Pfad zum
ISO-Image im virtuellen DVD-Laufwerk an:
Pfad-zu-den-Windows-11-ISO-Dateien/de-de_windows_11...x64_dvd.iso

→ Dokumentieren Sie ggf. alle von den Standardvorgaben abweichenden Eingaben und Auswahlen im Protokoll
(damit Sie bei der nächsten VM schnell loslegen können)!


== D~~~ Registry-Hack zur Installation in VMware
#v(2mm)
Microsoft setzt für den Betrieb von Windows 11 verhältnismäßig hohe Anforderungen an die Hardware (z.B.
CPU) voraus, obwohl die Ressourcen für wenig leistungshungrige Programme auch bei älterer Hardware völlig
ausreichen würden. Zusätzlich benötigt Windows 11 ein aktuelles “Trusted Plattform Module (TPM)”1, welches
VMware nur mit viel Aufwand bereitstellt. Aus diesem Grund scheitert die Installation von Windows 11 in der
virtuellen Maschine unseres Labors.

(4) Wir werden gemeinsam mit der Lehrkraft einen Registry-Hack anwenden, mit dem die Installation von
Windows 11 trotzdem funktioniert.

a) Starten Sie die VM, umd booten Sie von der DVD. Falls Sie in der VM “eingesperrt” sind (Maus
funktioniert nicht), kommen Sie wieder mit der Tastenkombination Ctrl + Alt heraus.

c) Sobald das Fenster zur Eingabe der Sprachen erscheint, starten Sie mit folgendem Vollprofi-
Geheimtrick die Kommandozeile: Tastenkombination Shift + F10.

c) Öffnen Sie den Registrierungseditor2, indem Sie regedit eingeben.

d) Navigieren Sie nach HKEY_LOCAL_MACHINE\SYSTEM\Setup.

e) Erstellen Sie einen neuen Registry-Key, mit der rechten Maustaste (“RK”) auf Setup klicken und im
Popup-Fenster auf Neu → Schlüssel und geben als Namen LabConfig ein.

f) In LabConfig erstellen Sie einen DWORD-Wert (32-Bit) mit dem Namen BypassTPMCheck und setzen
den Wert auf 1.

g) Erstellen Sie einen weiteren DWORD-Wert (32-Bit) in LabConfig und geben diesen den Namen
BypassSecureBoot und setzen den Wert auf 1.

h) Optional können Sie mit dem DWORD-Value namens BypassRAMCheck einstellen, dass Windows auch
mit weniger als 4GiB Arbeitsspeicher startet.


== E~~~ Windows-Installation

 (5) ~~~Optional– nur für Interessierte: Überprüfen Sie die Boot-Reihenfolge der VM in der Firmware
 (BIOS/UEFI) indem Sie direkt in die (emulierte) Phoenix-Firmware booten– das DVD-Laufwerk sollte
 vor der Festplatte in der Boot-Reihenfolge stehen (sonst würde das System von der Festplatte booten …
 in unserem Fall ist diese aber leer, also kein Problem). Tipp: VM → Power → Power On to Firmware

 (6) ~~~Starten Sie die VM und notieren Sie die Startzeit der Installation! Zählen Sie ab jetzt auch die Zahl der
 Neustarts bis zum Abschluss der Installation (= Desktop erscheint)!

 (7) FolgenSiedenInstallationsanweisungen, bei Nachfrage des Setup-Programms geben Sie sinnvolle Vorgaben
 (in Ihrem Ermessen), auf jeden Fall aber:

 a) Lokalisierung (Uhrzeit und Währungsformat): Deutsch/Österreich

 b) Sie haben keinen Produktschlüssel und möchten Windows 11 in der Education3-Edition installieren

 c)
 Benutzerdefinierte Installation auf die gesamte 40 GiB-Festplatte

d) WährendSie warten, recherchieren Sie im Web, welche Editionen es von Windows 11 gibt (Protokoll!)und nennen Sie einige Ihrer Meinung nach wesentliche Unterschiede (kann man auch später oder zuhause machen)!

e) Setzen Sie Lokalisierungsinformationen (Ort, Sprache, Tastatur) und überspringen Sie etwaige Auf
forderungen zur Netzwerkkonfiguration

f) Nennen Sie den (lokalen!) Benutzer junioradmin (Passwort sei auch junioradmin, Hin
weis/Sicherheitsfragen beliebig – bitte hier notieren).

g) VerwendenSieansonsten nicht die Standard-Datenschutzeinstellungen, sondern passen Sie die Einstellungen sinnvoll an (so dass diese Ihren Ansprüchen an Vertraulichkeit genügen – bitte hier notieren)

h) Notieren Sie bei Erscheinen des Desktops erneut die Zeit und beantworten Sie …
 
~~~~~i. Wie lange hat die Installation gedauert?
~~~~~ii. Wie viele Neustarts waren erforderlich?
~~~~~iii. Wie vergleicht sich das mit Ihren bisherigen Windows-Installationserfahrungen?

i) Ändern Sie den Namen des Computers auf UE01-IhrFamilienname-IhrVorname (Tipp: Systemsteue
rung → Kleine Symbole → System → Erweiterte Systemeinstellungen oder schneller: Tastenkombina
tion Windows + Pause)! Wie lautete der Standardname? Was ist notwendig, damit die Änderung des Computernamens tatsächlich durchgeführt wird? Dokumentieren Sie hier anhand eines Screenshots4, dass Ihr Rechner erfolgreich umbenannt wurde!

(8) Jetzt ist ein guter Zeitpunkt um einen Snapshot zu erstellen. VMware speichert den Zustand der virtuellenv Maschine (Festplatte und Einstellungen), man kann jederzeit zu diesem Zustand zurückkehren. Mache Sie den Snapshot am besten bei heruntergefahrener VM! Dokumentieren Sie die Schritte, um einen Snapshot zu erstellen!

(9) Installieren Sie die VMware-Tools (VM → Install …), um die VM über einen besseren Anzeigetreiber zu beschleunigen und auch bequemer bedienen zu können. Insbesondere erlauben diese Gasterweiterungen, dass man die Bildschirmauflösung beliebig einstellen kann und Dateien bequem per Copy/Paste bzw Drag’n’Drop kopieren kann. Wenn der Rechner nach der Installation (einfach das richtige Setup-Programm von der – virtuellen
DVDstarten und Standardinstallation durchklicken) neu gebootet wird, sollte man wieder einen Snapshot anlegen! Überprüfen Sie im Info-Bereich rechts, ob der VMware-Tools-Dienst ausgeführt wird – welche Version der Tools ist installiert?

== F~~~  Erkunden und Analyse des PCs

Erkunden Sie Ihren neuen Computer – beantworten Sie folgende Fragen und geben Sie jeweils an, wie Sie diese Information erhalten haben!

Tipp: Wechseln Sie die Ansicht ihrer VM in den Vollbildmodus (Full Screen)!

Tipp: Sollten Sie diese Schritte später/zuhause durchführen, können Sie einen beliebigen Windows-11-PC verwenden – aber bitte im Protokoll vermerken!

(10) Machen Sie sich mit dem Windows 11 User Interface vertraut. Dokumentieren und merken Sie sich, wie man folgende Werkzeuge möglichst schnell aufrufen kann! (Tipp: Nutzen Sie das Handout über Windows Tastenkombinationen!)

a) Erweitertes Kontextmenü (Quicklink zu den wichtigsten Verwaltungswerkzeugen im Desktop)

b) Explorer-Fenster öffnen Hauptfenster

c) Einstellungen (Modern UI Style)
 
d) Systemsteuerung (klassisch)

e) Task-Manager

f)  Systemeigenschaften (Info-Feld “System”)

g) Geräte-Manager

h) Terminal = Kommandozeile: ist seit Windows 10 1703 (Creators Update) nicht mehr CMD sondern die Powershell

i) Snipping-Tool, um einen Screenshot in die Zwischenablage zu kopieren

j) Bonus: Fügen Sie zwei virtuelle Desktops hinzu und starten Sie im ersten der neuen virtuellen Desk
tops den Taschenrechner calc.exe und im anderen den Task-Manager. Wozu sind virtuelle Desktops nützlich?

(11) Welche Windows-Version (mit genauer Build-Nummer) haben Sie installiert? Mit welchem Programm (das Sie mit Windows-R starten können haben Sie das ermittelt?

(12) RAM– Arbeitsspeicher/Hauptspeicher (wie ermitteln Sie das?):

a) Wie viel Hauptspeicher (RAM) hat der PC insgesamt– Wie viele Bytes sind das?

b) Dielaufenden Programme verbrauchen Platz im Arbeitsspeicher– wie viel RAM ist noch für weitere Programme verfügbar?

(13) CPU– Prozessor → Ermitteln Sie:

a) Hersteller

b) Modell/Typ

c) Taktfrequenz

(14) Disk: Welche Datenträger (uns interessieren die Festplatten) gibt es auf diesem Rechner, wie groß sind sie jeweils (in Gibibyte5 und in Bytes) und wie viel Plattenplatz ist in den einzelnen Partitionen (Teilbereiche) jeweils schon in Verwendung bzw. noch frei (Tipp: Datenträgerverwaltung)?

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  inset: 20pt,

  align: horizon,
  table.header(
    [Volume / Laufwerks-Name], [Dateisystemtyp], [Gesamtgröße in GiB], [Gesamtgröße in Bytes], [Belegt (GiB)], [Frei (Gi)], [Belegt B) (%)]
  )
)


Viel Spaß!

