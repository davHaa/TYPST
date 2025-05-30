#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "16_Linux_Zugriffssteurung";



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

In dieser Übung wollen wir die Zugriffssteuerung auf Dateien und Ordner unter Linux kennen und anwenden lernen. Dazu werden wir beispielhaft
eine Berechtigungsstruktur einer kleinen Firma anlegen.

= B~~~ Plattform und Durchführung
#v(2mm)

Sie benötigen für diese Übung wieder ein Kali-Linux-System, auf dem Sie als Benutzer das Recht haben, Superuser-_(root)_-Privilegien (etwa mittels *`sudo`*) zu erhalten. Am besten verwenden Sie eine der vorbereiteten virtuellen Maschinen -- dort ist es der User *junioradmin*, also mit *junioradmin* anmelden!

Dokumentieren Sie in Ihrem Protokoll _jede_ der verwendeten Befehlszeilen!

= C~~~ Wiederholung Benutzererstellung (siehe letzte Übung)
#v(2mm)

Legen Sie mittels Skript die folgenden Gruppen und Benutzer (und Verzeichnisse) an: Verwenden Sie in dieser Übung statt *IhrLogin* Ihren Schul-Loginnamen mit Ihrer 4-stelligen Nummer und vorangestelltem "s" (z.B. s9999)! 

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

Jeder User soll im Skript mit einer einzigen Befehlszeile und obigen
Daten angelegt werden.

_Tipp 1:_ Legen Sie zuerst die Unterverzeichnisse *bh*, *mgmt*, *verwaltung* und *personal* an!

_Tipp 2:_ Wieder wollen Sie in der Regel die Passwortvergabe nicht von Hand mit dem Befehl
*`passwd`* vornehmen, sondern auch über unser Skript
automatisieren _(was ist aber am Skripten der Passworteingabe eventuell problematisch - was muss man auf jeden Fall beachten?)_ -- Sie können Sie dazu den Befehl *`chpasswd`* verwenden (mittels der Befehlszeile: *`echo user:password | chpasswd`* )!

= D~~~ Dateiberechtigungen – Befehle
#v(2mm)

Schauen Sie sich die _Manual-Pages_ (oder Web-Recherche, z.B. Suche nach
*`man chown`* führt meist zum Ziel) zu folgenden Befehlen an: *`chmod`*, *`chown`*, *`chgrp`* und beantworten Sie damit die folgende Fragen:

#count[Wie können Sie sich die Berechtigungen einer Datei oder eines Verzeichnisses anzeigen lassen?]

#count[Wie können Sie Besitzer und Gruppe einer Datei bzw. eines Verzeichnisses mit _einem_ Befehl ändern bzw. zuweisen?]

#count[Wie können Sie den Besitzer von einem Verzeichnis sowie von allen Unterverzeichnissen und Dateien darunter auf einmal verändern?]

#count[Was macht der Parameter *`-c`* im Befehl *`chown`* bzw. im Befehl *`chgrp`*?]

#count[Was macht *`chmod`* mit symbolischen Links _(wirkt es auf den Link oder die Zieldatei - bitte ausprobieren mit `ln -s`!)_?]

#count[Was bedeutet das _Sticky-Bit_ auf Verzeichnissen (_Tipp: Handout S.3)_?
    
    → Sie können und sollten Ihre Antworten auch durch Ausprobieren (Testen) in Ihrer Linux-VM verifizieren!]

= D~~~ Dateiberechtigungen – Praxis I
#v(2mm)

#count[Dokumentieren Sie und beschreiben Sie die Bedeutung der Berechtigungen der Dateien *`/etc/passwd`*, *`/etc/shadow`*, *`/usr/bin/passwd`*,
*`/var/log/dmesg`* und des Ordners *`/home`*!
Wie würde die oktale Schreibweise dieser Berechtigungen ausschauen?]

#count6[Betrachten Sie die Berechtigungen der oben erzeugten Benutzerverzeichnisse

- Wer ist Besitzer? Welche ist die zugehörige Gruppe? _(z. B._ *_/home/bh/abuchmacher_*)

- Welche Berechtigungen existieren - „wer kann was“ in diesen Verzeichnissen machen?

Achtung: bitte Namen angeben, z.B. „Hans darf …“ und nicht „der Besitzer darf …“]

