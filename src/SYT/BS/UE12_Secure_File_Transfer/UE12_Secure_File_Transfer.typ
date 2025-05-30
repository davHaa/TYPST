#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#show: template 

#let filename = "12_Secure_File_Transfer";


#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ Hintergrund und Ziele der Übung Secure File Transfer
#v(2mm)

Nachdem wir in der letzten Übung gelernt haben, wie man sich _remote_
über _SSH_ über das Netzwerk auf einem anderen Rechner anmeldet, werden wir 
uns in dieser Übung damit beschäftigen, wie Dateien zwischen 
unterschiedlichen Systemen sicher ausgetauscht werden können.

== B~~~ Auto-Login mit Schlüsselpaar
#v(2mm)

#count6[SSH-Zugang ohne Passwort: Statt Passwörtern kann _ssh_ auch ein Schlüsselpaar (_public + private key pair_) verwenden: Am Server wird der _public-key_ eines Benutzers hinterlegt. Jede/r der den passenden _private-key_ besitzt, darf sich einloggen.

+ Erzeugen Sie auf Ihrem Host-Rechner#footnote[Mittlerweile funktioniert das auch unter Windows.] mit `ssh-keygen` ein Schlüsselpaar (ohne _Passphrase_) für `junioradmin`.

  - Welche Dateien werden erzeugt -- wie lautet deren absoluter Pfad?
  - Welche zusätzliche Informationen werden angezeigt?


+ Kopieren Sie den public-key *vom Host* *in* die Linux-VM:
  - Je nachdem, welches Host-System Sie verwenden, benutzen Sie dafür folgendes Kommando:
			
      Windows-Host: 

			```powershell
			type $env:USERPROFILE\.ssh\id_rsa.pub | ssh user@IP-Adresse "cat >> .ssh/authorized_keys"
			```

			Linux-Host: `ssh-copy-id user@IP-Adresse` 
			
  - Welche Daten werden kopiert (Quelle – Ziel)?
  - Warum darf der _private-key_ die eigene Maschine *NIEMALS* verlassen?

+ Was passiert jetzt beim Verbinden mit `ssh user@IP-Adresse`? Wird nach einem Passwort gefragt?

+ Warum gilt die Authentifizierung mittels Schlüsselpaar als sicherer#footnote[vorausgesetzt man passt gut auf den geheimen private-key auf!]als ein Login mittels herkömmlicher Passwörter?]

== C~~~ SSH-Client Konfiguration
#v(2mm)

Möchte man sich auf der Kommandozeile mit einem anderen Server verbinden, muss man den Rechnernamen, Benutzerkennung und 
evtl. auch die Portnummer bekanntgeben. Diese Voreinstellungen können (auch unter Windows) in der Datei namens `config` (im Unterordner `.ssh` Ihres Benutzerverzeichnisses) hinterlegt werden
Damit kann der Anmeldevorgang deutlich vereinfacht werden. Falls der Ordner `.ssh` bzw. die Datei `config` nicht existieren, müssen Sie diese anlegen.

#count[Wie lautet der absolute Pfad der ssh-Konfigurationsdatei?]

#count[Beschreiben Sie in der folgenden Beispieldatei (auf Ihrem Host -- IP-Adresse anpassen), was die jeweilige Zeile bewirkt, indem Sie Kommentare hinzufügen:]

    ```bash
	# ssh (secure shell) configuration file
	Host linuxrechner
		Hostname 10.11.12.13
		User junioradmin
		
	Host webserver
		HostName www.mysuperdomain.at
		Port 55550
		User kipferl
		IdentityFile ~/.ssh/private_ssh_key_rsa
    ```

#count[Was passiert mit dieser Konfigurationsdatei nach Eingabe von `ssh linuxserver` oder `ssh webserver`? Ist das eventuell problematisch?]

#count[Erstellen Sie auf Ihrem Host-System (kann auch Windows sein) eine SSH-Client-Konfigurationsdatei#footnote[Achtung: Windows-Notepadfügt standardmäßig die Erweiterung `.txt` am Dateinamen an!], die es Ihnen ermöglicht, sich mittes `ssh kali` als junioradmin in Ihrer Linux-VM anzumelden! Fügen Sie die Konfigurationsdatei im Protokoll ein!

 Achtung: unter Windows zum Testen `ssh` in der `powershell` verwenden.

    ```
    Konfig hier einfügen
    ```]

== D~~~ SSH – Dateien kopieren
#v(2mm)

Nun geht’s an das Kopieren der Datei – wir wollen auf sichere Weise die Datei _xx_`_nwconf___YY__.txt` aus der letzten Übung#footnote[Ggf. müssen Sie die Datei nochmals neu erzeugen - sie beinhaltet die Ausgabe des Befehls `ip a`] (_xx_ ist wieder IhrFamilienname) von der Linux-VM sowohl zur Windows-VM kopieren als auch zu einem anderen Linux-Rechner:

#count[Öffnen Sie im Windows ein `cmd`- oder `powershell`-Fenster und legen Sie ein Verzeichnis `C:\TEMP` an.]

