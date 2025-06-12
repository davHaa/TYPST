#import "../resources/SEW_Template.typ": create_page_template
#import "../resources/SEW_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/SEW_Template.typ": count, count2, count8, count6; 
#show: template 

#let filename = "07_py_argparse";

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ Externe, lokale Befehlsausführung aus Python
#v(2mm)
Repository: Ordner `py_adminscripting`.

== A.1~~~ Systemprogrammierung in Python
#v(2mm)
Unter Systemprogrammierung versteht man die Programmierung von Softwarekomponenten, die Teil des Betriebssystems sind oder die eng mit 
dem Betriebssystem bzw. mit der darunter liegenden Hardware kommunizieren müssen. 
Systemnahe Software, wie beispielsweise das `sys`-Modul in Python, fungiert als Abstraktionsschicht zwischen der Anwendung, 
dem Python-Programm, und dem Betriebssystem. 
Mit Hilfe dieser Abstraktionsschicht lassen sich Applikationen plattformunabhängig implementieren, auch wenn sie direkt auf 
Betriebssystemfunktionalitäten zugreifen.#footnote[Quelle: https://www.python-kurs.eu/os_modul_shell.php]

Wir haben bereits im dritten Jahrgang in Systemtechnik / Betriebssysteme gelernt, wie man unter Linux und Windows Scripts programmiert.
Insbesondere die _Powershell_ stellt eine äußerst mächtige, objektorientierte Scripting-Umgebung zur Verfügung.
Inzwischen existieren auch für Python Bibliotheken, mit denen man ebenfalls sehr effiziente Scripts zur Systemadministration programmieren kann.

== A.2~~~ `pathlib`-Modul
#v(2mm)
Das PythonModul  `pathlib` wird verwendet, um Dateipfade auf eine objektorientierte Weise zu manipulieren und zu verwalten und 
wird deshalb meist gegenüber dem älteren `os.path`-Modul bevorzugt.

Siehe dazu die Dokumentation bzw. im beiliegendem Cheatsheet:

- #link("https://realpython.com/python-pathlib/#python-pathlib-examples")[https://realpython.com/python-pathlib/#python-pathlib-examples]
- #link("https://docs.python.org/3/library/pathlib.html
")[https://docs.python.org/3/library/pathlib.html]

Darin enthalten ist die Klasse `Path`, mit der sich die verschiedenen Teile eines Datei- oder Verzeichnispfades einfach extrahieren lassen: #footnote[siehe https://realpython.com/python-pathlib/#picking-out-components-of-a-path]:

```python
	from pathlib import Path
	p = Path(r"C:\Users\junioradmin\Pycharm\py_adminscripting\get_path_components.py")
```

- `p.name`: Der Dateiname ohne Verzeichnis
- `p.stem`: Der Dateiname ohne die Dateierweiterung
- `p.suffix`: Die Dateierweiterung
- `p.anchor`: Der Teil des Pfades vor den Verzeichnissen
- `p.parent`: Das Verzeichnis, das die Datei enthält bzw. das übergeordnete Verzeichnis (wenn der Pfad ein Verzeichnis ist)

#count[Schreibe die Datei `get_path_components.py`, das den absoluten Pfad einer Datei einliest (`input()`) und die oben gelisteten Verzeichnisteile ausgibt. 
Außerdem soll das übergeordnete Verzeichnis des Ordners (in dem sich die Datei befindet) ausgegeben werden. Falls dieses nicht existiert, gibt das Programm stattdessen aus: _Parent directory does not exist!_.]
#count[ Implementiere `find_files_by_ext.py`: Das Programm liest über die Tastatur einen Pfad und eine Dateinamenserweiterung ein und durchsucht rekursiv nach allen 
Dateien mit dieser Extension und gibt alle gefundenen Dateien mit ihrem absoluten Pfad aus.]
Zu diesen Zweck gibt es die Methoden `iterdir()`, welche über alle Dateien im gegebenen Verzeichnis iteriert.

```python
	from pathlib import Path
	from collections import Counter
	print(Counter(path.suffix for path in Path.cwd().iterdir()))
```