Verändern Sie die zugehörige Gruppe der den Benutzer-(Heimat-)Verzeichnissen übergeordneten Ordner wie folgt _(geben Sie die verwendeten Befehle an)_:

- * /home/bh* zugehörige Gruppe: *buchhaltung*

- * /home/personal* zugehörige Gruppe: *personal*

- * /home/verwaltung* zugehörige Gruppe: *verwaltung*
 
- * /home/mgmt* zugehörige Gruppe: *mgmt*

= F~~~ Dateiberechtigungen – Praxis II
#v(2mm)

*Achtung:*

- _Geben Sie stets die *verwendeten Befehle* an!_

- _Geben Sie nach Fertigstellung und Test der Ordnerberechtigungen die *Ausgabe eines Listings  `ls -ld`* eines jeden erzeugten Ordners in Ihr Protokoll, damit die letztendlich gesetzten Berechtigungen dokumentiert und nachvollziehbar sind (Beispiel: Ausgabe von `ls -ld /data_xxxx/buchhaltung`)!_

#count6[Wir wollen gemeinsam genutzte Ordner für die Arbeitsdokumente der einzelnen Abteilungen anlegen:

+ Erzeugen Sie ein Verzeichnis * /data_xxxx/buchhaltung* (mit _xxxx_=Ihrer vierstelligen Eduvidual-Nummer; der Besitzer des Verzeichnisses soll *root* sein), in dem alle Mitglieder der Gruppe *buchhaltung* schreiben können und alle anderen keinerlei Berechtigungen haben (natürlich sollen die berechtigten Benutzer auch das Verzeichnis lesen bzw. in das Verzeichnis wechseln dürfen).

+ Erzeugen Sie weiters die Verzeichnisse * /data_xxxx/personal* sowie * /data_xxxx/verwaltung*, in denen analog zuvor wieder nur die entsprechenden Gruppen schreiben dürfen.

+ _IhrLogin_ soll allerdings überall schreiben dürfen!]

#count6[
  *WICHTIG:* _Testen der Sicherheitsstruktur_: Überlegen Sie sich für jede der folgenden Aktionen, ob sie theoretisch möglich ist oder nicht. Dann führen Sie die Aktion aus und dokumentieren Sie! Schreiben Sie also in dieses _Testprotokoll_, ob es gehen sollte oder nicht und das tatsächliche Ergebnis Ihres Tests _(Empfehlung: *Tabelle* – welcher Befehl, welcher Benutzer, erwartetes Ergebnis, wirkliches Ergebnis, in Ordnung?)_:
  
+ Erzeugen Sie eine Datei im Verzeichnis * /data_xxxx/buchhaltung* als Benutzer *abuchmacher*.

+ Erzeugen Sie eine Datei im Verzeichnis * /data_xxxx/verwaltung* als Benutzerin *utipp*.

+ Erzeugen Sie einen neuen Ordner im Verzeichnis * /data_xxxx/personal* als Benutzer *hhuber*.

+ Lassen Sie sich alle Dateien des Ordners * /data_xxxx/buchhaltung* als Benutzerin *utipp* anzeigen.

+ Lassen Sie sich alle Dateien der Verzeichnisse *data_xxxx/buchhaltung*, * /data_xxxx/personal* und * /data_xxxx/verwaltung* als Benutzer _IhrLogin_ anzeigen.

+ *ggruber* soll eine Datei im Verzeichnis * /data_xxxx/buchhaltung* erzeugen.

+ Erzeugen Sie eine Datei im Verzeichnis * /data_xxxx/personal* als Benutzer/in _IhrLogin_.

+ Wie fügen Sie als Benutzer/in _IhrLogin_ an das Ende einer Datei im Verzeichnis * /data_xxxx/buchhaltung* den Text "Der Chef war da!" hinzu? Funktioniert das? Warum?

+ Löschen Sie als Benutzer/in _IhrLogin_ eine Datei im Verzeichnis * /data_xxxx/buchhaltung*! Funktioniert das? Warum?

+ Erzeugen Sie ein Verzeichnis * /data_xxxx/fueralle*, das der Gruppe *mgmt* und dem/der Benutzer/in _IhrLogin_ gehört, der in diesem Verzeichnis Dateien anlegen, löschen und umbenennen darf. Alle anderen Mitarbeiter des Konzerns dürfen darin nur lesen (also Inhalt auflisten und in das Verzeichnis wechseln).
]

_Viel Spaß!_