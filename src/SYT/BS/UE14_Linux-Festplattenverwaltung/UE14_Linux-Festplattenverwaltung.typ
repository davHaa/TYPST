#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "14_Linux-Festplattenverwaltung";



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

Wir wollen Grundkompetenzen zum Anlegen und Verwalten von Festplattenpartitionen unter Linux entwickeln sowie verstehen, wie man Dateisysteme anlegt und montiert.

= B~~~ Durchführung
#v(2mm)

Grundlagen:

#count[Welche drei wesentlichen Schritte sind notwendig, um einen neuen Datenträger zu verwenden? (_Tipp:_ 1. - 2. - 3. !)]

= C~~~ Partitionieren auf der Kommandozeile:
#v(2mm)

Legen Sie eine neue Kali-Linux-VM an und bauen Sie zusätzlich eine neue, leere (virtuelle) Festplatte mit ihrer Virtualisierungs-Software ein (Größe: _1 GiB_). Schließen Sie diese an Ihre VM _vor dem
Starten_ an! Für die Bonus-Übung am Ende des Labors verbinden Sie die virtuelle Maschine ggf. im _Bridged_-Modus mit dem Schulnetzwerk.

Führen Sie dann folgende Aufgaben im Terminal-Fenster (Konsole) der VM durch bzw. beantworten Sie alle Fragen. In das Protokoll kommen:

- Alle durchgeführten Schritte (Befehlszeilen jeweils angeben!)
- Antworten auf alle Fragen

#count[Einen Überblick über alle Festplatten und Partitionen erhält man mit folgenden Kommandos.

Welche Festplatten und Partitionen gibt es derzeit? Benutzen Sie folgendev Kommandos _(Ausgabe ins Protokoll!)_:
- `lsblk`

  -man kann sich auch die UUID anzeigen lassen. Wie? (_Tipp:_ `-o UUID` oder der Befehl `blkid ...` )
- `parted -l`

- `fdisk -l`

Was ist der Name der Gerätedatei der neuen Festplatte? Erklären Sie auch noch einmal allgemein das Benennungsschema für die Gerätedateinamen von Massenspeichern (Disks, SSDs) unter Linux!
]

#count[Wir wollen mit dem Befehl `parted` darauf zwei Partitionen anlegen → Betrachten Sie dazu die folgende _beispielhafte_ Partitionierung _(Tipp: Partitionierungsbeispiel)_. _Achtung:_ Schreiben Sie bei (4) _alle tatsächlich verwendeten_ `parted`-Befehle ins Protokoll, die Angaben im folgenden _Tipp_ sind nur ein Beispiel!]

== C.1~~~ Partitionierungsbeispiel
#v(2mm)

Zum Partitionieren kann man auf der Kommandozeile das Tool `parted` verwenden (neben der graphischen Version `gparted`).

#set text(fill: gray)

Hier ein _Beispiel_-Dialog, um je eine primäre 500 MiB
und 100 MiB Partition auf der _dritten_ Festplatte anzulegen. Wir geben
gleich den Dateisystemtyp an, den wir später beim Formatieren verwenden
wollen – das legt aber kein Dateisystem an, sondern legt nur (vorauseilend) den Eintrag für den Dateisystemtyp in
der Partitionstabelle am Anfang der Festplatte fest!

Achtung: Bitte die Befehle nicht mit copy/paste aus der Angabe kopieren sondern abtippen! -- Aufgrund der vewrdendeten UTF8-Sonderzeichen kann es sein, dass `parted` damit nicht umgehen kann. 

_(Tool im interaktiven Modus aufrufen, dabei die Festplatte angeben, die wir partitionieren wollen):_

    parted /dev/sdc

_(Neue Partitionstabelle anlegen, "msdos" bedeutet MBR-Format, "gpt" würde GPT-Format bedeuten):_

    (parted) mktable msdos

_(1. prim. Partition anlegen mit Typ ext4; vorne etwas Platz lassen =
Start also bei 2 MiB, Ende bei 500 MiB):_

    (parted) mkpart primary ext4 2MiB 500MiB

_(2. primäre Partition anlegen mit Typ FAT32 – Start bei 500MiB, Ende
bei 600MiB):_

    (parted) mkpart primary fat32 500MiB 600MiB

_(Kontrolle, ob Partitionen erfolgreich angelegt):_


    (parted) print
    ...

    Partitionstabelle: msdos

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
  columns: 7,
  table.header(
    [Anzahl],
    [Beginn],
    [Ende],
    [Größe],
    [Typ],
    [Dateisystem],
    [Flags]
  ),
  [1],
  [2MiB], [500MiB], [500MiB], [primary], [ext4], [],
  [2],
  [500MiB], [600MiB], [100MiB], [primary], [fat16], [lba]
    )
    (parted) quit
    
  #set text(fill: black)

  Nun sind Sie dran.

== C.2~~~ Aufgabe: Partitionieren
#v(2mm)

#count[Legen Sie nun selber die beiden gewünschten Partitionen an (Partitionierungsstil diesmal: GPT)!

