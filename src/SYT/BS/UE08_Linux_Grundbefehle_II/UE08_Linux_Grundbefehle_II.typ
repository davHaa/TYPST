#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5,count6; 
#show: template 

#let filename = "08_Linux_Grundbefehle II";


#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ Shell, Wildcards und bedingte Verkettung von Befehlen
#v(2mm)

_Wichtig_: Bitte nicht nur die *Fragen beantworten*, sondern auch unbedingt *alle* verwendeten *Befehlszeilen* und (falls gefragt) *Ausgaben* im Protokoll angeben! Bei Schwierigkeiten bitte nicht ewig experimentieren oder abwarten, sondern Nachbarn oder Laborbetreuer fragen!

#count[Melden Sie sich am System (Kali-Linux VM) mit dem Benutzer `junioradmin` an (an der WSL mit Ihrem User).]

#count[Wechseln Sie in das Verzeichnis `/etc`]

#count6[ Zeigen Sie folgende Dateien (bzw. Ordner – aber nur den Ordner-Namen, nicht den Inhalt des jeweiligen Ordners - _Tipp:_ `-d`) an _(wie?)_:

+ Alle Dateien und Verzeichnisse mit genau `3` Zeichen Länge
+ Dateien und Ordner, deren drittletzter Buchstabe ein `r` ist
+ Dateien und Ordner, deren `3.` Buchstabe ein `p` ist _(wenn nicht vorhanden, mit `g` versuchen)_
+ Dateien und Ordner, deren `3.` Buchstabe ein `p` ist _(wenn nicht vorhanden, mit `g`)_, und deren Namenslänge größer als `3` ist
+ Dateien und Ordner, deren `3.` Buchstabe ein `p` ist _(wenn nicht vorhanden, mit `g`)_, und deren Namenslänge exakt `3` ist]

#count[Wie geben Sie alle Zeilen der Datei `/etc/passwd` aus, in denen die Zeichenkette „`root`“ vorkommt? (Hinweis: `grep`)]

#count[Erweitern Sie nun Ihre Suchabfrage: Falls in der Datei `/etc/passwd` die Zeichenkette „`root`“ vorkommt, geben Sie  nach der Ausgabe von `grep` die Wörter „`SEARCH FINISHED`“ aus (verwenden Sie _eine_ Befehlszeile mit bedingter Befehlsverkettung bei Erfolg).]

#count[Wiederholen Sie die Suche nun *ohne* Anzeige der Fundstellen (Option: „still“) und geben Sie nur dann „`__JUCHHEISSA__`“ aus, wenn die gesuchte Zeichenkette auftritt (Gegenkontrolle: Suchen Sie nach „`batman`“)!]

#count[Zusätzlich soll zum obigen Beispiel „`__ZEFIX__`“ ausgegeben werden (also wenn es keine Fundstellen gibt), indem Sie die Verkettung der Befehle mit einem weiteren Verkettungs-Operator erweitern (= bedingte Verkettung bei Misserfolg).]

== B~~~ _History_ und _Completion_
#v(2mm)

#count[Lassen Sie sich eine Liste der bisher ausgeführten Befehle anzeigen  -- man nennt das 
    auch die _command line_ `history` --
    _(wie machen Sie das also?)_, finden Sie die Befehlsnummer des Beispiels d) oben heraus,
    und wiederholen Sie den Befehl über die Eingabe seiner Nummer
    _(wie? - Tipp: !...)_.]

#count[Wiederholen Sie den letzten Befehl aus der _History_.]

#count[Suchen Sie in den eingegebenen Befehlen _(History)_ rückwärts _(Tipp: Strg-r)_ nach `?p` oder `?g`  --
    welchen Befehl finden Sie?]

#count[Tipp: fügen Sie komplexeren Befehlen, die Sie oft wiederverwenden, einen Kommentar hinzu -- etwa so: 
	
 - `cat /etc/services #1`
 - `grep service /etc/services | sort |wc -l #2`
	
	Was machen diese Befehle? 
	Wie suchen Sie den Befehl mit `#1` am einfachsten wieder rückwärts?]

#count6[Schreiben Sie den (Teil)Befehl

    ```bash
    cat /etc/pa
    ```

