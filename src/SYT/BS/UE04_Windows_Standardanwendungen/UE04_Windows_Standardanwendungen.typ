#import "../resources/BS_Template.typ": create_page_template
#import "@preview/numbly:0.1.0": numbly

#let filename = "04_Windows_Standardanwendungen";

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)
#set enum( //Nummerierung 
  full: true,
  numbering: numbly("{1:(1)}", "{2:a})"),
)

= A Szenario -- Auftragsbeschreibung
Nach der Erstinstallation eine Windows-Client-Rechners wird man die von den Benutzern benötigten Anwendungsprogramme installieren und konfigurieren.

In diesem Szenario haben Sie von der Geschäftsführung den
Auftrag erhalten, für die Standardanwendungen (u.a. aus Sicherheitsüberlegungen) 
nach Möglichkeit nur Open Source Software einzusetzen _(siehe weiter unten)_.

Nach der Installation wird man die korrekte Funktion der Programme überprüfen sowie gegebenenfalls etwaigen Fehlermeldungen nachgehen – dazu ist eine Kontrolle über ein Programmablaufprotokoll hilfreich. Eine solche Überwachung ist auch angebracht, um verdächtigen Programmaktivitäten auf den Grund zu gehen ist – wir werden hierzu das Microsoft Tool 
_#link("https://technet.microsoft.com/de-de/sysinternals/processmonitor.aspx")[Process Monitor]_ einsetzen.

Ihr heutiges Protokoll sollte die vorgenommenen Schritte zur
Vorbereitung sowie Installation, Konfiguration und Überwachung der
Anwendungs-Software sowie die _Antworten auf alle gestellte Fragen_
enthalten!

= B Vorbereiten der VM
+ Legen Sie für diese Übung einen neuen virtuellen PC auf der
Basis der vorbereiteten Windows 11 Standardinstallation (als _Linked Clone_ ... Snapshot nicht vergessen) an!

= C Auswahl der Anwendungen
Bevor Sie mit der Installation beginnen können, werden Sie
erst einmal geeignete Anwendungen wählen und testen müssen. Der (etwas
steinige) Weg dieser Anwendungsauswahl wurde in unserem Szenario bereits vorgenommen. Im
Folgenden finden Sie eine beispielhafte Mini-Liste von Softwarepaketen
für Standardanwendungen, die den Anforderungen der Geschäftsführung
genügen (diese Liste ist natürlich in der Regel viel länger):

//Tabelle

*Achtung*: Wir werden *nicht* alle diese Anwendungen installieren, sondern nur *ein* Beispiel (nämlich Firefox)!