- 1. Partition: ca. 800MiB, Start bei 2 MiB, Typ `ext4`
- 2. Partition: ca. 200MiB, Typ `fat32`

Wie?]

#count[Überprüfen Sie ob beide Partitionen erfolgreich angelegt worden sind _(Ausgabe ins Protokoll)_ -- wie heißen die beiden neuen _Gerätedateien_?]

= D~~~ Anlegen der Dateisysteme ("Formatieren"):
#v(2mm)

== D.1~~~ Tipp zum Formatieren
#v(2mm)

Mit `mkfs` ("make file system") kann man eine
Partition mit einem Dateisystem formatieren, mit der Option `-t type` gibt man den Dateisystemtyp an (z.B: `-t ext3` für EXT3 oder `-t vfat` für FAT32)

== D.2~~~ Aufgabe: Formatieren
#v(2mm)

#count[Formatieren Sie die _erste_ Partition der neuen Festplatte mit dem Dateisystemtyp `ext4`:
      ```
      # mkfs -t ext4 /dev/...
      ```]

#count[Formatieren Sie analog die zweite Partition, aber mit FAT32 (der Dateisystemtyp FAT32 heißt `vfat` unter Linux) --  _Wie?_]

= E~~~ Einhängen (Montieren) der Dateisysteme::
#v(2mm)

== E.1~~~ Tipp zum Montieren (Einbinden/Einhängen)
#v(2mm)

Eine formatierte Festplattenpartition kann man mit dem Befehl
`mount` einbinden -- Verwendung:

~~~~`mount -t` _Dateisystemtyp Gerätedatei Verzeichnis_

Details:

- _Dateisystemtyp_ gibt die Art des Dateisystems an (bei fehlender `-t`-Option versucht `mount`, den Typ zu erraten) – Beispiele: ` -t ext3` oder `-t vfat`

- Alle unterstützten Dateisystemtypen kann man mit `cat /proc/filesystems` herausfinden

- _Gerätedatei_ kennzeichnet die Festplattenpartition – Beispiel: `/dev/sdb1` für zweite Platte, erste Partition

- _Verzeichnis_ ist ein (am besten leerer) Ordner, der als Einhängepunkt _(mount point)_ dient – Beispiel `/mnt`

== E.2~~~ Aufgabe: Einhängen
#v(2mm)

#count[Legen Sie zwei Verzeichnisse `/daten_`_IhrVorname_ und `/daten__YY__` an -- _Wie?_]

#count[Hängen Sie die beiden neuen Dateisysteme auf der neuen Platte jeweils unter `daten_`_IhrVorname_ und `/daten__YY__` ein – _wie?_]

#count[Überprüfen Sie mit `df -h` den verfügbaren Plattenplatz auf der neuen Platte – wie viel ist tatsächlich frei (einzeln und gesamt)? __SSMOODLE__]

#count[Starten Sie Ihre VM neu – ist der Speicherplatz auf der neuen Festplatte nach dem Neustart unter `/daten_`_IhrVorname_ und `/daten__YY__` automatisch wieder verwendbar _(überprüfen mit `mount` bzw. `df`)_? Warum/Warum nicht?]

== E.3~~~ Aufgabe: Aushängen
#v(2mm)

#count[Hängen Sie das ext4-Dateisystem auf der ersten Partition der neuen Disk noch einmal ein _(wieder überprüfen mit `mount` bzw. `df` -> ins Protokoll!)_, dann hängen Sie das Dateisystem mit *umount* wieder aus -- überprüfen Sie, ob das geklappt hat _(erneut mit `mount` bzw. `df` -> ins Protokoll!)_!]

= F~~~ Automatisches Einhängen der Dateisysteme beim Hochfahren
#v(2mm)

== F.1~~~ Tipps zum automatischen Montieren von Dateisystemen
#v(2mm)

=== F.1.1~~~ Konfiguration
#v(2mm)

Damit alle Dateisysteme beim Neustart automatisch mittels
`mount` eingehängt werden, trägt man sie in der
Konfigurationsdatei `/etc/fstab` _("file system table")_ ein – jede Zeile steht für ein Dateisystem, dabei gilt folgendes Format (dazwischen Tabulatoren):

```
    #Gerät     Einhängepunkt Dateisystemtyp Optionen dump pass
    /dev/sdc2  /daten        ext3           rw       0    0
```
#count[Überlegung: Welche zwei Zeilen braucht man also für unsere Partitionen (noch nicht einfügen)?]

=== F.1.2~~~ Gerätedatei oder UUID
#v(2mm)

Statt der Gerätedatei `/dev/`... kann man auch die
`UUID` angeben (abfragen z.B. mit `blkid`)

#count[Wie macht es das Host-Betriebssystem -- Gerätedatei oder UUID? Und warum ist das die bessere Wahl? (_Tipp:_ Wann ändert sich die Bezeichnung?)]

=== F.1.3~~~ Option zum automatischen Montieren mit `mount`
#v(2mm)

Mit `mount -a` _("all")_ kann man dann alle Dateisysteme, die in `/etc/fstab` vermerkt sind, automatisch einhängen lassen (sonst passiert das stets beim Neustart)!

