#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "15_Linux_Benutzerverwaltung";



#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

= A~~~ Übungsziel
#v(2mm)

 In dieser Übung wollen wir auf der Kommandozeile Benutzer anlegen und verwalten lernen. Ferner werden wir
 hinter die Kulissen der Benutzerverwaltung unter Linux blicken, indem wir die Inhalte der Konfigurationsdateien
 analysieren.

 = B~~ Plattform und Durchführung
#v(2mm)

Sie benötigen für diese Übung ein Linux-System, auf dem Sie als
Benutzer das Recht haben, Superuser-_(root)_-Privilegien zu erhalten
(mit `sudo`#footnote[`sudo`: startet einen Prozess mit den Rechten eines anderen Benutzers (meistens `root`). 
Das geht nur, wenn man (direkt oder als Mitglied einer Gruppe) in der Datei `/etc/sudoers` eingetragen ist!]
oder `su`#footnote[`su` (*s*witch *u*ser oder *s*ubstitute *u*ser identity)]). Am besten verwenden Sie die vorbereitete
Kali-Linux-Maschine -- auf den VMs mit GUI ist dafür der User `junioradmin` eingerichtet!

Dokumentieren Sie in Ihrem Protokoll *jede* der verwendeten
Befehlszeilen, eventuell wichtige Ausgaben der Befehle und
die Antwort auf *alle* Fragen!


= C~~ Anlegen eines Benutzers
#v(2mm)

#count[Legen Sie eine neue Benutzergruppe `avatare` an! Welche (einfache) Befehlszeile haben Sie zum Anlegen der Gruppe verwendet?]

#count[In welcher (Text-)Datei des Systems wurde durch (1) ein neuer Eintrag vorgenommen? Geben Sie mittels des Befehls `grep` die entsprechende Zeile aus! Welche `Group-ID` hat die Gruppe `avatare`? Wo steht diese Information?]

#count6[Legen Sie -- mit `einer` Befehlszeile -- einen neuen Benutzer mit diesen Daten an:
- Name: `max`
- Vollständiger Name: `Max Headroom`
- Benutzerverzeichnis (= Heimatverzeichnis): `/home/max`
- Shell: `/bin/bash`
- Hauptgruppe (= _Login Group)_: `avatare`

Beantworten Sie dazu folgende Fragen:

+ Welche Befehlszeile#footnote[Eselsbrücke: *`d`*as *`c`*hamäleon *`m`*ag *`g`*erne *`G`*rüne *`s`*chmetterlinge ;-)] haben Sie zum Anlegen des Benutzers verwendet?
+ In welchen (Text-)Dateien des Systems wurden durch a. neue Einträge vorgenommen? Geben Sie mittels des Befehls `grep` die entsprechende Zeile aus der jeweiligen Datei aus!
+ Welche `User-ID` hat der Benutzer `max`?
+ Kann der Benutzer sich bereits einloggen (anmelden)?
]

#count6[
Geben Sie dem Benutzer `max` ein _gutes_ Passwort!

+ Wie haben Sie das gemacht?
+ In welcher (Text-)Datei des Systems wurde durch Setzen eines Passworts eine Änderung vorgenommen? Geben Sie mittels des Befehls `grep` die entsprechende Zeile aus!
+ Überlegen Sie, wie ein _gutes_ Passwort aussieht?
+ Ist ein System dadurch sicherer, wenn ein Administrator die Benutzer dazu zwingt, regelmäßig ihre _guten_ Passwörter zu ändern?
]

#count6[Versuchen Sie sich auf folgende drei Arten als Benutzer `max` anzumelden und vermerken Sie im Protokoll, ob es funktioniert _(wenn nicht, was ist die Fehlermeldung?)_ :
+ mit dem Kommando `su - username`. Was macht der Befehl `su`? Wozu dient die merkwürdige Option "--"?
+ Testen Sie auch das Anmelden über ssh: `ssh username@localhost` _(ggf. müssen Sie wieder das `openssh-server`-Paket installieren)_!
+ Falls a. und b. funktionieren: Melden Sie sich nun an der graphischen Oberfläche an!
]

#count[Nur wenn (5) nicht geht: Überprüfen Sie, ob das Benutzerverzeichnis von `max` vielleicht nicht existiert _(wie überprüft man das?)_ oder ob etwa das Passwort nicht gesetzt ist _(wo kann man das überprüfen?)_!

  - Wenn das Benutzerverzeichnis nicht existiert, müssen Sie es anlegen (_Achtung:_ Der Besitzer sollte `max` sein -- ggf mit `chown max /home/max` nachhelfen; und `max` sollte auch alle Rechte auf sein Verzeichnis haben -- `chmod 750 /home/max`). Geht das Anmelden jetzt?
  - Warum war das Verzeichnis nicht vorhanden bzw. was wäre die richtige `useradd`-Befehlszeile gewesen?]

= D~~ Anlegen mehrerer Benutzer
#v(2mm)