= D Systemvorbereitung
#set enum( //Nummerierung 
  full: true,
  start: 2,
  numbering: numbly("{1:(1)}", "{2:a})"),
)
+ _Sicherung:_ Erstellen Sie noch vor dem Start der VM zumindest
einen _VM-Snapshot_ -- für den Fall, das etwas mit der Installation schief
geht ... (in der Realität sollten Sie jetzt eine komplette
[Systemabbild-Sicherung](https://support.microsoft.com/de-de/windows/sichern-und-wiederherstellen-in-windows-352091d2-bb9d-3ea3-ed18-52ef2b88cbef) _(Image Copy)_ des Systems erstellen, zumindest jedoch einen Windows-_Wiederherstellungspunkt_).

Welchen (sinnvollen) Namen geben Sie Ihrem Snapshot?

= E Anwendungsinstallation
#set enum( //Nummerierung 
  full: true,
  start: 3,
  numbering: numbly("{1:(1)}", "{2:a})"),
)
+ _Installationsplanung_: Im Rahmen dieser Übung werden Sie sich beispielhaft
    auf eine einzige Anwendung konzentrieren: Den beliebten Open-Source-Browser
    _Mozilla Firefox_ in der neuesten, beschleunigten Version. Bevor so eine Software für den
    Produktiveinsatz installiert wird, sollte man einige Voraussetzungen für einen sicheren und legalen Betrieb überprüfen:

    (a) Informieren Sie sich auf der 
        Internetpräsenz von _#link("https://www.mozilla.org/de/firefox/faq/")[Mozilla Firefox]_ 
        _(Tipp: Die Hyperlinks anklicken!_) über:

        - Systemanforderungen? _#link("https://www.mozilla.org/en-US/firefox/93.0/system-requirements/")[(System Requirements)]_
        - Aktuelle, stabile Version? _#link("https://www.mozilla.org/en-US/firefox/93.0/releasenotes/")[(Release Notes)]_
        - #link("https://support.mozilla.org/de/kb/Firefox-unter-Windows-installieren")[Installationsprozess]?
        - (Lizenzbestimmungen - _siehe nächster Punkt!_)

    (b) Sofern -- bis auf die Lizenz-Details -- alle Fragen geklärt _(und dokumentiert)_ werden
	konnten, laden Sie die aktuelle Version des
	Installationsprogramms herunter!
        
        i)   Während des Downloads überprüfen Sie jetzt bitte die Lizenzbestimmungen: 
             Darf das Programm auch für kommerzielle Zwecke frei genutzt werden?
             (_Tipp:_ #link("https://www.mozilla.org/en-US/about/legal/eula/")[EULA] -> _Mozilla Public License 2_ -> _2.1 Grants_)?
        ii)  Was ist überhaupt ein(e) EULA? Welche Lizenz gilt für Firefox? _(Siehe zuvor!))_
        iii) Darf man überhaupt eine lokale Kopie z.B. am Schulserver anbieten? _(Tipp: #link("https://www.mozilla.org/en-US/MPL/2.0/FAQ/")[Mozilla Public License - FAQ -> Q6])_
     (c) Sodann installieren Sie _Firefox_ (am besten in der 64-Bit-Version) und machen ihn zu Ihrem Standard-Browser!

= F Programmüberwachung mit Process Monitor
_Programmablaufprotokoll:_ Wir wollen nun beispielhaft untersuchen, auf welche Windows-Ressourcen
die neu installierte Anwendung (hier: Firefox) zugreift. Man macht das etwa beim _Troubleshooting_, wenn man feststellen möchte, ob es evtl. Zugriffsprobleme (falsche Rechte) auf bestimmte Dateien oder gar die Windows-Registry gibt, oder z.B. wenn man vermutet, dass einzelne Programme selbstätig eine Netzwerkverbindung auf einen fremden Server durchführen und dabei unwerwünscht Daten übertragen.

Microsoft stellt für solche Zwecke unter `live.sysinternals.com` das _Windows-Sysinternals_-Tool _#link("https://technet.microsoft.com/de-de/sysinternals/processmonitor.aspx")[Process Monitor]_ (`Procmon.exe`)
bereit, das hilft, Zugriffe von laufenden Programmen (= Prozesse) auf das Dateisystem, auf die _Registry_ sowie auf das Netzwerk offenzulegen und eventuelle
Probleme zu erkennen. Auch kann man feststellen, ob das Programm eigenständig andere Programme startet. _Process Monitor_ protokolliert jede dieser Operationen und deckt dabei
z.B. fehlende Zugriffsrechte oder gar unerwünschte Zugriffsversuche bzw. Netzwerkaktivitäten auf.  Mit anderen Worten: Mit _Procmon_ können Sie recht gut feststellen, "was das Programm gerade macht"!

_Hinweis_: Falls _Process Monitor_ auf Ihrem Labor-Windows-System _nicht_  installiert ist, sollten Sie das Tool von #link("http://www.sysinternals.com")[Sysinternals] #link("https://docs.microsoft.com/de-de/sysinternals/downloads/procmon")[herunterladen] (ZIP-Datei in Ordner Ihrer Wahl auspacken, dann daraus einfach `Procmon.exe` aufrufen). 

Komfortabler ist die Installation im Terminal (mit Administratorrechten), indem man die Anwendung mit dem _Windows-Paket-Manager_ herunterladet:
```powershell
 winget source update
 winget install sysinternals 
 ```
 
Das Programm `winget` durchsucht Quellen wie den Microsoft Store nach der angegebenen Software, um sie herunterzuladen und zu installieren. 
Um die Paketdatenbank zu aktualisieren, verwendet man `winget source update`.
Zusätzlich kann man mit dem Paket-Manager auch Software wieder deinstallieren (Parameter `uninstall`) oder auf dem aktuellen Stand halten (Parameter `upgrade`).

== F.1 Tastenkünste
#set enum( //Nummerierung 
  full: true,
  start: 4,
  numbering: numbly("{1:(1)}", "{2:a})"),
)
+ Starten Sie `Procmon.exe` und beobachten Sie kurz die überwachten Operationen – mit welchem Tastaturkürzel kann man ...

    (a) Ein- und Ausschalten, ob der Bildschirminhalt laufend die neuesten Operationen anzeigt _(Autoscroll)_?

    (b) die Überwachung _(Capture)_ ausschalten, so dass keine Operationen mehr überwacht werden?

    (c) das aktuelle, am Bildschirm angezeigte Protokoll löschen?

    (d) die Überwachung wieder einschalten (Woran erkennt man in der Icon-Leiste, 
        ob überwacht wird oder nicht?)?