Möchte man Dateien suchen, deren Namen einem bestimmten Suchmuster entsprechen, bieten sich die Methoden `glob()` und das rekursive `rglob()` an:

```python
def tree(directory:Path, extension:str):
    print(f"+ {directory}")
    for path in sorted(directory.rglob("*.py")):
        depth = len(path.relative_to(directory).parts)
        spacer = "    " * depth
        print(f"{spacer}+ {path.name}")
```

== A.3~~~ Fotos archivieren: Python-Bibliothek `shutil`
#v(2mm)
Viele Digitalkameras und Smartphones legen ihre Fotos in einem einzigen, unübersichtlichen Ordner 
(meist unter `DCIM` = _D_igital _C_amera _IM_age) ab.
Dabei werden im Dateinamen häufig Aufnahmedatum und -uhrzeit codiert. 
Beispiel: _|LASTYYYY|_ _1113_083245-1.jpg wurde am 13. November _|LASTYYYY|_ um 08:32 und 45 Sekunden erstellt.

#count[Schreibe das Programm `copy-dicm.py`, das zunächst die Verzeichnisse _SourcePath_ und _DestinationPath_ (via Tastatur) einliest. Anschließend kopiert das Programm alle Dateien mit der Extension `.jpg` aus dem Ordner _SourcePath_
in eine datumsbasierte Ordnerstruktur unter dem Verzeichnis _DestinationPath_: Zielordner werden -- falls erforderlich -- automatisch erstellt. Tipp: Zum Kopieren von Dateien mit Python-Skripten verwendet man das Modul `shutil`#footnote[Ab Python Version 3.14 kann das auch die oben vorgestellte Klasse `Path`.]: siehe #link("https://docs.python.org/3.14/library/shutil.html#module-shutil")[https://docs.python.org/3.14/library/shutil.html#module-shutil]]


Beispiel:
Im _SourcePath_ `X:\DCIM` befinden sich folgende Dateien, die das Kommando in den _DestinationPath_ `C:\pic` wie angegeben kopiert:
```

    X:\DCIM\__LASTYYYY__1231_235959.jpg--> C:\pic\__LASTYYYY__\12\31\__LASTYYYY__1231_235959.jpg
    X:\DCIM\__YYYY__0101_000001.jpg    --> C:\pic\__YYYY__\01\01\__YYYY__0101_000001.jpg
    X:\DCIM\__YYYY__1113_083245juhu.jpg--> C:\pic\__YYYY__\11\13\__YYYY__1113_083245juhu.jpg
    X:\DCIM\__YYYY__1113_083245-2.jpg  --> C:\pic\__YYYY__\11\13\__YYYY__1113_083245-2.jpg
    X:\DCIM\__YYYY__0101_172418.gif    --> nicht kopieren: falsche Extension
    X:\DCIM\oje.jpg   --> nicht kopieren - Dateiname hat keinen Zeitstempel
```
== A.4~~~ Externe Programme aus Python aufrufen: `subprocess`-Modul
#v(2mm)
Python erlaubt es, externe Programme entweder mit `subprocess.run()` oder `os.system()` zu starten.
Gegenüber dem `os`-Modul ist das deutlich modernere `subprocess`-Modul vorzuziehen:

- Flexibilität: `subprocess` bietet eine flexiblere und leistungsfähigere Schnittstelle zum Ausführen externer Programme (z.B. Popen-Objekte zur detaillierten Kontrolle über die Ein- und Ausgabe von Prozessen)
- Sicherheit: `subprocess` bietet sicherere Methoden zum Ausführen von Shell-Befehlen, da es die Verwendung von Listen zur Übergabe von Argumenten unterstützt. Dies reduziert das Risiko von Shell-Injection-Angriffen.
- Erweiterte Funktionen: `subprocess` bietet erweiterte Funktionen wie das Weiterleiten von Ein- und Ausgaben zwischen Prozessen, das Festlegen von Zeitlimits für Prozesse und das Abrufen von Rückgabewerten und Fehlercodes.