#count[
  Erzeugen Sie am System folgende Benutzer mit Hilfe einer einfachen *Skriptdatei* _(ins Protokoll!)_, mit dem Dateinamen `useranlegen.sh` _(vorher alle 5 Tipps lesen!)_:

     _Tipp 1:_ Ihre Skripdatei erstellen Sie am einfachsten in einem Editor (`nano`  / `vi`). Geben Sie für jeden Benutzer einen `useradd`-Befehl pro Zeile an (ohne `sudo`). Sie können die Datei dann mit `sudo sh useranlegen.sh` ausführen#footnote[In der nächsten Übung lernen Sie, wie man eine Datei ausführbar macht, so dass Sie die Scriptdatei ohne `sh` starten können]!

     _Tipp 2:_ Es empfiehlt sich, zuerst die Gruppen
        (`buchhaltung`, `mgmt`, …) sowie die übergeordneten Ordner
        der Benutzerverzeichnisse (`/home/bh`, `/home/mgmt`,
        …) anzulegen!

     _Tipp 3:_ Wir wollen auch die Passwortvergabe über das Skript
        (Batchdatei) automatisieren! Verwenden Sie dazu den Befehl `chpasswd`
        (mittels der Befehlszeile: `echo username:password | chpasswd` )  -- was ist daran eventuell problematisch?


     _Tipp 4:_ Es wäre klug, vor dem Anlegen (einmalig, nicht im Skript) dieser Benutzer
        und Gruppen Sicherungskopien der drei wesentlichen Dateien der
        Benutzerverwaltung zu machen -- _welche Dateien sind das und wie macht man das?_

     _Tipp 5:_ ganz oben in der Scriptdatei sind oft folgende einfache "Debug-Optionen" hilfreich:

    -  `set -e`   bricht im Fehlerfall sofort ab (Skript läuft nicht weiter)
    - `set -v -x` gibt jeden Befahl vor der Ausführung nochmals aus
	  - in der Scriptdatei beginnen Kommentare mit `#`

Liste der Benutzer:

Achtung: Statt _IhrLogin_ verwenden Sie Ihren Schul-Loginnamen mit Ihrer 4-stelligen Nummer und vorangestelltem "s" (z.B. s9999)! 

]

#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 0.7pt + black)
  },
  align: (x, y) => (
    if x > 0 { center }
    else { left }
  )
)

#table(
  columns: 5,
  table.header(
    [Benutzername],
    [Name],
    [Hauptgruppe],
    [Benutzerverzeichnis],
    [Passwort]
  ),
  [abuchmacher ],
  [Alf Buchmacher], [buchhaltung], [/home/bh/abuchmacher], [pferde__YYYY__],
  [bfernreiser],
  [Bert Fernreiser], [buchhaltung], [/home/bh/bfernreiser], [karibiktraum__YY__], 
  [hscheffe],
  [Herbert Scheffe], [mgmt], [/home/mgmt/hscheffe], [king],
  [IhrLogin],
  [IhrName], [mgmt], [/home/mgmt/IhrLogin],  [ganzgeheim__YYYY__],
  [utipp],
  [Ulla Tipp], [verwaltung], [/home/verwaltung/utipp], [blumenkind],
  [hhuber],
  [Hans Huber], [personal], [/home/personal/hhuber], [IchWerdeChef],
  [ggruber], 
  [Gabi Gruber], [personal], [/home/personal/ggruber], [gabi73]
    )
  
#count[Fügen Sie die Skriptdatei hier im Protokoll ein und laden Sie diese zusätzlich in Eduvidual hoch!]

#count[Wie sicher sind obige Passwörter?]

#count[Vergewissern Sie sich, dass die Benutzer (samt Home-Directory) erfolgreich angelegt worden sind -- Sie können sich dazu graphisch anmelden oder direkt auf der Kommandozeile mit `su - username` den Benutzer testweise wechseln.]

#count[Schreiben und testen Sie eine zweite Scriptdatei mit dem Dateinamen `userloeschen.sh`, die alle obigen Benutzer mitsamt ihren Heimatverzeichnissen wieder _löscht_!]

#count[Mit welchem Kommandozeilen-Befehl überprüfen Sie, welche Benutzer-ID und welche Gruppen _IhrLogin_ zugewiesen wurde?
Fügen Sie den Befehl und einen Screenshot mit dessen Ausgabe in Ihr Protokoll ein!]

#count[Sichern Sie Ihre Scripts -- Sie werden diese in der nächsten SYT/BS Übung brauchen!]

= E~~ Bonusaufgaben:
#v(2mm)

#count[Wer ist/war Max Headroom? Warum heißt er so? ;-)]

#count[Sehr praktisch ist der Befehl `getent`.
- Wie zeigen Sie mit diesem Kommando die User-Infos aller Benutzer des Systems an?
- Geben Sie die Infos der User `hhuber` und `utipp` aus!]

#count[_Super-Bonusaufgabe:_ Was macht die Option `-e` des Befehls `chpasswd`? Wie erweitern Sie Ihr Script, damit das Passwort hier nicht in Klartext gespeichert werden muss! (_Tipp:_ `openssl passwd -1 ...`)!]

_Viel Spaß!_

