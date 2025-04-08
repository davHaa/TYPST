#import "../template.typ": page_template

#set page(width: 210mm, height: 297mm, margin: (top: 10mm, bottom: 20mm, left: 15mm, right: 15mm),header-ascent: -18mm,

header : page_template.header,
  footer : page_template.footer)

  #v(35mm)

== A~~~ Zielsetzung

Vorbereitend für die folgenden Laborübungen wollen wir:

- uns mit der Umgebung zur Rechnervirtualisierung im Labor vertraut machen,
- einen ersten virtuellen Computer ("Virtuelle Maschine", VM) selbst "bauen" und
- darauf ein aktuelles Windows (von einer virtuellen Installations-DVD) installieren.

~~~#emph[Bemerkung:] In den folgenden Laborübungen werden vorbereitete virtuelle Maschinen einfach ~~~kopixert (sog. #emph[Cloning]), damit nicht immer eine Neuinstallation notwendig ist.

Im Anschluss werden einige Kenndaten auf unserem virtuellen PC ermittelt und in einem ersten Labor-Protokoll dokumentiert.


== B~~~ Durchführung

Ihr Übungsprotokoll soll alle notwendigen Schritte zur Durchführung der Übung dokumentieren, sodass eine andere Person anhand des Protokolls die gesamte Übung problemlos später nachvollziehen kann. Die Bewertung erfolgt aufgrund von Korrektheit, Vollständigkeit und Form. Ferner sollte das Protokoll Ihre Antworten auf alle gestellten Fragen enthalten.

#strong[Wichtig:] Sie dürfen sich bei einem allfälligen Interview auf Ihr Protokoll beziehen (#emph[Sie können also während des Betreuergesprächs auch etwas kurz in Ihrem Protokoll nachlesen].


== C~~~ Inbetriebnahme der VM

1. Virtualisierungs-Software (ein sog. Typ-II-Hypervisor) auf dem Host-System starten.

2. Mit der Virtualisierungs-Software (*VMware Workstation*) eine neue VM erstellen:
   - *New Virtual Machine → Custom (Advanced)* auswählen, Betriebssystem später installieren.
   - Betriebssystem: `Microsoft Windows` → `Windows 11 x64`
   - Name der VM nach Standard: `Windows11_Pro_Edu_Nachname_Vorname_UE01`
   - Firmware Type: *UEFI*
   - Hardware-Spezifikationen:
     - *CPU:* 1 Prozessor / 2 Cores
     - *RAM:* 4 GiB
   - *Host-Only* Netzwerkverbindung (keine Internetverbindung für schnellere Installation)
   - Neue virtuelle Festplatte (40 GiB, nicht vor-alloziert, dynamisch wachsend)

3. Eine Windows-Installations-DVD als *ISO-Image* in das virtuelle CD/DVD-Laufwerk der VM einlegen.


== D~~~ Registry-Hack zur Installation in VMware

Microsoft setzt hohe Hardwareanforderungen für Windows 11, darunter TPM. Um die Installation in einer VM zu ermöglichen, wird ein Registry-Hack angewendet:

1. VM starten und von der DVD booten.

2. Beim Sprachfenster die Kommandozeile öffnen (`Shift + F10`).

3. *Registrierungseditor* (`regedit`) öffnen und zu `HKEY_LOCAL_MACHINE\SYSTEM\Setup` navigieren.
4. Neuen Schlüssel `LabConfig` erstellen.
5. Innerhalb von `LabConfig` folgende `DWORD (32-Bit)`-Werte setzen:
   - `BypassTPMCheck = 1`
   - `BypassSecureBoot = 1`
   - `BypassRAMCheck = 1` (optional)


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


