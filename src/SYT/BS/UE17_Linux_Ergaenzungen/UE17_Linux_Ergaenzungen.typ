#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "17_Linux_Ergaenzungen";



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

In dieser Übung wollen wir zunächst einige Feinheiten von Linux kennen lernen. Anschließend untersuchen wir verschiedene Verfahren zum Archivieren und Komprimieren von Dateien.
Zuletzt untersuchen wir den Quellcode von Open-Source Dateien und lernen dabei den wichtigen Befehl _xargs_ kennen, mit dem wir die Standardeingabe in Befehle umwandeln können, um auf diese Weise z.B. viele Dateien gleichartig zu bearbeiten.

= B~~~ Plattform und Durchführung
#v(2mm)

Sie benötigen für diese Übung wieder ein Kali-Linux-System, auf dem Sie als Benutzer das Recht haben, Superuser-(_root)_-Privilegien (etwa
mittels *`sudo`*) zu erhalten. Am besten verwenden Sie eine der vorbereiteten virtuellen Maschinen -- dort ist es der User *junioradmin*, also mit *junioradmin* anmelden!

Dokumentieren Sie in Ihrem Protokoll _jede_ der verwendeten Befehlszeilen und die Ergebnisse! Hinweise:

- Viele Befehle sind im beiliegenden Pdf _Linux Essentials_#footnote[#link("https://www.bsinfo.eu/zus/lin") bzw. #link("https://www.bsinfo.eu/index.php/aus/zus/lin.html")] enthalten und erklärt.

- Bei Tuxcademy ehemals. Linup Front#footnote[#link("https://www.tuxcademy.org/media/basic/")] gibt es ebenfalls Unterlagen.

= C~~~ Wildcards
#v(2mm)

Was machen die folgenden Befehle? Was machen die einzelnen Befehle (im konkreten Fall), was passiert und warum? Bitte vorher überlegen und erst dann
ausführen.

#count[Start

    ```bash
    mkdir IhreEduvidualKennung && cd IhreEduvidualKennung
    ```]

#count[Im bei (1) erzeugten Ordner

    ```bash
    echo "xx__YY__xx" > x
    echo "yyyyyyyy" > y
    ls -al
    echo ist da wer ??
    echo ist da wer ?
    echo "ist da wer ?"
    ```]

#count[Trickreich -- geht / geht nicht!

    ``` bash
    cp *
    echo w > w
    cp *
    ```

    Tipp: bei den letzten `cp` Befehlen hilft vielleicht die Option `-v` oder
    `ls -al`.
]

#count[Trickreich -- weiterhin im Ordner von (1)

    ```bash
    touch cat
    *
    mkdir z
    cp *
    ```

    Warum gibt es eine Ausgabe? Welcher Befehl wird bei `*` ausgeführt? Und was wird kopiert?]

= D~~~ Archivieren und Komprimieren
#v(2mm)

== D.1~~~ Einleitung#footnote[basiert #link("http://le-easy.de/webquests.html")]
#v(2mm)

Thema dieser Aufgabe ist das Archivieren und Komprimieren von Dateien. Archivierung bedeutet, viele einzelne Dateien zu einer einzigen zusammen zu
fassen. Diese Datei kann dann noch komprimiert werden, d.h. die Datei nimmt gegenüber dem Original weniger Speicherplatz auf dem Speichermedium ein.

Unter Linux steht das Tool `tar` zur Archivierung und Tools wie `gzip`, `bzip2` und `zip` zur Komprimierung zur Verfügung.

== D.2~~~ Aufgabe

Ihr Klassenkamerad ist krank, und Sie möchten ihm deshalb einige Unterlagen aus dem Unterricht per Email zukommen lassen. Wir verwenden hier die SYT/BS-Übungen 0 bis 9 (außer 8, die ja auf Papier zu lösen war).

Um nicht alle Dateien einzeln an die Email anhängen zu müssen, erstellen Sie
ein *tar*-Archiv dieser Dateien.

Anschließend komprimieren Sie dieses Archiv, um es platzsparend verschicken
zu können.

Gehen Sie wie folgt vor:

#count[Laden Sie mit die Angaben für die Übungen 0 bis 9 mit Ihrem Web-Browser herunter#footnote[Leider funktioniert der Download von Sharepoint nicht mehr über die Kommandozeile.]!]

#count[Archivieren Sie die PDF-Dokumente mit `tar`. Siehe Pdf _Linux Essentials_.

- Wie groß ist die `tar`-Datei?

- Und wie groß waren die Original-Dateien (Summe)?

- Tipp: `du -sch` oder `du -scb` -- Was macht dieser Befehl?]

#count[Komprimieren Sie das Archiv: Benutzen Sie dazu verschiedene Methoden (`gzip`, `bzip2` und `zip`) und vergleichen Sie diese.

- absolute Größe und _Packzeit_  in einer Tabelle (Tabellenkalkulation)!

- Ergänzen Sie zwei (gerechnete) Spalten mit der relativen Größe in Prozent, bezogen auf ursprüngliche Größe und auf die kleinste Datei.