+ Wie kann man ...

    (a) nur Dateioperationen (Zugriffe auf das Dateisystem) *und* Registry-Zugriffe betrachten?

    (b) ausschließlich Netzwerkaktivitäten sehen?

+ Kann man auch die die übertragenen _Inhalte_ (Daten in den Netzwerkpaketen) der beobachteten Netzwerkaktivitäten betrachten?

+ Mit welchem Tastenkürzel (_Tipp: Tools → ..._) erhält man eine Übersicht über alle überwachten laufenden Programme (nennt man _Prozesse_)? Was bedeutet die Einrückung beim Programmnamen in dieser _Process Tree_-Darstellung?

== F.2 Nur mit Filter
#set enum( //Nummerierung 
  full: true,
  start: 8,
  numbering: numbly("{1:(1)}", "{2:a})"),
)
+ Starten Sie einen Firefox-Browser und verwenden Sie die "Zielscheibe", um ausschließlich den gerade sichtbaren
Firefox-Browser-Prozess zu überwachen!

+ Checken Sie die aktuellen Filter-Einstellungen:

    (a) Welches Tastenkürzel bringt Sie eigentlich rasch zu den Filter-Einstellungen?

    (a) Welche Filterregel (Tipp: Grün) sorgt nun dafür, dass nur Operationen des Firefox-Browsers überwacht werden?

    (a) Wie wird standardmäßig verhindert, dass auch die Aktivitäten von _Procmon_ selbst (`Procmon.exe`) angezeigt werden *(evtl. mit Screenshot zeigen)*?

    (a) Wie kann man die Filterregeln auf den Ausgangszustand (alles zeigen bis auf wenige sinnvolle Ausnahmen) zurückstellen?

== F.3 Big Brother
#set enum( //Nummerierung 
  full: true,
  start: 10,
  numbering: numbly("{1:(1)}", "{2:a})"),
)
+ Setzen Sie nun einen Filter, so dass nur Aktivitäten des Firefox-Browsers (_Process Name_ `firefox.exe`) dargestellt werden - wie lautet die neue Filterregel? Testen Sie die Regel (es sollten nur Firefox-Ereignisse sichtbar sein)!

+ Stoppen Sie die Überwachung, löschen Sie alle Ereignisse, beenden Sie Firefox und starten Sie wieder das Logging!

+ Starten Sie den Browser, gehen Sie auf eine vertraute Web-Seite. Nach ein paar Sekunden stoppen Sie das Logging _(Capture)_ wieder. 

    Jetzt werden wir die mitgeloggten Aktivitäten analysieren:

    a) _Process Activity:_ Welche Programme (bzw. wie oft) wurden offenbar nach dem Klicken auf das Firefox-Icon gestartet (_Tipp: Tools → Process Tree_)? Was fällt Ihnen auf? Wie lauten die tatsächlich aufgerufenen Kommandozeilen _(es reichen 2 Beispiele ;-)_?

    b) _Network Activity:_ Stellen Sie fest, mit welchen Netzwerkadressen sich der Firefox-Browser verbindet (_Tipp:_ Übersicht über _Tools → Network Summary_)! Screenshot ins Protokoll! Untersuchen Sie ein paar Adressen: Insbesondere die nicht über DNS aufgelösten Adressen sind von Interesse. Haben Sie vielleicht doch einen Trojaner entdeckt _(Tipp: #link("https://www.whois.com/whois/")[whois] bzw. #link("http://www.ip-tracker.org/")[IP Lookup])_?

    c) _File Activity I:_ Wie kann man überprüfen, welche Dateien Firefox beim Starten geöffnet hat
        _(tabellarische Übersicht)_? Wie viele verschiedene Dateien und Ordner waren das eigentlich *(screenshot!)*?

    d) _File Activity II:_ Unter welchem Ordner *(absoluter Pfad ins Protokoll!)* wird 
        offensichtlich die gesamte (wichtige) Benutzerprofilinformation des Browsers 
        _für diesen User_ (bei uns `junioradmin`) gespeichert? *Tipp:* Firefox kann mehrere `Profiles` für einen User verwalten...

    e) _Registry Activity:_ Stellen Sie fest, mittels welcher Registry-Einstellung Firefox nachfragt, 
        mit welcher Sprache -- etwa `en-US` -- auf dieser Maschine bevorzugt gearbeitet wird 
        (*Tipp:* Nach `Language` suchen, mit Strg-F immer weitersuchen bis `SUCCESS`)! 
        
        -> Kompletter Registry-Pfad `HKLM\...` oder `HKCU\...` ins Protokoll und den Zugriff mit 
        einem Procmon-Screenshot im Protokoll und/oder Eduvidual dokumentieren!

        _Bonus_: Wie kann man diese Information durch geschicktes Setzen der Filter zusammengefasst im _Registry Summary_ 
        erhalten *(Screenshot!)*?

