#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
#show: template 

#let filename = "13_Linux-Editor";



#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

= A~~~ Einführung
#v(2mm)

Das wahrscheinlich am häufigsten gebrauchte Tool bei der Linux-Systemadministration ist ein Editor zum Bearbeiten von Dateien -- typischerweise macht man das von Kommandozeile aus (also in der Shell, häufig über eine SSH-Verbindung). Unter Linux gibt es zahlreiche Editoren: Vom zeilenorientierten `ed` über `vi`, dem UNIX-Standardeditor bzw.  dessen Erweiterung `vim`, bis zu `emacs`.

Die Wahl eines, des "besten" oder des "richtigen" Editors kann zu erbitterten Debatten führen. 

#figure(
  image("real_programmers.png", width: 80%),
  caption: [
    #link("https://xkcd.com/378/ CC BY-NC 2.5")
  ],
)

Zusätzlich bringen die grafischen Oberflächen #link("https://www.kde.org/", [KDE]) und #link("https://www.gnome.org/", [GNOME]) eigene Editoren mit. Automatisiertes d.h. programmgesteurtes Editieren ist übrigens mit dem _Stream-Editor_ `sed` aber auch mit `emacs` oder `vi` möglich.

Wir wollen die grundlegende Bedienung einiger Editoren kennenlernen -- schließlich sind das wesentliche _Survival Skills_ der IT-Spezialisten!

= B~~~ Übungsablauf
#v(2mm)
In dieser Übung befassen Sie sich mit den ersten beiden der drei vorgestellten Editoren näher, nämlich dem `nano` sowie dem `vi` _(Sie können sich natürlich auch alle 3 anschauen ;-)_. Bei beiden Editoren sollten Sie:

- die Einführung durchlesen und, so vorhanden, das Tutorial durcharbeiten, dann

- die "Fragen" zum Editor beantworten sowie

- mit einem Editor Ihrer Wahl die _Editieraufgabe_ durchführen!

= C~~~ nano
#v(2mm)
`nano` ist - wie `vi` - auch bei vielen Distributionen vorinstalliert und zeichnet sich durch sehr einfache Benutzbarkeit aus. Er wurde ursprünglich als Klon des anfangs nicht-freien Editors `pico` entwickelt. Fortgeschrittene Funktionen und Features  wie in `vi` oder gar `emacs` sind aber mit `nano` manchmal schwieriger oder gar nicht vorhanden.

== C.1~~~ Tutorial/Einführung (`nano`)
#v(2mm)
Sie finden die allerwichtigsten Befehle im _Editor Survival Guide_.

Ausführlichere Informationen schlagen Sie im Internet nach -- wie beispielsweise unter:

- #link("https://wiki.ubuntuusers.de/Nano")
- #link("https://wiki.gentoo.org/wiki/Nano")

== C.2~~~ Fragen (`nano`)
#v(2mm)
#count[Kopieren Sie eine längere Datei auf der Kommandozeile in Ihr Heimatverzeichnis, etwa `/etc/services` und öffnen Sie diese mit dem Editor.]

Beantworten Sie (z.B. unter Verwendung des _Editor Survival Guide_, der Online-Hilfe im Editor oder durch Web-Recherche) dann - mit Ausprobieren - die Fragen:

#count[Welche Tastenkombination beendet `nano`?]

#count[Wie bewegt man sich eine Seite vor und zurück? Kann man mit einem Befehl 5 Seiten vorwärts springen?#footnote[Achtung: nicht jeder Editor kann alles ;-)]]

#count[ Wie kommt man zum Ende der Datei bzw. wieder zurück zum Anfang?]

#count[Wie löscht man eine Zeile und fügt Sie (woanders) wieder ein?]

#count[Wie macht man einen Schritt rückgängig?]

#count[Wie speichert man eine Datei?]

#count[Wie sucht man nach einem Text?
- Suche / weitersuchen
- Suche / weitersuchen mit RegEx]

#count[Wie ersetzt man einen Text durch einen anderen Text?]

#count[Wie öffnet man eine weitere Datei?]

#count[Wie zeigt man alle Dateien in einem Ordner an und öffnet eine davon?]

= D~~~ `vi`
#v(2mm)

`vi`#footnote[`vi` steht für "visual" -- Der Name erinnert daran, wie bahnbrechend innovativ der Editor zum Zeitpunkt seiner Programmierung war] ist ein text-basierter _Full Screen_-Editor, der Teil des #link("http://pubs.opengroup.org/onlinepubs/9699919799/", [_POSIX_])-Standards ist und daher auf praktisch allen UNIX-ähnlichen Systemen, insbesondere auch Linux in der Regel _vorinstalliert_ ist. Daher sollte man zumindest Grundkenntnisse der Bedienung kennen, um im Notfall z.B. eine kleine Änderung der Systemkonfiguration in einer Konfigurationsdatei vornehmen zu können.