== F.2~~~ Aufgabe: Automatisches Montieren/Einhängen
#v(2mm)

#count[Machen Sie eine Sicherheitskopie von `/etc/fstab` auf `/etc/fstab.org` (_Tipp:_ `cp -p`)]

_Hinweis:_ Profi-Administratoren editieren Dateien mit einem Editor direkt aus der Konsole (Terminal) und verwenden dazu den mächtigen Editor _vi_ (gesprochen „wie-ei)“, der bei den allermeisten Distributionen vorinstalliert ist. Falls Sie noch nicht im Rahmen der Laborübung _Linux Text Editoren_ mit _vi_ beschäftigt haben, empfehlen wir alternativ den Editor _nano_, der in den unteren beiden Bildschirmzeilen eine Zusammenfassung der Steuerkommandos anzeigt (\^ bedeutet die Taste Strg).

#count[Fügen Sie mit dem Editor `nano` oder `vi` zwei Zeilen an `/etc/fstab` an, die dafür sorgen, dass die beiden neuen Dateisysteme (auf Partition 1 und 2 der zweiten Festplatte) automatisch richtig eingehängt werden! 
_Welche sind das?_]

#count[Testen Sie mit `mount -a` und dann folgend `df -h`, ob der `/etc/fstab`-Eintrag korrekt funktioniert _(falls nicht → Troubleshooting)_! Was bedeutet die Option `-a` beim `mount`-Befehl 

__SSMOODLE__]

#count[Starten Sie ein letztes Mal die VM neu und überprüfen Sie graphisch mit dem Datei-Browser (wie Windows-Explorer) und auf der Kommandozeile _(wie?)_, ob das automatische Montieren jetzt klappt!]

#count[_____BONUSFACHSCHULE_____  Was passiert eigentlich, wenn man ein Dateisystem in einen _nicht-leeren_ Ordner einhängt (mit den dort vorhandenen Dateien und Unterordnern) … und dann wieder aushängt _(ausprobieren!)_?]

== F.3~~~ Bonus-Recherche
#v(2mm)

#count[#link("https://wiki.ubuntuusers.de/fstab/", [Recherchieren]) Sie: Was genau bedeuten die beiden letzten Spalten der `/etc/fstab`_-_Einträge _(die wir frisch-fröhlich auf `0` gesetzt haben)_?]

== G~~~ Bonus-Aufgabe: SMB/CIFS
#v(2mm)

Microsoft verwendet für Dateifreigaben das SMB-Protokoll, auch _Common Internet File System_ (_CIFS_) genannt, welches praktischerweise auch vom Linux-Kernel unterstützt wird. Als krönenden Abschluss wollen wir nun eine Windows-Freigabe in den Linux-Dateibaum montieren.

#count[Verbinden Sie eine Windows 10 Client VM mit dem Intranet (also Network-Connection = bridged) und starten Sie den Rechner]

#count[Melden Sie sich z.B. unter einem (Standard-) Benutzer `Alfred` (Password: `alfred`) an, erstellen im Home-Verzeichnis einen Ordner namens "geheim" und legen Sie darin eine Textdatei an, in die Sie eine interessante Nachricht hineinschreiben.]

#count[Nun geben Sie den Ordner frei (RK auf Ordner / Freigabe / Erweiterte Freigabe). Als Freigabename wählen Sie _geheim_ und geben dem Benutzer Alfred Vollzugriff-Rechte (Wie?)]

#count[Wie kann man alle Freigaben auf dem Windows-System warten (=anzeigen, ändern, etc.)? _Hinweis:_ Übung MMC!]

#count[Auf der Windows-Kommandozeile können Sie mittels

    ```
    net use x: \\IP-Adresse\share
    ```

    eine Netzwerkfreigabe einem Laufwerksbuchstaben zuweisen.

- Was ist eine UNC-Adresse?

- Wie weisen Sie auf der Windows-Kommandozeile dem Laufwerksbuchstaben `G:` Ihre soeben angelegte Freigabe zu? (Bitte auch testen)

- Wie beenden Sie die Zuweisung des Laufwerksbuchstaben auf der Kommandozeile?]

#count[Linux
- Erstellen Sie im Ordner `/mnt` das Verzeichnis `alfred`

- Montieren Sie nun darin Ihre Windows Freigabe mit

    `mount -t cifs ` ```_//IP-Adresse`/share /mnt/alfred  -o user=`*Windows-Loginname_```

- vollständiger Befehl ins Protokoll -- wonach werden Sie nun gefragt?

- Testen Sie nun die Freigabe, indem Sie
		-
    die zuvor erstellte Datei auf dem Linux-System auslesen
		- am Linux-Rechner eine neue Datei erstellen, die Sie anschließend auf dem Windows-Rechner bearbeiten

- Zeigen Sie Ihrem Betreuer, wie Sie Dateien zwischen Linux und Windows austauschen und freuen Sie sich, dass Ihre gute Mitarbeit nicht unbemerkt bleibt. ;-)]

_Viel Spaß!_