#count[Nachdem Sie _xx_`_nwconf___YY__.txt` auf der Linux VM im dortigem Heimatverzeichnis abgespeichert haben,
	verwenden Sie zum Kopieren dieser Datei auf die Windows-Maschine nun den Befehl 
	`scp`#footnote[`scp` gibt es erst seit relativ kurzer Zeit auf Windows-Systemen. Davor konnte man `pscp.exe` aus dem Putty-Paket verwenden.].
	-- Schema:

    ```bash
    Kopierbefehl   Remote-User@Remote-Computer:Remote-Path  Ziel

    ```

    Bei uns wäre das also etwa (vollständiger Befehl und dessen Ausgabe ins Protokoll!):

    ```powershell
    scp           junioradmin@IP-Adresse:xx_nwconf___YY__.txt  C:\TEMP

    ```]

#count[Die Datei sollte sich jetzt auf `C:\TEMP` befinden -- betrachten Sie die Datei mit `notepad`!]

#count[Jetzt kopieren Sie noch analog die selbe Datei zum Desktop Ihres Hosts (also von der virtuellen Maschine heraus). Wie lautet Ihre verwendete Kommandozeile? Testen Sie auch hier, ob Sie die kopierte Datei öffnen und lesen können!
	
Hinweis: Auf einem Linux-Host (oder neuerdings auch in der Powershell unter Windows) machen Sie das vom Shell-Prompt aus mit
dem (zur PuTTY-Version `pscp` äquivalenten) Befehl `scp` (ohne das "`p`").]

#count[_Bonus -- Falls Sie die Übung auf dem Rechner in der Schule machen --:_ Erzeugen Sie unter Linux eine Datei mit einem netten Textinhalt und kopieren Sie diese den Schreibtisch des Benutzers `junioradmin` auf dem (virtualisierten) Rechner Ihre/r/s Nachbar/i/n.

    Welchen Befehl benutzen Sie dazu?

    Was könnte man noch Interessantes auf dem Nachbarrechner machen?#footnote[Beachte aber die Gesetzeslage laut Strafgesetzbuch – StGB § 126c.: 
#link("https://www.ris.bka.gv.at/GeltendeFassung.wxe?Abfrage=Bundesnormen&Gesetzesnummer=10002296") ... Störung der Funktionsfähigkeit eines Computersystems ... ist mit Freiheitsstrafe bis zu sechs Monaten oder mit Geldstrafe bis
zu 360 Tagessätzen zu bestrafen.]

    Wie könnte sich der/die Nachbar/in davor schützen?]

== E~~ SFTP
#v(2mm)

Manchmal hat man lokal eine graphische Oberfläche, aber nur SSH-Zugang zum entfernten Rechner. Um dennoch mit einem graphischen Dateibrowser auf dem _remote_ System zu arbeiten, kann man eine SSH-Erweiterung, nämlich SFTP _(SSH File Transfer Protocol)_ und einen smarten Datei-Browser verwenden. 

#count[Zunächst werden wir überprüfen, ob auf Ihrem Host-System ein geeigneter Datei-Browser vorhanden ist und diesen ggf. nachinstallieren.

- Falls Ihr Host-Rechner ein Windows-System ist, installieren Sie das sehr empfehlenswerte _WinSCP_: #link("http://winscp.net").

- Auf einem Linux-System eignen sich _Thunar_ (Kali-Linux), _nemo_ (am Linux Mint) bzw. _Nautilus_ (am GNOME-Desktop).]

#count[Starten Sie Ihren graphischen Datei-Browser (also auf ihrem Windows-System oder auf einem zweiten Linux-System) und geben Sie als _Ort_ an:

    `sftp://user@IP-Adresse`

    Wichtiger Hinweis: Im `nemo`-Dateibrowser aktiviert die Tastenkombination Ctrl + L die Pfadeingabe.]

#count[Wechseln Sie jetzt (nach dem Anmelden) "mit der Maus" (im
graphischen Dateibrowser) auf der VM in das Heimatverzeichnis von
`junioradmin` und fügen Sie einen Screenshot Ihres grafischen Dateibrowsers ein, in dem Ihre Datei _xx_`_nwconf___YY__.txt` zu sehen ist!]

#count[Was passiert, wenn Sie dort die Datei _xx_`_nwconf___YY__.txt` durch Doppelklick öffnen? Screenshot!]

#count[Was passiert wenn man die Datei ändert und speichert? Was muss da im Hintergrund _passieren_?]

== F~~ Bonus: GUI über ssh
#v(2mm)

#count[Bei der Verwendung von X-Windows (graphisches Subsystem unter Linux) kann auch die "graphische" Oberfläche durch eine ssh-Verbindung getunnelt werden. Verbinden Sie sich von einer zweiten Linux-VM oder Ihrem Linux-Host aus mit

    ```bash
    ssh -Y user@IP-Adresse
    ```
    in die Linux-VM. Starten Sie dort
    ein Programm mit grafischer Oberfläche z.B. eine Konsole mit
    `gnome-terminal` (oder eine Uhr mit `xclock`).

- Wo _läuft_ dieses Programm?
- Wo _erscheint_ das Fenster?]

#count[Was machen die Optionen `-L` und `-R` bei `ssh`?]

_Viel Spaß!_