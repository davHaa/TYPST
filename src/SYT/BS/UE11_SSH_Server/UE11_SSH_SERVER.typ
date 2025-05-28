#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#show: template 

#let filename = "11_SSH_Server";

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
In dieser Übung wollen wir zunächst lernen, wie man sich _remote_ über das Netzwerk auf einem anderen Rechner anmeldet und Befehle ausführt, bevor wir in dern folgenden Übungseinheit Dateien zwischen den Systemen austauschen werden.

Dies sind unerlässliche Aufgaben für die Administration von Systemen, die man nur über eine Netzwerkverbindung erreichen kann. Typischerweise erfolgt eine solche Verbindung über eine Textkonsole (Kommandozeile) – jetzt können wir die grundlegenen _Bash-_Befehle einsetzen, die wir in den letzten Übungen kennen gelernt haben!

Wir werden plattformübergreifend testen, wie man sowohl von einem Linux- als auch von einem Windows-Client aus eine sichere Verbindung auf einen Linux-Server einrichtet.

Dazu verwenden wir das SSH-Protokoll, das einen _Client_ und einen
_Server_ benötigt: Der Client eröffnet die TCP-Verbindung, die der
Server (standardmäßig auf *Port 22*) akzeptiert – dann besteht eine verschlüsselte Verbindung zwischen den beiden Kommunikationspartnern, die gewöhnlich auf der Serverseite von einem Kommandozeileninterpreter (Shell) bedient wird.

Nachdem der SSH-Server auf unserem (virtuellen) Linux-Rechner
möglicherweise noch nachinstalliert werden muss, werden wir auch die
Paketverwaltung (und zwar die _Debian_-Variante) verwenden lernen.

Aktuelle Versionen von SSH bieten zahlreiche erweiterte Funktionen, die in
dieser Laborübung nicht behandelt werden können. So kann beispielsweise mit SSH
ein _Tunnel_ eingerichtet werden, über den ein lokaler Webserver aus dem Internet
erreichbar gemacht wird (siehe Anhang _SSH-Linux-Magazin-2017-01.pdf_).

== B~~~ SSH Server – Installation des Servers
#v(2mm)
#set enum( //Nummerierung 
  full:true, 
  numbering: numbly("{1:(1)}", "{2:a}")
)

+ *Vorbereitung*: Stellen Sie die Netzwerk-Schnittstelle ihres virtuellen Kali-Linux Rechners auf Netzwerkbrücke (_bridged_), damit dieser direkt mit dem Schulnetz (oder Ihrem Heimnetz zu Hause) verbunden und von außen erreichbar ist (also *nicht* NAT verwenden).

+ *Starten* Sie die VM und melden Sie sich als `junioradmin` an.
+ Installieren und aktualisieren Sie mit Hilfe der Paketverwaltung den SSH Server!
	Sie brauchen dazu root-Rechte, die Sie z.B. mit `sudo` erhalten:

	+ "Frischen" Sie die lokal gespeicherte Liste der verfügbaren Pakete auf (`sudo apt-get update`).
	+ Überprüfen Sie, ob das Paket installiert ist, indem Sie sich alle installierten Pakete seitenweise auflisten 
	   (z.B. die Ausgabe von `dpkg -l` an `less` weiterleiten)!
	+ Welche Taste müssen Sie nun drücken, um...
		- in dieser angezeigten Liste nach dem Paket (z.B. `openssh-server`) zu suchen?
		- den nächsten Suchtreffer zu erhalten?
		- das Programm zu beenden?
	+ Falls es noch nicht installiert ist  → das Paket `openssh-server` herunterladen und installieren:
    ```bash
	       apt-get install openssh-server
	```
	
+  Nachdem dieser _Server_ (= _Dienst_ = _Daemon_) installiert ist, wird er automatisch
    gestartet und läuft im Hintergrund (als Prozess `sshd`). Überprüfen Sie den Status des Dienstes mit `systemctl status sshd`  → Befehl und Ausgabe in das Protokoll!

+ Mit welchem Kommando können Sie den Daemon `sshd` nun stoppen?

+ Und wie können Sie ihn wieder neu starten?


+ _Tipp:_ Installieren nun Sie das Paket `bash-completion`! Dieses erleichtert die Eingabe der _komplexen_ Befehle#footnote[für _neue_ Shells dh. neues Fenster] →Befehl ins Protokoll.


Sie können jetzt _von einem entfernten_ Rechner aus auf diesem System
alles machen, was Sie bisher in der Konsole (am Shell-Prompt) des
lokalen Systems gemacht haben -- sofern Sie sich auf dem System anmelden dürfen `;-)`.