+ Was passiert wenn Sie die Tabulator-Taste (mehrmals) drücken?
+ Schreiben Sie weiter (`cat /etc/pas`) und dann die Tabulator-Taste (mehrmals) drücken?
+ Funktioniert das auch für Befehle (`c` Tab Tab)?]

#count[Noch bessere Ergänzungen (auch für Optionen) bringt das Paket `bash-completion` (ggf. nachinstallieren)

    ```bash
    sudo apt install bash-completion
    ```

	oder gleich als Superuser:
	```bash
   su
	  apt install bash-completion
	  exit
    ```
	
    Was wird jetzt z.B. nach `ls -` (Tab Tab) ergänzt? Vorher das Terminal schließen und erneut öffnen!]

== C~~~ Ausgabe von Dateiinhalten/ Umleitung der Ein-/Ausgabe
#v(2mm)

#count[Zeigen Sie mit `cat` den Inhalt der Dateien `/etc/passwd` und
    `/etc/services` an – wie machen Sie das jeweils? Verwenden Sie
    anschließend statt `cat` die Befehle `more` und dann `less` zum
    Betrachten der Datei `/etc/services`. Welche Unterschiede stellen
    Sie zwischen diesen drei Befehlen fest? (*Hinweis:* _verwenden Sie ein Terminal mit 24 x 80 Zeichen_).]

#count[Lassen Sie sich den Inhalt des Verzeichnisses `/etc` _seitenweise_
    unter Zuhilfenahme von `more`, dann mit `less` ausgeben _(Tipp: Pipe: befehlszeile1 | befehlszeile2)_! Worin 
	unterscheiden sich diese beiden Befehle?]

#count[Finden Sie mit den `man`-Pages heraus, welche Funktion die
    Befehle `head` und `tail` (grundsätzlich) haben!]

#count6[Arbeiten mit `head` und `tail`:
+ Lassen Sie sich die ersten 8 Zeilen der Datei `/etc/services`
        anzeigen!
+ Lassen Sie sich die letzten 5 Zeilen des _System-Logs_ (`/var/log/syslog`) ausgeben (WSL: z.B. `/var/log/apt/term.log` )
+ Lassen Sie sich die letzten 15 Zeilen der _Kernel-Meldungen_ (`/var/log/kern.log` bzw., falls leer, `/var/log/kern.log.1`) ausgeben _(nur bei VM)_!
+ Welche der Dateien unter `/var/log/` sind eigentlich Text-Dateien (also mit direkt in der Konsole lesbar -- _Tipp: `file *`_)
+ Lassen Sie sich die letzten 6 Zeilen _der zuletzt geänderten Protokolldatei_, die als "ASCII Text" gespeichert wird, aus `/var/log` anzeigen. (*Hinweis* _Sie dürfen dazu den Namen der Datei zuerst mit einer eigenen Befehlszeile feststellen_).]

#count6[Arbeiten mit Umlenkung der Ausgabe und Wildcards:
+ Erzeugen Sie mit den Befehlszeilen

        ```bash
        echo Use > Datei1
        echo Study > Datei2
        echo Share > Datei3
        ...
        ```
        vier (4) Dateien in Ihrem _Home-Directory_(_Benutzerverzeichnis_, also `~`).

+ Lassen Sie sich nun nur jene Dateien in Ihrem Benutzerverzeichnis mit `ls` anzeigen, deren Dateinamen mit der Zeichenfolge `Dat` beginnen.

+ Zeigen Sie den _Inhalt_ all dieser Dateien mit _einem_ Befehl an(„zusammengehängt“ = _con*`cat`*enated_) auf der Konsole an!]

#count[Statt das Ergebnis auf der Konsole auszugeben, erzeugen Sie mit `cat` nun eine Datei `AllesZusammen`, die (wie zuvor)
    die Inhalte aller Dateien enthält, die mit der Zeichenfolge `Dat` beginnen.]

#count[Suchen Sie nach der Zeichenkette `log` in `/etc/passwd` und
speichern Sie die Fundstellen in der Datei `~/log.fundstellen`.

SSMOODLE]