== F.4 Gedächtniskünste
#set enum( //Nummerierung 
  full: true,
  start: 13,
  numbering: numbly("{1:(1)}", "{2:a})"),
)
+ Manchmal möchte man das beobachtete Geschehen festhalten und später genauer auswerten - wie kann man *(ausprobieren!)* ...

    (a) den aktuellen, am Bildschirm angezeigten Log löschen?

    (a) eine (früher) gespeicherte Log-Datei wieder einlesen?

    (a) den aktuellen Überwachungsinhalt in eine Log-Datei schreiben (Speichern Sie testweise den aktuellen Inhalt in eine Datei IhrVorname_xxxx_Datum.PML auf dem Desktop!)? xxxx=Ihre Login-Nummer. Öffnen Sie die Datei mit einem Doppelklick. Was können Sie jetzt damit machen? Fügen Sie einen Screenshot des gesamten Fensters (mit Titelzeile) im Protokoll ein.

= G Durchsicht der Autostart-Programme
#set enum( //Nummerierung 
  full: true,
  start: 14,
  numbering: numbly("{1:(1)}", "{2:a})"),
)
Was noch fehlt ist ein Untersuchung, ob die neu installierte Anwendung sich selbst oder andere Komponenten beim Hochfahren des Rechners oder beim Neuanmelden automatisch startet. Dazu bietet sich das _Windows-Sysinternals_-Tool _#link("https://technet.microsoft.com/de-de/sysinternals/autoruns.aspx")[Autoruns]_ (`Autoruns.exe`) an, das wirklich (fast) *alle* Möglichkeiten des Autostarts unter Windows erkennt (nicht nur den Weg über die `Run`-Einträge in der _Windows Registry_ aus der gleichnamigen Übung).

+ Starten Sie nach dem Entpacken _Autoruns_ und machen Sie sich mit der Darstellung vertraut *(Screenshot)* -- wie viele Einträge findet das Tool (so ca.)?

+ Suchen Sie alle Einträge der Mozilla Corporation (die Firefox entwickeln) - welche Firefox-relevanten Auto-Start-Einträge finden Sie?

+ Machen Sie den Vergleich: Wenn Sie _Autoruns_ auf Ihrem eigenen PC oder Laptop laufen lassen (keine Gefahr ;-)) -- wie schaut es da aus? Erschrecken 
Sie nicht!

= H Super-Bonus: Trojaner _analysieren_
#set enum( //Nummerierung 
  full: true,
  start: 17,
  numbering: numbly("{1:(1)}", "{2:a})"),
)
+ _Nur für Sehr Fortgeschrittene:_ Laden Sie einen echten Virus oder Trojaner (etwa von #link("https://dasmalwerk.eu/")[`dasmalwerk.eu`] oder einen "Trojaner-Simulator", etwa selbst gemacht mit `msfvenom` bzw. `Veil` unter Kali Linux...) auf eine entsprechend abgesicherte Windows-VM (bitte *nur* am Schul-PC!), wenn Sie sich trauen ;-)
und betrachten Sie das Programm mit _Process Monitor_ beim Werken!

*Viel Spaß!*