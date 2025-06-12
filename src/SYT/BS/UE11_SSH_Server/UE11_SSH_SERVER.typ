#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count, count2, count6; 
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
#count[ *Vorbereitung*: Stellen Sie die Netzwerk-Schnittstelle ihres virtuellen Kali-Linux Rechners auf Netzwerkbrücke (_bridged_), damit dieser direkt mit dem Schulnetz (oder Ihrem Heimnetz zu Hause) verbunden und von außen erreichbar ist (also *nicht* NAT verwenden).
]
#count[ *Starten* Sie die VM und melden Sie sich als `junioradmin` an.]
#count6[ Installieren und aktualisieren Sie mit Hilfe der Paketverwaltung den SSH Server!
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
	```]
	#count[  Nachdem dieser _Server_ (= _Dienst_ = _Daemon_) installiert ist, wird er automatisch
    gestartet und läuft im Hintergrund (als Prozess `sshd`). Überprüfen Sie den Status des Dienstes mit `systemctl status sshd`  → Befehl und Ausgabe in das Protokoll!]
#count[Mit welchem Kommando können Sie den Daemon `sshd` nun stoppen?]
#count[Und wie können Sie ihn wieder neu starten?]
#count[ _Tipp:_ Installieren nun Sie das Paket `bash-completion`! Dieses erleichtert die Eingabe der _komplexen_ Befehle#footnote[für _neue_ Shells dh. neues Fenster] →Befehl ins Protokoll.]

Sie können jetzt _von einem entfernten_ Rechner aus auf diesem System
alles machen, was Sie bisher in der Konsole (am Shell-Prompt) des
lokalen Systems gemacht haben -- sofern Sie sich auf dem System anmelden dürfen `;-)`.

== C~~~ SSH Client – Verwenden des Clients
#v(2mm)
#count[Stellen Sie noch einmal sicher, dass Ihre Linux-VM netzwerkmäßig        "am Schulnetz" angeschlossen ist (gegebenenfalls VM mit Netzwerk angeschlossen an Netzwerkbrücke" neu starten – also nicht "NAT"-Einstellung verwenden!)]
#count[Starten Sie am Linux Rechner (in der VM) ein Terminal-Fenster und
		ändern Sie den Hostnamen dieser VM  mit dem Befehl `hostnamectl hostname Kali-`_IhrFamilienname_).]
#count6[
	Finden Sie mit dem Befehl `ip addr show` (kurz `ip a` oder -- noch besser -- 
	in Farbe `ip -c a`) die IP-Adresse des Rechners (genauer: der Netzwerkschnittstelle `eth...` oder `ens...`) heraus:

	+ Fügen Sie den Befehl zur Anzeige der IP-Adressen und dessen Ausgabe hier im Protokoll ein!
	+ Wie lautet die IP-Adresse Ihres Rechners (in der VM)? Falls Sie keine IP-Adresse erhalten, dann könnte dies daran liegen, dass Sie die Übung auf Ihrem privaten Rechner machen und der DHCP-Server Ihnen keine IP-Adresse zuweist. In diesem Fall stellen Sie die Network Connection auf "Host only" (statt "Bridged").#footnote[Dann kann allerdings Ihr Nachbar nicht auf Ihren SSH-Server zugreifen.]
	+  Was bedeutet eigentlich die angezeigte Schnittstelle mit dem Namen `lo`#footnote[Hinweis: Wahrscheinlich
	    kommt Ihnen deren zugewiesene IP-Adresse/Subnetzmaske aus dem Netzwerktechnik-Unterricht bekannt vor!]?
 +  Speichern Sie auf der Kommandozeile die Ausgabe des Befehls `ip a`
        in eine neue Text-Datei
        _xx_`_nwconf___YY__.txt` im Ordner `/home/junioradmin`! 
		Hinweis: Benutzen Sie nachfolgend im Dateinamen statt _xx_ stets Ihren Familiennamen! → Wie lautet der Befehl dazu?]
#count6[ Als nächsten Schritt wollen wir von einem Windows-Rechner aus auf
    unseren SSH-Server zugreifen. Seit einigen Jahren ist ein OpenSSH-Client im Windows-System integriert. Wir werden trotzdem den sehr bewährten SSH-Client (namens _PuTTY_) nachrüsten und erst in der nächsten Übung direkt von der Windows-Kommandozeile (`cmd` oder `powershell`) SSH nutzen.
    +  Falls Sie nicht auf einem Windows-System arbeiten: Starten Sie Ihre Windows VM und melden Sie sich als ein Benutzer
        an, der Mitglied der Administratoren-Gruppe ist *(warum wohl?)*.
    +  Laden Sie die Ihrer Plattform entsprechende Version des
        Programms `PuTTY` von [www.putty.org](http://www.putty.org/)
        herunter und installieren Sie das *komplette Installer*-Paket für 64-Bit-Prozessoren ("Windows MSI installer package") auf Ihrem Windows Rechner.
				        - Was ist die aktuelle Version von PuTTY?
								- _Bonus:_ Unter welcher Lizenz steht PuTTY?
								- _Bonus:_ Dürfen Sie PuTTY kommerziell frei verwenden oder müssten Sie in diesem Fall für die Benützung eine Lizenzgebühr zahlen?
  +  Starten Sie das Programm PuTTY und geben Sie im Feld "Host Name" die IP-Adresse des Linux Rechners ein; klicken Sie dann auf "Open".
	+  Falls die Verbindung nicht funktioniert, deaktivieren Sie ausnahmsweise auf dem Windows-Rechner die Firewall#footnote[Tipp: in `wf.msc` unter _Firewall-Eigenschaften_]
	+  Welche Warnung erscheint nun beim ersten Verbindungsaufbau zu Ihrem Linux-Rechner? → Screenshot ins Protokoll! 
+  Welchen Zweck hat diese Warnung bzw. welche Problematik wird damit _gelöst_ (bitte recherchieren oder nachfragen)?
+  Melden Sie sich als `junioradmin` an. Sie haben jetzt die selben Rechte wie bei lokaler Anmeldung auf der Konsole.
+  Mit welchem Kommando können Sie nun den Inhalt der Datei _xx_`_nwconf___YY__.txt` anzeigen?
+  Wie fügen Sie ans Ende der Datei den Text `User `_nnnn_` was here!` hinzu (_nnnn_ ist ihre Eduvidual-Nummer)?
+  Wechseln Sie in das Verzeichnis `~/Desktop` bzw.
        `~/Arbeitsfläche` bzw. `~/Schreibtisch` und erzeugen Sie dort die neue Datei _xx_`_ReadMe___YY__.txt`
        mit dem Befehl `touch` (Beispiel: `touch xx_ReadMe__YY__.txt`) oder -- noch einfacher -- mittels `>xx_ReadMe__YY__.txt`
+ Wenn Sie jetzt auf den Linux Rechner wechseln, sollte auf dem
        Desktop die von Ihnen erstellte Datei liegen. Verifizieren Sie dies.
        Verändern Sie die Datei: Schreiben Sie Ihren Namen, das aktuelle Datum
        sowie einen interessanten Text hinein.
+ Wechseln Sie wieder zu Windows und dem PuTTY Fenster und lassen
        Sie sich den Inhalt der Datei *xx*`_ReadMe___YY__.txt` mit dem Befehl `cat` anzeigen (_SSMOODLE_).]
#count6[Testen Sie Ihren _ssh_-Zugang auf Ihre Linux-VM über das Netzwerk von
    einem anderen Linux-Rechner aus, indem Sie eine zweite Instanz Ihrer Kali-Linux-VM erstellen (--> weiterer Linked-Clone. Nicht vergessen: Netzwerkschnittstelle auf _bridged_ (oder _host-only_) setzen):

  + Starten Sie dort eine Kommandozeile und melden Sie sich mit _(Muster - bitte anpassen!)_: `ssh user@IP-Adresse` am _Remote System_ (also Ihrer ersten Linux-VM) an.
	+ Welche Frage stellt der SSH-Client beim ersten Zugriff?
	+ Überprüfen sie z.B. mit `uname -a`, dass Sie sich am richtigen System befinden! Vergleichen Sie die Systemzeit (`date`) auf dem entfernten Rechner (Linux-VM) mit der auf Ihrem System (ein wichtiger Schritt bei einem "echten" Einsatz) – notieren Sie Ihre Beobachtungen!
	+ Führen Sie eine typische "Wartungsarbeit" durch, indem Sie z.B. den freien Plattenplatz mit `df -h` überprüfen!
]
#count[
	Verifizieren des Fingerprints auf dem Server
	
	 Möchte man sicherstellen, dass man sich beim erstmaligen Verbindungsaufbau zu einem SSH-Server wirklich mit den _richtigen_ Rechner verbindet, dann sollte man bei einem Administrator#footnote[der lokal auf dem Server angemeldet ist] um den Fingerprint bitten (am besten telefonisch).
	
    - Starten Sie auf Ihrem Server (also dem ersten Linux-System):
    ```bash
	       for i in /etc/ssh/*key.pub; do ssh-keygen -lvf $i; done
	```
	- Ist der bei e. angezeigte Fingerprint dabei? Dokumentieren Sie im Screenshot die Fingerprints und markieren Sie den vorhin verwendeten.
 - _Bonus:_ Warum gibt es mehrere Keys / Fingerprints am Server?]

== C~~~ SSH Client – Verwenden des Clients
#v(2mm)
#count[Erstellen Sie einen Snapshot Ihrer virtuellen Maschine! 
Welchen (sinnvollen) Namen haben Sie dem Snapshot gegeben?]
#count[In der nächsten Übungseinheit wird an dieser Stelle fortgesetzt!]
_Viel Spaß!_