Die Besonderheit des `vi`-Editors (die anfangs gelernt werden muss) ist, dass er zwei "Betriebsarten" kennt:

1. Befehlsmodus (mit `<Esc>`)
2. Eingabemodus (mit `i`, `I`, `a`, `o`, `O` ...)

Im _Befehlsmodus_ kann man navigieren (sich in der Datei frei bewegen), löschen, abspeichern und dergleichen. Um Text einzugeben oder zu überschreiben, muss man in den _Eingabemodus_ wechseln, was man z.B. mit '`i`' (für _insert_) machen kann. Nach Eingabe/Änderung des Textes wechselt man stets mit der `<ESC>`-Taste _(Escape)_ wieder in den Befehlsmodus.

Das ist anfangs etwas ungewohnt, nach einigem Arbeiten tippt man aber "automatisch" nach Ende jeder Eingabe/Änderung die  `<ESC>`-Taste, um wieder in den Befehlsmodus zu wechseln (um dann z.B. woanders hin zu navigieren).

Genau genommen gibt es auch einen _dritten_ Modus, den `ex`-Modus, der einen sehr mächtigen Zeileneditor (namens `ex`) integriert . Alle Befehle, die mit `:` beginnen, werden der `ex`-Kommandozeile übergeben. Dies erfolgt in der Praxis direkt über `:` aus dem Befehlsmodus und ist daher kein Zusatzaufwand. So kann man beispielsweise mit `:w` _(write)_ die Datei abspeichern und mit `:q!` _(quit unconditionally)_ den Editor ohne Änderungen verlassen.

== D.1~~~ Tutorial/Einführung (`vi`)
#v(2mm)

#count[Arbeiten Sie das Online-Tutorial durch: #link("http://www.openvim.com")!]

== D.2~~~ Fragen (`vi`)
#v(2mm)

#count[Kopieren Sie eine längere Datei in Ihr Heimatverzeichnis, etwa `/etc/services` und öffnen Sie diese mit dem Editor.]

Beantworten Sie (z.B. unter Verwendung des _Editor Survival Guide_, der Online-Hilfe im Editor oder durch Web-Recherche) dann - mit Ausprobieren - die Fragen:

#count[Welche Tastenkombination beendet `vi`?]

#count[Wie bewegt man sich eine Seite vor und zurück? Und 5 Zeilen?]

#count[Wie kommt man zum Ende der Datei bzw. wieder zurück zum Anfang?]

#count[Wie löscht man eine Zeile und fügt Sie (woanders) wieder ein?]

#count[Wie macht man einen Schritt rückgängig?]

#count[Wie speichert man eine Datei?]

#count[Wie sucht man nach einem Text?
- Suche / weitersuchen
- Suche / weitersuchen mit RegEx]

#count[Wie ersetzt man einen Text durch einen anderen Text?]

== D.3~~~ `vi` für Fortgeschrittene
#v(2mm)

#count[Was bewirkt -- im Befehlsmodus -- der Befehl `~` _(Tilde)_, wenn man ihn über Text (auch mehrfach) ausführt?]

#count[Wie kann man die aktuelle Zeile (kann auch leer sein) mit der Ausgabe eines Befehls (z.B. dem aktuellem Datum von `date`) ersetzen?]

#count[Wie kann man alle Zeichen von der aktuellen Cursor-Position bis zum Zeilenende _löschen_ und woanders einfügen?]

#count[Wie kann man die nächsten 3 Wörter löschen (oder nur kopieren) und woanders einfügen?]

#count[_Bonus:_ Wie öffnet man eine weitere Datei (in einem neuen #link("https://www.cyberciti.biz/faq/howto-switch-between-multiple-files-in-unix-linux-vim-editor/", [Dateipuffer]))?]

#count[_Bonus_ Wie #link("http://vim.wikia.com/wiki/File_explorer", [zeigt man alle Dateien in einem Ordner]) und öffnet eine davon?]

= E~~~ Editieraufgabe
#v(2mm)

_Wichtig:_ Führen Sie diese Aufgabe erst durch, _nachdem_ Sie sich mit zumindest den beiden Editoren `nano` und `vi` vertraut gemacht haben und deren Fragen  durchgearbeitet haben! 

Wählen Sie einen Editor aus (Vollprofis können auch den `Emacs` verwenden -- siehe unten -- verwenden), mit dem Sie folgende poetische Aufgabe erfüllen:

#count[Mit welchem Editor möchten Sie die Aufgaben erledigen?]

#count[Sie erhalten eine - leider ein klein wenig
verwürfelte Version des Gedichts "Der Zauberlehrling" - die auch noch ein paar Tippfehler enthält - von Johann Wolfgang von Goethe (Datei: `zauberlehrling.txt`).  Bringen Sie das Gedicht in seine ursprüngliche Form (_Tipp:_ Es sind nur 2 Absätze am falschen Platz), und korrigieren Sie die paar Tippfehler!]

#count[Realisieren Sie eine IT/Netzwerktechnik-relevante _Modernisierung_ des Zauberlehrings (inklusive Einrückungen).  
Als _Vorlage_ bekommen Sie von Ihrem freundlichen Betreuer eine Hardcopy zur Verfügung gestellt bzw. verwenden die 
beigefügte Datei `netzwerkmeister.png` bzw. `netzwerkmeister.pdf` (und Sie haben gerade kein OCR#footnote[*O* ptical *C* haracter  *R* ecognition extrahiert Text aus Bilddateien] zur Hand - bitte nicht einfach scannen!). Verwenden Sie alle Ihre Editor-Zauberkünste, um Ihren Text an den Inhalt der Hardcopy anzupassen _(Ergebnis mit kleinem Monospace-Font ins Protokoll!)_!]

= F~~ *Bonus:* Emacs 
#v(2mm)

== F.1~~ Über Emacs 
#v(2mm)

Dieser Editor ist ein mächtiges Werkzeug, die Bezeichnung Editor ist für diese Arbeitsumgebung fast eine Untertreibung. Es ist ein sehr umfangreiches Programm mit den wahrscheinlich meisten Features eines einzelnen UNIX-Programms.

Emacs basiert auf einer eigenen Programmiersprache (Lisp bzw. Emacs-Lisp) für Erweiterungen und Makros (die meisten Pakete des Emacs sind in dieser Sprache geschrieben).

Es können beliebig viele Dateien gleichzeitig bearbeitet werden. Neben den 
Funktionen zum Bearbeiten von Texten (Einfügen, Kopieren, etc.) gibt es eine 
Undo Funktion (beliebig weit), inkrementelles Suchen (Suchergebnisse werden 
während der Eingabe des Suchbegriffs angezeigt), Autosave und Menüs.

Die enthaltenen Erweiterungen decken fast alle Bereiche ab: z.B. Programme 
schreiben, übersetzen und testen (wie eine integrierte Entwicklungsumgebung), 
alle Arten der Kommunikation (Mail, News, WWW) sind am Textschirm und unter X 
Windows möglich. Für sehr viele Arbeiten gibt es spezielle Unterstützung (so 
genannte Modes), z.B. je ein Mode für die gängigen Programmiersprachen 
(einrücken, farbige Darstellung der Schlüsselwörter etc.), HTML Mode zum 
Gestalten von WWW-Dokumenten usw.

Häufig verwendete Kommandos sind durch "*shortcuts*" (eine Kombination der 
Tasten ~#my_box([Meta])[],~~ ~#my_box([Crtl])[]~ und einer weiteren Taste) abrufbar. 

Alles in allem: Es gibt fast nichts, was Emacs nicht kann.

Diese Funktionalität hat auch ihren Preis: Emacs braucht viel Speicher (bei der Installation und bei der Ausführung) und ist für den “Emacs-Neuling” durch die vielen Möglichkeiten eher entmutigend.

== F.2~~ Bearbeiten
#v(2mm)

Der angezeigte Schirm ist in drei Teile geteilt: den Buffer zum Bearbeiten der Datei, eine Statuszeile und die unterste Zeile zur Eingabe von Kommandos und zur Anzeige von Meldungen.

Die Bewegung des Cursors geschieht am einfachsten durch die Cursortasten.

Außerdem können alle Kommandos in der untersten Zeile direkt eingeben werden:
durch Eingabe von M-x (M steht dabei für ~~#my_box([Meta])[]~ -- falls sie keine solche 
Taste auf der Tastatur finden, kann dies entweder durch vorheriges Drücken der ~#my_box([ESC])[]~ oder gleichzeitiges Drücken der ~#my_box([ALT])[]~ Taste ersetzt werden, d.h. 
~#my_box([ESC])[]~~~~#my_box([X])[]~~ oder ~~#my_box([ALT])[]~ -- ~#my_box([X])[]~ und Eingabe des Kommandonamens. 
Bei vielen Eingaben funktionieren die ~#my_box([TAB])[]~~ Taste zur Ergänzung und die 
Cursortasten zur Auswahl der vorigen Eingaben (Commandhistory).

Beispiel:

Öffnen einer Datei: M-x find-file. Man kann aber auch C-x C-f 
(~~#my_box([Crtl])[]~~~ - ~~#my_box([X])[]~~ gefolgt von ~#my_box([Crtl])[]~ -- ~~#my_box([F])[]~~) verwenden.

Die Taste C-g bricht jedes Kommando ab.

Die zweite Zeile von unten ist die so genannte Modeline (Statuszeile). Dort findet man Informationen über die aktuelle Datei, den für die Bearbeitung der Datei gewählten Modus usw.

Beispiel:
```
--**- main.C  Top L2 (C++)--
```

`**` die Datei wurde geändert (%% wenn die Datei nur zum Lesen geöffnet 
ist)

`C++ ` ausgewählte Modi

`L2`  aktuelle Zeile

`TOP` Beginn der Datei

== F.3~~ Text löschen und verschieben
#v(2mm)

Das Markieren eines Bereiches (Region) geschieht entweder mit der Maus oder mit der Tastenkombination C-@ (oder C-Space) und bewegen des Cursors.

C-w löscht den Bereich, M-w kopiert den Bereich (ohne Löschen) -- der Text kommt 
dabei in den Kill-Ring (Zwischenablage mit beliebig vielen Einträgen). Mit dem 
Befehl C-y (yank) kann dieser Text an anderer Stelle eingefügt werden; mit M-y 
können dann alle bisherigen Einträge des Kill-Rings durchgegangen werden.

== F.4~~ Mehr als Dateien -- Modes
#v(2mm)

Der Editor erkennt aufgrund des Dateinamens den Dateityp. Damit können 
verschiedene Daten auch verschieden gehandhabt werden. Die unterschiedlichen 
Modi der Bearbeitung können auch durch Eingabe des entsprechenden Kommandos 
gestartet werden. Emacs unterscheidet dabei zwei Arten:

Major-Mode
: Dieser bestimmt die Art der Bearbeitung z.B. C-Mode, HTML-Mode 
etc. Es kann dabei immer nur einer dieser Modi aktiv sein.

Minor-Mode
: Dieser bestimmt zusätzliche Funktionalitäten bei der Bearbeitung, 
z.B. Overwrite Modus, Fontlock Modus etc. Diese Modi können beliebig miteinander 
und den Major Modi kombiniert werden.

Text
: Fast alle Programmiersprachen und Textbeschreibungssprachen 
(z.B. HTML, \TeX) werden erkannt und durch einen entsprechenden Major-Mode 
unterstützt: Es gibt spezielle Befehle zum Bearbeiten und Bewegen (z.B. gehe zum 
Ende der Funktion) und spezielle Menüs. Meist gibt es Kommandos zum schnellen 
Einfügen von oft gebrauchten Konstrukten.

Verzeichnisse
: Directory Editor (dired-mode): Bearbeiten des 
Verzeichnisses (Löschen, Umbenennen, Öffnen usw.)

tar (Archiv), ZIP Datei etc.
: Bearbeiten der enthaltenen Dateien 
ähnlich dem dired-mode.

mail
: Lesen und Schreiben von Email

compile
: Ein eigener Modus zum Compilieren eines Projekts. Durch die 
Auswertung der Fehlermeldung können die entsprechenden Fehlerstellen schnell 
angesprungen werden.

font-lock
: Farbige Darstellung der Schlüsselworte

== F.5~~ Hilfe
#v(2mm)

Mit der Eingabe von C-h kommt man in das Hilfesystem. 

 C-h C-h zeigt die Liste aller Möglichkeiten

 C-h t für den Anfänger gibt es auch eine kurze Einführung (Tutorial)

 C-h m beschreibt die derzeitigen Modi und die entsprechenden 
Tastenbelegung

 C-h a zeigt alle zu einem Begriff passenden Befehle

 M-x apropos erweiterte Suche nach einem Begriff

 C-h i startet man das Infosysteminfo, das außer dem Editor viele 
GNU-Programme beschreibt. Die Information zur Benutzung des Editors ist sehr 
umfangreich; sie entspricht dem gedruckten Benutzerhandbuch mit ca. 450 Seiten. 
Zusätzlich gibt es ein ca. 800-seitiges Programmierhandbuch

== F.6~~ Tutorial/Einführung (emacs)
#v(2mm)

#count[Starten Sie `emacs` -- eventuell muss dazu das (Meta-)Paket `emacs` nachinstalliert werden. 

    Man kann `emacs` als GUI-Programm verwenden oder nur in einem Terminal starten: `emacs -nw`]

#count[Wählen Sie das Tutorial und arbeiten Sie alle Schritte durch -- wobei die 
den letzten Teil ab "REKURSIVE EDITIER-EBENEN" überspringen können.]

== F.7~~ Fragen (Emacs)
#v(2mm)

#count[Kopieren Sie - falls noch nicht erfolgt - eine längere Datei in Ihr Heimatverzeichnis, 
etwa `/etc/services` und öffnen Sie diese mit dem Editor.]

Anschließend beantworten Sie die Fragen:

#count[Welche Tastenkombination beendet `emacs`?]

#count[Wie bewegt man sich eine Seite vor und zurück? Und 5 Zeilen?]

#count[Wie kommt man zum Ende der Datei bzw. wieder zurück zum Anfang?]

#count[Wie löscht man eine Zeile und fügt Sie (woanders) wieder ein?]

#count[Wie macht man einen Schritt rückgängig?]

#count[Wie speichert man eine Datei?]

#count[Wie sucht man nach einem Text? 
- Suche / weitersuchen / Inkrementelle Suche#footnote[d.h. Fundstellen werden schon während der Eingabe des Suchbegriffs angezeigt]
- Suche / weitersuchen / Inkrementelle Suche mit RegEx]

