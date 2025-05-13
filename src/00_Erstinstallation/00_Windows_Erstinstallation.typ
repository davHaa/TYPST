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

b) Als Betriebssystem wählen Sie Microsoft Windows → Windows 11 x64

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

b) Sobald das Fenster zur Eingabe der Sprachen erscheint, starten Sie mit folgendem Vollprofi-
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

1. *Optional:* Boot-Reihenfolge überprüfen und sicherstellen, dass das DVD-Laufwerk vor der Festplatte liegt.

2. VM starten, Startzeit der Installation notieren.

3. Windows-Installationsanweisungen folgen:
   - *Lokalisierung:* Deutsch/Österreich
   - *Edition:* Education (kein Produktschlüssel erforderlich)
   - *Benutzerdefinierte Installation* auf die gesamte Festplatte
   - *Benutzer:* `junioradmin` (Passwort: `junioradmin`)
   - *Datenschutzeinstellungen* anpassen
4. Installationsdauer und Anzahl der Neustarts notieren.
5. Computer umbenennen: `UE01-Nachname-Vorname`.
6. Einen *Snapshot* der VM erstellen (bei heruntergefahrener VM).
7. *VMware-Tools* installieren und nach Installation einen weiteren *Snapshot* erstellen.


== F~~~  Erkunden und Analyse des PCs

Ermitteln Sie folgende Informationen und dokumentieren Sie, wie Sie diese erhalten haben:

- *Windows-Version* (inkl. Build-Nummer)
- *RAM:* Gesamtgröße und verfügbarer Speicher
- *CPU:* Hersteller, Modell, Taktfrequenz
- *Festplatte:* Datenträger, Größe (GiB und Bytes), belegter und freier Speicher
- *Schnelle Navigation zu Windows-Werkzeugen:*
  - *Task-Manager, Explorer, Systemeigenschaften, Terminal (PowerShell)*
  - *Virtuelle Desktops nutzen* (Taschenrechner in einem, Task-Manager im anderen)

Viel Spaß!