`subprocess.run` führt einen Befehl *blockierend* aus, dh es wird gewartet, bis der Befehl abgeschlossen ist. 
Zurückgegeben wird ein CompletedProcess-Objekt, das Informationen über den ausgeführten Befehl enthält, 
einschließlich des Rückgabecodes#footnote[Der Parameter `check=False` bewirkt, dass im Falle eines Fehlers 
(d.h. wenn der ausgeführte Befehl einen Rückgabewert ungleich 0 liefert) keine Ausnahme ausgelöst wird.], 
der Standardausgabe und der Standardfehlerausgabe.

Der nachfolgende Programmcode (bitte ausprobieren!) zeigt diesen Sachverhalt. Man kann hier auch sehr schön das blockierende Verhalten von `subprocess.run()`beobachten.

```python
# file write_stdout_strerr.py
import sys, time

if __name__ == "__main__":
    print("Dies ist eine Nachricht auf stdout") # Ausgabe auf stdout
    print("Dies ist eine Nachricht auf stderr", file=sys.stderr) # Ausgabe auf stderr
    print(f"{sys.argv} wartet zehn Sekunden:")
    time.sleep(10)
    print(f"{sys.argv} wird beendet.")
    sys.exit(42)
```


```python
# file subprocess_test.py
import subprocess, sys

if __name__ == "__main__":
    print(f"{sys.argv} startet einen Subprozess:")
    result = subprocess.run(["python", "write_stdout_strerr.py"], 
		capture_output=True, text=True, check=False)
    print(result.stdout)
    print(result.stderr)
    print(f"Der returncode war: {result.returncode}")
```
== A.5~~~ Aufgabe: pinglawine.py
#v(2mm)
#count[Schreibe das Programm `pinglawine.py`, das eine IP-Adresse mit Netzwerk-Suffix (also in CIDR-Notation) einliest und anschließend hintereinander alle gültigen 
Host-Adressen des gesamten Subnetzes anpingt.]

Hinweis: Alle Pings werden der Reihe nach hintereinander ausgeführt -- also blockierend ohne Multithreading:  
Erst wenn ein Fenster geschlossen wird, dann beginnt der nächste ping in einem neuen Fenster.

```python
		res = subprocess.run(['ping ', addresse], creationflags=subprocess.CREATE_NEW_CONSOLE)
```

== B~~~ Remote-Befehle ausführen -- Paramiko
#v(2mm)
Paramiko ist eine Python-Bibliothek, die es ermöglicht, SSH-Verbindungen herzustellen, Remote-Befehle auszuführen und Dateien zu übertragen. Siehe z.B. #link("https://codilime.com/blog/python-paramiko-and-netmiko-for-automation/")[https://codilime.com/blog/python-paramiko-and-netmiko-for-automation/]

== B.1~~~ Paketinstallation und Grundprinzip von Paramiko
Dazu muss zunächst das Paket `paramiko` installiert werden (entweder im PyCharm Paketmanager oder in der Shell mit ```bash pip install paramiko ```).

Anschließend kann man sich folgendermaßen mit einem Remote-Server mittels Benutzernamen / Passwort authentifizieren und einen Befehl ausführen:

```python
import paramiko
sshclient = paramiko.SSHClient() # Erstelle ein SSH-Client-Objekt
sshclient.set_missing_host_key_policy(paramiko.AutoAddPolicy())
sshclient.connect('hostname', username='username', password='password') # Verbindung herstellen
stdin, stdout, stderr = sshclient.exec_command('ls -l') # Remote-Befehl ausführen und Output holen
print(stdout.read().decode())
sshclient.close() # Verbindung schließen
```

== B.2~~~ Authentifizierung mit Schlüsselpaar
#v(2mm)
Im 2. Jahrgang haben wir in SYT/BS bzw. ITSI gelernt, wie man ein Schlüsselpaar (*public + private key pair*) zur sicheren Authentifizierung generiert und einsetzt.
Wir machen nochmals rasch die Aufgaben aus der damaligen Übung:

#count6[ Am Server wird der *public-key* eines Benutzers hinterlegt. Jede/r der den passenden
    *private-key* besitzt, darf sich einloggen.
    + Starte eine Kali-Linux VM (mit Netzwerk = host only), die wir als Remote-Server verwenden.
	+ Erzeuge auf dem Host-Rechner (= der Rechner von dem aus man sich auf den Remote-Server anmelden möchte: Windows^[Ja, mittlerweile funktioniert das tatsächlich auch unter Windows.] oder Linux) mit `ssh-keygen` ein
        Schlüsselpaar (ohne *Passphrase*) für `junioradmin`.

        - Welche Dateien werden erzeugt -- wie lautet deren absoluter Pfad?
        -  Welche zusätzliche Informationen werden angezeigt?
+ Kopiere den public-key *vom Host* *in* die Linux-VM:
		- Je nachdem, welches Host-System verwendet wird, folgendes Kommando benutzen:
			- Windows-Host: 
			```powershell
			type $env:USERPROFILE\.ssh\id_rsa.pub | ssh user@IP-Adresse "cat >> .ssh/authorized_keys"
			```
			Erkläre die Funktionsweise dieses Work-Arounds!
			- Linux-Host: `ssh-copy-id user@IP-Adresse` 
			
 - Welche Daten werden kopiert (Quelle – Ziel)?
 - Warum darf der _private-key_ die eigene Maschine *NIEMALS* verlassen?

+  Testen: Was passiert jetzt beim Verbinden mit `ssh user@IP-Adresse`? Wird nach einem Passwort gefragt?
+  Warum gilt die Authentifizierung mittels Schlüsselpaar als sicherer^[vorausgesetzt man passt gut auf den geheimen private-key auf!]
        als ein Login mittels herkömmlicher Passwörter?
]
#count[
 Nachdem die Anmeldung über das Schlüsselpaar funktioniert, können wir das auch mittels *Paramiko* aus einem Python-Programm verbinden:
	Prinzip: 
	
	```python
	def key_based_connect(host, passphrase=None):
		 username = "kali"
		 keyfile = r"C:\Users\harald\.ssh\id_rsa"
		 if not passphrase:
			 passphrase = getpass(f"Enter passphrase for key: {keyfile}")
		 pkey = paramiko.RSAKey.from_private_key_file(keyfile, password=passphrase)
		 client = paramiko.SSHClient()
		 policy = paramiko.AutoAddPolicy()
		 client.set_missing_host_key_policy(policy)
		 client.connect(host, username=username, pkey=pkey, )
		 return client
	```
	
	Hinweis: `getpass()` muss man importieren und funktioniert innerhalb der Python-IDE eventuell nicht ganz einwandfrei -- daher ggf. in einer Python-Shell testen.]

#count[
Aufgabe: schreibe das Programm `journalctlremote.py`, das eine Zeit in Minuten einliest. 
	Danach verbindet es sich mittels Schlüsselpaar mit dem Server
	(IP-Adresse kann hardcoded sein) und holt alle Journal-Log-Einträge der letzten Minuten.]
#count[ Netzwerkautomatisierung mit Netmiko

	_Paramiko_ ist ein generisches SSH-Modul, das sich besonders zur Kommunikation mit dem OpenSSH-Protokoll eignet.
	Die meisten Netzwerkgeräte benutzen proprietäre SSH-Implementierungen, die nicht 100% kompatibel zu OpenSSH sind.
	Zu diesem Zweck ist _Netmiko_ die geeignetere Bibliothek, weil diese zusätzliche Funktionen bietet, 
	die speziell für die Verwaltung von Netzwerkgeräten unterschiedlicher Hersteller entwickelt wurden.

	Als abschließende Vorbereitung für weiterführende Netzwerktechnik-Übungen ist diese Seite 
	(ab Abschnitt _Why isn’t Paramiko enough for network automation?_) lesen: #link("https://codilime.com/blog/python-paramiko-and-netmiko-for-automation/")[https://codilime.com/blog/python-paramiko-and-netmiko-for-automation/]
]