#count[Wie ersetzt man einen Text durch einen anderen Text?]

#count[Wie öffnet man eine weitere Datei?]

#count[Wie zeigt man alle Dateien in einem Ordner und öffnet eine davon?]

=== F.7.1~~ Emacs für Fortgeschrittene
#v(2mm)

#count[Was macht M-x kill-rectangle?]

#count[Was macht M-x grep-find?]

#count[Wann ist heute Sonnenaufgang? (Tipp: M-x calendar, C-h m, C-s sunset, oder direkt M-x sun...)
Was würde ein Maya heute sagen?
_Bonus:_ Wie kann man die für den Sonnenaufgang notwendigen Informationen dauerhaft speichern?]

#count[Im Buffer `_scratch_`: M-x picture-mode (Tipp: C-h m)]

#count[Was macht M-x hexl-find-file?]

#count[M-x tetris, M-x doctor, 
 #link("https://www.gnu.org/software/emacs/manual/html_node/emacs/Amusements.html")]

= G~~ *Superbonus:* `sed`
#v(2mm)

Das Programm sed ist ein (sehr mächtiger) Stream-EDitor. Es liest die Eingabedateien (oder die Standardeingabe) zeilenweise und 
führt entsprechende Veränderungen (Ersetzen, Umordnen mittels Hilfspuffern etc.) durch.
Anweisungen können für bestimmte Zeilen bzw. für gewisse Bereiche definiert werden. Sie können mit `sed` ganze Skripte mit Editier-Anweisungen schreiben!