#count[Suche Sie alle Vorkommen von `junioradmin` in den Dateien `/etc/*` -- die vielen
     Fehlermeldungen wollen Sie nicht sehen, leiten Sie deshalb die Fehlerausgabe
     mit `... 2> /dev/null` in den digitalen Papierkorb um.]

#count[(*Bonus*: Heavy – erst nach dem letzten Punkt machen!)

    Zählen Sie mit `wc` die
    Anzahl der Zeichen (sonst nichts) in `~/log.fundstellen` und hängen
    Sie das Ergebnis _n_ im Format „`--- enthält n Zeichen`“)
    _wieder_ an die Datei an. _Tipp_: `man wc` für die richtige Option!]

== D~~~ Bonus: Hard- und Softlinks

#count[Die Verzeichnisbäume 

- `~/Uebungsverzeichnis__YY___Vorname` _(Ihr Vorname ist gemein und_

- `~/Uebungsverzeichnis__YYYY__` // YYYY Einfügen funktioniert nicht steht als 2525 da

aus der letzten Übung sollten noch vorhanden sein -- wenn nicht, erzeugen Sie diese einfach noch einmal _(siehe letzte Laborübung -- in der Shell, nicht im GUI ;-)_!]

#count6[Arbeiten mit symbolischen Links _(nicht vergessen, alle verwendeten Kommandozeilen anzugeben -- wie bisher)_:

+ Erzeugen Sie einen _symbolischen Link_ (_Softlink_) mit dem Namen `Link_Vorname` (Vorname ist Ihr Vorname, im selben Ordner wie das Original -- das sollte also `~` sein), der auf `UebungsVerzeichnis_Vorname` verweist. Prüfen Sie das Ergebnis mit `ls -lR` -- sind alle Dateien unter dem Softlink erreichbar?

+ Detto mit `Link2`, dieser soll auf `Uebungsverzeichnis__YYYY__` verweisen.

+ Woran erkennen Sie im Datei-Listing (mittels `ls -l`), ob es sich um einen symbolischen Link (Softlink) handelt?

+ Testen Sie, was passiert, wenn Sie nun `Uebungsverzeichnis__YYYY__` komplett entfernen _(mit welchem Befehl?)_! 
    - Ist der Link noch vorhanden _(Listing machen!)_?

    - Funktioniert er? 

+ Was passiert, wenn Sie versuchen, einen symbolischen Link auf eine nicht-existente Datei oder ein nicht-existentes Verzeichnis zu erstellen (_ausprobieren – geben Sie die Befehlszeilen an!_)?

+ Erzeugen Sie nun eine Datei samt Inhalt namens `Datei__YY__` mit der Befehlszeile

        ```bash
        echo Inhalt für Datei__YY__ > Datei__YY__
        ```
+ Jetzt wollen wir (normale) Verzeichniseinträge (Namen) für Dateien erzeugen, sogenannte _Hardlinks_: Erstellen Sie einen _Hardlink_ von `Datei__YY__` namens `__NEUEDATEI__`!

+ Jede Datei unter Linux hat ein sogenannte _Inode-Nummer_, die diese eindeutig identifiziert (unabhängig von dem Namen/Ort der Datei).
    - Betrachten Sie die _Inode_-Nummern von `Datei__YY__` und `__NEUEDATEI__` (mittels `ls -li`) – was fällt Ihnen auf?
    - Was bedeutet die Zahl „2“ in der 3. Spalte des Listings mit `ls -li`?

+ Verändern Sie `__NEUEDATEI__` mit

        ```bash
        echo Neuer Dateiinhalt für __NEUEDATEI__ > __NEUEDATEI__
        ```
        Betrachten Sie nun den Inhalt von `Datei__YY__`. Was ist passiert?

+ Löschen Sie die ursprüngliche `Datei__YY__` und betrachten Sie erneut den Inhalt von `__NEUEDATEI__`: Welchen "Unterschied im Verhalten" (beim verbleibenden Hardlink) stellen Sie gegenüber der Verwendung eines Softlinks (symbolischer Link -- siehe zuvor) fest?
+ Versuchen Sie, einen _Hardlink_ für ein _Verzeichnis_ (etwa `~/Uebungsverzeichnis__YYYY__`) zu erstellen -- was stellen Sie fest?]