- Verwenden Sie `time` zum Messen der Programmlaufzeiten.]

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
    [*Methode*],
    [*Kommando*],
    [*Größe*],
    [*Rang-Größe*],
    [*Packzeit*], 
    [*Rang-Packzeit*],
    [*Entpackzeit*]
  ),
  [`gzip -9`],
  [`time gzip -9 ue.tar`], [x], [y], [z], [a], [b]
    )
  
  #count[Wie können Sie den Grad der Komprimierung beeinflussen? Ergänzen Sie die Tabelle entsprechend.]

  #count[Welches Archiv ist am kleinsten?]

  #count[Entpacken Sie die komprimierten Archive mit den verschiedenen Methoden.
  Ergänzen Sie die Tabelle um eine Spalte mit der _Entpackzeit_.]

  #count[Sind die einzelnen De-/Komprimierungsprogramme untereinander kompatibel?]

  #count[Bonus: Sie können auch noch `7z`, `lz4`, `lzma`, `xz` oder `rar` verwenden. Einige dieser Programme müssen Sie zuerst installieren.]

  #count[Welche Möglichkeiten bietet `tar` um gleich beim Erstellen des Archivs zu komprimieren?]

  #count[Zu vielen Kompressionsprogrammen gibt es auch die Varianten `...cat`, `...grep` und `...less` bzw. `...more`. Wozu dienen diese Programme?]

  #count[Ihr Schulkollege bittet Sie für die optimale Vorbereitung das Handout und den Fragenkatalog _Dateisysteme_  dem komprimierten Archiv hinzuzufügen. Erweitern Sie die bei (7) bereits erstellten Archive.]

  #count[Fügen Sie die fertige Tabelle hier ein.]

= E~~~ Suchen und Finden
#v(2mm)

= E.1~~~ Idee#footnote[basiert auf #link("http://le-easy.de/webquests.html")]
#v(2mm)

Da Sie sich für Open Source-Projekte interessieren und eventuell daran mitwirken wollen, entschließen Sie sich, den Quellcode eines solchen Projektes anzusehen.

Wir haben bereits `tar` verwendet, dessen Quellcode Sie sich nun herunterladen (_GNU Tar_).

Sie stellen fest, dass das Projekt aus sehr vielen einzelnen Dateien besteht. Um sich nun einen Überblick zu verschaffen, lassen Sie sich alle Quell- Dateien anzeigen, die auf `.c` enden. Anschließend sortieren Sie Ihr Suchergebnis alphabetisch.

Um einen Einstieg in den Quelltext zu haben, suchen Sie dann in den Inhalten der Quelldateien nach einer `main`-Methode.

= E.2~~~ Aufgabe

#count[Laden Sie sich den Quellcode der Software GNU-`tar` aus dem Internet herunter und entpacken das Archiv in Ihrem Home-Verzeichnis.]

#count[Welches ist die aktuelle Version von `tar`?]

Wechseln Sie in das Verzeichnis der entpackten Dateien und suchen Sie nach allen Dateien mit der Endung `.c` (auch in Unterverzeichnissen) auf folgende Arten:

#count[Benutzen Sie das Kommando `find` mit entsprechenden Optionen.]

#count[Benutzen Sie das Kommando `locate`.

Hinweise:

- Vielleicht müssen sie  `locate`  erst installieren und/oder die Datenbank *updaten*.

- Hier müssen Sie die Ausgabe von `locate` umlenken. Mit `grep` können Sie die Ausgabe filtern, so dass Sie nur Suchergebnisse aus dem `tar`-Ordner erhalten.]

Tipp: Verwenden Sie für die Ausgaben die Kommandos `less` und `more`, um alle Ergebnisse sehen zu können.

#count[Was ist der _wichtigste_ Unterschied zwischen `find` und `locate`? Welche Vor- und Nachteile ergeben sich daraus?]

#count[Um das Ergebnis zu sortieren, leiten Sie die Ausgabe Ihres `find`-Kommandos in eine Datei um. Den Inhalt dieser Datei können Sie dann mit `sort` sortieren. Alternative:  bzw. leiten Sie die Ausgabe mittels _pipe_ (`|`) weiter.

Optional: Es macht für die Sortierung Sinn, den Pfadnamen vor den Dateinamen zu entfernen. Dazu können Sie das Tool `basename` verwenden. Allerdings  verlangt dies eine geschickte Kombination mit `xargs`#footnote[http://www.pro-linux.de/artikel/2/901/xargs1-dein-freund-und-helfer.html]` -i`.]

#count[Um einen Einstieg in den Quellcode zu finden, suchen Sie die Main-Methode. Suchen Sie dazu nach Quelldateien, die im Namen die Zeichenkette `main` enthalten. Durchsuchen Sie den Inhalt der gefundenen Dateien mit `grep`, ob Sie die Initialisierungsmethode `main (int argc, char **argv)` enthält. In welcher Datei und in welcher Zeile wird die Funktion `main` definiert?

Tipps:
- `xargs`
- `grep` kann auch Zeilennummern ausgeben.
- Wie kann man nur nach dem Wort `main` am Zeilenanfang suchen aber nicht zB. `domain`?
]

#count[Geben Sie mit `head` die ersten 25 Zeilen mehrerer Quelldateien aus. Was ist dort immer zu finden?]

#count[Warum sollte man fast immer die Optionen `-print0` bei `find` und `-0` bei `xargs` verwenden? Hinweis: Siehe Handout zum Thema grep und find.]

_Viel Spaß!_