Beispielhafte Befehle:

`d`
: löscht die Zeile (keine Ausgabe)

`s/alt/neu/opt`
: ersetzen des Musters 

    statt / ist jedes andere Sonderzeichen möglich. Die im Muster geklammerten 
    Ausdrucke, können beim Ersetzen durch \\1, \\2 usw. angesprochen werden

    Option g: eventuell mehrmals ersetzen

`y/set1/set2/`
: ersetze die Zeichen aus set1 durch das entsprechende
Zeichen in set2

`w datei`
: Ausgabe der Zeile in eine Datei

`h`
: Kopiert die aktuelle Zeile in einen Hilfsbreich

`x`
: vertauscht aktuelle Zeile und Hilfsbereich

Die Befehle können mit der Option -e (auch mehrmals möglich) direkt auf der Kommandozeile angegeben 
werden oder aus einer Datei gelesen werden.

Beispiel: Aus einer Datei sollen führende Zeilennummern entfernt werden:

```bash
sed -e ’s/^ *[0-9]*:\(.*\)/\1/’
```

== G.1~~ Tutorial/Einführung (sed)
#v(2mm)

Ein brauchbares #link("http://www.grymoire.com/Unix/Sed.html#uh-0", [Online-Tutorial]) findet sich z.B. unter #link("http://www.grymoire.com/Unix/Sed.html#uh-0")

== G.2~~ Aufgaben
#v(2mm)

#count[Ersetzen Sie #link("http://www.grymoire.com/Unix/Sed.html#toc-uh-26", [in der zweiten Zeile]) einer Datei alle `a` durch `A`]

#count[Wie kann man in einer Datei den Text `HTL` durch `Höhere Technische Lehranstalt` ersetzen (_Tipp:_ _in-place_ editieren mit `-i`)?]

#count[Alternative: auch mit `perl` kann man _in-place_ suchen/ersetzen.]
