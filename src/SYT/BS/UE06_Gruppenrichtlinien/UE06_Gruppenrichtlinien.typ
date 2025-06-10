#import "../resources/BS_Template.typ": create_page_template

#let filename = "06_Gruppenrichtlinien";

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

= A Gruppenrichtlinien - Hintergrundinformation
== A.1 Gruppenrichtlinien unter _Active Directory_
In einer Firma wünscht man sich als Administrator in der Regel auf allen
Desktop-Clients eine einheitliche Arbeitsumgebung und möchte auch
sicherstellen, dass Benutzer nicht z.B. aus Versehen ihren Computer in
einen nicht gebrauchsfähigen Zustand manövrieren – dazu verwendet man
sogenannte _Gruppenrichtlinien (Group Policy)_. Innerhalb einer
_Active-Directory-Domain-Services_-Umgebung (_AD DS_, man spricht auch
von „AD-Domäne“) können anhand solcher Richtlinien sowohl Computer- als
auch Benutzer _einstellungen_ im gesamten Unternehmen von _zentraler_
Stelle aus festgelegt werden, unter anderem zur:

-   Festlegung der Sicherheitskonfiguration von Benutzern und Computern
    (z.B. Passwortrichtlinien)
-   Steuerung und Einstellung von Windows-Komponenten (z.B. Festlegen
    des Desktop-Erscheinungsbilds und  dessen Funktionalität)
-   Automatischen Installation von Anwendungsprogrammen
-   Konfiguration von Anwendungsprogrammen
-   Gezielten Änderung von Registry-Werten
-   Konfiguration von Berechtigungen für Dateisystem und Registry
-   Festlegung der Verbindungen zu Netzwerklaufwerken und -Druckern
-   Steuerung von Skripts (z.B. Logon-Skripts, die beim Anmelden
    automatisch ausgeführt werden)

Diese Gruppenrichtlinien werden in Form von Gruppenrichtlinienobjekten
(_Group Policy Objects_ = GPOs) definiert. Dies sind Sammlungen von
Einstellungen, die auf ein bestimmtes „Ding“ oder eine Gruppe von Dingen
angewendet werden sollen. Beispielsweise kann man in einer Firma ein GPO
mit allen Benutzern der Abteilung „Buchhaltung“ (der _Organisationseinheit_ "Buchhaltung") verknüpfen -- alle diese
Benutzer erhalten dann die gewünschten Einstellungen.

Generell baut man im _Active Directory_ eine hierarchische Struktur mit sogenannten
_Organisationseinheiten_ (OUs – _Organizational Units_ – wie eben z.B.
Abteilungen) auf -- Objekte wie Benutzer, Gruppen oder Rechner werden dann diesen OUs zugeordnet (aber jeder User kann beispielsweise nur in *einer* OU sein). Mit den Organisationseinheiten (OUs) werden dann einzelne GPOs (= Sammlung von Einstellungen) verknüpft -- man sagt,
die GPOs werden _auf die OUs angewendet_.
Geänderte Einstellungen in den GPOs werden typischerweise mit
dem nächsten Windows-Start, der nächsten Benutzeranmeldung bzw.
automatisch nach einiger Zeit (typischerweise 2 Stunden) übernommen und so von zentraler
Stelle aus für die gewünschten Benutzer oder Computer _erzwungen_.

Gruppenrichtlinien sind – gemeinsam mit der Definition von
Zugriffsrechten für Benutzer und Gruppen – der Eckpfeiler der
Systemsicherheit in Windows-Netzwerken!

== A.2 Lokale Gruppenrichtlinien
Neben den Gruppenrichtlinien im AD verfügen Windows-Computer auch über
_Lokale Richtlinien_, die nur auf dem Rechner Gültigkeit habe, auf dem
sie definiert sind. Damit kann man z.B. eine sichere Basiskonfiguration
für _Standalone-Clients_ (etwa in einem Arbeitsgruppennetzwerk oder
einem Kiosk-Rechner), die also nicht Teil einer Domäne sind, vorgeben.
Von diesen lokalen Richtlinien sind aber nur eine Untermenge, nämlich
die lokalen _Sicherheits_-Richtlinien – über sogenannte
_Sicherheitsvorlagen_ – umfassend einsetzbar (indem man auf jedem
Client-Rechner die entsprechende Datei mit der Sicherheitsvorlage
importiert und aktiviert).

Es sind auch zahlreiche weitere lokale Gruppenrichtlinien (=
Einstellungen) für Einzel- und Arbeitsgruppen-PCs verfügbar, jedoch sind
diese nicht über Dateien von einem PC auf den anderen übertragbar (aber
man kann sie z.B. auf dem Master-PC, von dem man das Abbild zum Klonen
bei der automatisierten Windows-Bereitstellung
erstellt, voreinstellen).

== A.3 Gruppenrichtlinienobjekte -- GPOs
Gruppenrichtlinien werden also in Sammlungen, sogenannten _Group Policy
Objects (GPOs)_ definiert – quasi kleine Datenbanken, die sämtliche
Einstellungen enthalten, die über den Weg einer Verknüpfung auf ein
bestimmtes „Ding“ oder eine Gruppe von „Dingen“ angewendet werden sollen.

Ein GPO in Active Directory wird insbesondere entweder mit

-   der gesamten „Domäne“,
-   einem „Standort“ _(Site)_ oder
-   einer „Organisationseinheit“ (`OU` = _Organizational Unit_, z.B.
    „Werkstätten“ oder „Alle Rechner des EDV-Labors“)

verknüpft und umfasst u.a. folgende Bereiche:

-   Computerkonfiguration
    -   Softwareeinstellungen
    -   Windows-Einstellungen _(inkl. Sicherheitseinstellungen, etwa Passwortkomplexität)_
    -   Administrative Vorlagen _(diverse Berechtigungen, bestimmte Dinge zu dürfen oder nicht)_
-   Benutzerkonfiguration
    -   Softwareeinstellungen
    -   Windows-Einstellungen
    -   Administrative Vorlagen

== A.4 Domänenweite- und Lokale GPOs
Die zentral verwalteten Gruppenrichtlinien (GPOs), die in einer Active
Directory-Umgebung nur auf bestimmte Bereiche angewendet werden
(_Standorte_, _Domänen_ oder frei definierbare _Organizational Units_ = Organisationseinheiten) betreffen alle Computer oder Benutzer der
jeweiligen Organisationseinheit.

Ein _lokales GPO (LGPO – Local Group Policy Object)_ – wie wir es in
dieser Übung einsetzen wollen – wird dagegen direkt auf *einem* Computer
konfiguriert und wirkt ausschließlich auf diesem. Windows gibt
vier verschiedene lokale Gruppenrichtlinienobjekte vor, die über die
_Lokalen Richtlinien_ definiert werden können -- diese Richtlinien
wirken (in vorgegebener Weise -- man kann Sie nicht frei mit Objekten verknüpfen wie in einer
AD_Domäne)) entweder auf :

1)  den gesamten _lokalen Computer_ (betrifft das gesamte System und
    aller Benutzer)
2)  die lokale Gruppe der Administratoren auf dem Computer
3)  die lokale „Gruppe“ der Nicht-Administratoren auf dem Computer
4)  einzelne Benutzer (*keine* Gruppen – diese LGPOs werden auf
    individuelle lokale Benutzer angewendet)

== A.5 Hierarchie der GPOs
Die verschieden Ebenen, auf denen man Gruppenrichtlinienobjekte
definieren (= anwenden/verknüpfen) kann, werden nach einer strengen
Hierarchie ausgewertet, so dass etwa domänenweite Einstellungen stets
lokale Computerrichtlinien überschreiben bzw. einzelne
Organisationseinheiten (z.B. Abteilungen einer Firma oder eine bestimmte
Klasse von Computern) vom Domänen-Standard abweichende Einstellungen
überschreiben können:

1)  Zunächst werden die _lokalen Richtlinien_ mit ihren lokal (nur auf
    dem Rechner selbst) definierten Einstellungen _(Local Group Policy Objects = LGPOs_) angewendet -- das ist die unterste Ebene der Hierarchie.
2)  Dann werden die Richtlinien des _Standortes_ verarbeitet (mit dem
    Standort, z.B. `Site` = „Rennweg“ – verknüpft) – dabei werden
    widersprüchliche Einstellungen aus den LGPOs überschrieben.
3)  Sodann werden die Richtlinien der AD-Domäne (z.B. „`htl.rennweg.at`“)
    verarbeitet – hier konfiguriert man zweckmäßigerweise alle
    Einstellungen, die domänenweit gelten sollen. Wieder werden bereits
    vorhandene Einstellungen, die im Widerspruch stehen, überschrieben.
4)  Zuletzt werden die GPOs der Organisationseinheiten `(OUs)`
    verarbeitet, von den obersten Organisationseinheiten hinunter zu
    den Unter-Organisationseinheiten. Noch einmal gilt das
    „Sieger-Prinzip“ der zuletzt angewendeten GPO.

== A.6 Lokale Sicherheitsrichtlinien (Sicherheitseinstellungen)
In einer Arbeitsgruppen-Umgebung ermöglichen _lokale_
Sicherheitsrichtlinien eine gewisse Konsistenz der
Sicherheitskonfiguration der Rechner. Sie sind sozusagen ein Sonderfall
der Gruppenrichtlinien, die sowohl über das lokale GPO für den lokalen
Computer (Richtlinien für Lokaler Computer → Computerkonfiguration →
Windows-Einstellungen → Sicherheitseinstellungen), als auch insbesondere
über _Sicherheitsvorlagen_ (Dateien mit Einstellungen, die man manuell
auf mehreren PCs anwenden kann) konfigurierbar sind. Dabei können u.a.
folgende Bereiche konfiguriert werden:

-   Kontorichtlinien (inkl. Kennwort-Richtlinie)
-   Lokale Richtlinien: darunter Überwachungsrichtlinie, Zuweisung von
    Benutzerrechten, Sicherheitsoptionen
-   Windows Firewall-Richtlinie (ergänzt bzw. überlagert etwaige
    Einstellungen der eingebauten Firewall)
-   Public Key (= Öffentliche Schlüssel) Richtlinien (EFS _-- Encrypting File System --_ und
    Zertifikate)
-   Software Einschränkungen: verbieten, dass unerwünschte Programme
    gestartet werden können
-   IP Sicherheits-Richtlinien
-   System-Dienste
-   Registrierung
-   Dateisystem

= B Gruppenrichtlinien Praxis (Szenario und Auftragsbeschreibung)
Nach diesem theoretischen Exkurs werden wir nun in der Praxis die
Sicherheit unseres Beispiel-Clients erhöhen. Da wir derzeit ohne
_Active Directory_ arbeiten, werden wir nur _lokale_
Gruppenrichtlinien konfigurieren<!--- und (nach Maßgabe der Zeit) auch eine Vorlage für _lokale_
Sicherheitseinstellungen erstellen--->.

→ Dokumentieren Sie in Ihrem Protokoll Ihre Konfigurationen sowie die
Auswirkungen auf das Testsystem!

= C Inbetriebnahme der VM
Auch für diese Übung verwenden Sie Ihre gewohnte Windows 11 VM#footnote[Windows 10 funktioniert ebenfalls] _(Linked Clone)_ und gehen zurück zum initialen Snapshot.
Um langwierige Update-Orgien zu vermeiden, können Sie auch bei dieser Übung das Netzwerk in den Settings zur VM deaktivieren.
Achtung: Der Gruppenrichtlinienobjekt-Editor steht nur ist in den Professional-, Enterprise-, Ultimate- und Education-Versionen von Windows zur Verfügung#footnote[Derzeit kann man auch unter Windows-Home über einen inoffiziellen Workaround die Gruppenrichtlinien editieren: https://www.heise.de/tipps-tricks/Windows-10-Gruppenrichtlinien-anpassen-so-geht-s-7529609.html].

= D Herstellen einer MMC zur Richtlinien-Konfiguration
(@)  Erklären Sie kurz, was ein *GPO* ist!
(@)  Falls nicht vorhanden, erzeugen Sie (→ `lusrmgr.msc`) die beiden
    Standard-Benutzer `__USER1__` und `__USER2__` (Passwort:
    `__USER1__` bzw. `__USER2__`) und testen Sie die erfolgreiche
    Anmeldung von zumindest einem der beiden Benutzer.
(@)  Starten Sie (wieder als `junioradmin` angemeldet) eine
    MMC-Konsole und fügen Sie folgende Snap-Ins hinzu (insgesamt sollen
    sechs Snap-Ins entstehen):

    -   vier-mal „Gruppenrichtlinienobjekt-Editor“ für die vier Arten der möglichen
    LGPOs, also zum Verwalten des lokalen Gruppenrichtlinienobjekts
    (GPO) für:
        -   den *Lokalen Computer*
        -   alle *Administratoren*
        -   alle *Nicht-Administratoren*
        -   einen einzelnen *Benutzer*, in unserem Beispiel entweder
           `__USER1__` oder `__USER2__` (einen von beiden auswählen)
    -   „Sicherheitskonfiguration und -analyse“
    -   „Sicherheitsvorlagen“

    → Geben Sie Ihrer Konsole den Namen#footnote[Datei/Optionen] `LGPO-Console-xxxx-IhrFamilienname` (`xxxx` ist Ihre vierstellige Login-Nummer)
      und dokumentieren Sie ihr vollständiges Konsolenfenster mit einem Screenshot im Protokoll!

(@)  Speichern Sie die MMC-Konsole auf dem Desktop unter dem Namen
    „LGPO-xxxx“ *(warum?)*!

= E Konfiguration lokaler Gruppenrichtlinie
Konfigurieren Sie nun den PC ähnlich zur Übung 2, doch mit neuen
Mitteln!
Nehmen Sie die Einstellungen der Nachfolgenden Liste vor *(Tipp: Verwenden Sie
ggf. die Filter-Funktion zur Suche)*.    

*Wichtig:* Dokumentieren Sie für jede Einstellung ...    
    
*  *wie* Sie zu der Gruppenrichtlinie gelangt sind -- zum Beispiel:
	"Richtlinien für Lokaler Computer \\ Benutzerkonfiguration \\ Administrative Vorlagen \\ System \\ STRG+ALT+ENTF (Optionen) \\ Abmeldung entfernen 	\rightarrow Aktiviert"
* und  machen Sie von dem Einstellungsfenster stets einen *Screenshot*, den Sie in Ihr Protokoll einfügen!   
    

Für die Gruppe der *Administratoren* (Gruppenrichtlinienobjekt *Richtlinien für Lokaler Computer*) im Bereich „Benutzerkonfiguration \\ Administrative Vorlagen“):    
    
(@)  Deaktivieren Sie die **Autoplay**-Funktion für alle Wechselmedien auf
    diesem Computer  (Tipp: Filter verwenden!).    
<!-- \Benutzerkonfiguration\Administrative Vorlagen\Windows-Komponenten\Richtlinien für die automatische Wiedergabe -->


Für den ganzen Computer, im Abschnitt „Benutzerkonfiguration\\...“:


<!--
(@)  Stellen Sie die Startseite *(Homepage)* des Internet-Explorers auf
    die Homepage der HTL Rennweg (https://www.htl.rennweg.at/) und verhindern Sie gleichzeitig, dass Benutzer diese Einstellung ändern
    können!
-->
(@) Entfernen Sie die Registerkarte *Datenschutz*  und *Sicherheit*  (Organisieren/Optionen) beim Media Player.
<!-- 	Benutzerkonfiguration\Administrative Vorlagen\Windows-Komponenten\Windows Media Player\Benutzeroberfläche\Registerkarte "Datenschutz" ausblenden
		Benutzerkonfiguration\Administrative Vorlagen\Windows-Komponenten\Windows Media Player\Benutzeroberfläche\Registerkarte "Sicherheit" ausblenden
-->

Für die Gruppe der *Nicht-Administratoren*:

(@Bild)  Ändern Sie per Gruppenrichtlinie den Desktop-Hintergrund auf eine nettes Bild
     (z.B. in `C:\Windows\Web\Screen` abgelegt, damit alle Lesezugriff haben) -- Benutzer
     dürfen das nicht mehr ändern können! Hinweis: Wenn Windows nicht aktiviert ist, dann bleibt der Bildschirm leider schwarz.
<!-- 	Benutzerkonfiguration\Administrative Vorlagen\Desktop\Desktop\Desktophintergrund 

--> 

<!-- 
 DRU: Funkt. nicht mehr 21/22 bei nicht aktiv. Windows -- verschoben nach User-GPO mit User-Programm (ohne Priv.)
(@Einloggen)  Lassen Sie automatisch nach dem Einloggen die Anwendung `msconfig.exe` starten! Wie lautet der absolute Pfad von `msconfig.exe` und
wozu verwendet man das Tool häufig?
-->

(@Taskleiste)  Verhindern Sie jegliches **Ändern der Einstellungen für die Taskleiste und das Startmenü**s von
    Seiten des Benutzers!
<!--Benutzerkonfiguration\Administrative Vorlagen\Startmenü und Taskleiste\Ändern der Einstellungen für die Taskleiste und das Startmenü verhindern -->

Für den Benutzer `__USER1__` bzw. die Benutzerin `__USER2__`:

(@Einloggen)  Lassen Sie automatisch **bei der Benutzeranmeldung** die Anwendung `calc.exe` ausführen! 
<!-- Richtlinien für lokalen Computer\__USER1__1\Benutzerkonfiguration\System\Anmelden\Diese Programme bei der Benutzeranmeldung ausführen -->

(@Cmd)  Verhindern Sie, dass `__USER1__` bzw. `__USER2__` das Programm `cmd.exe` (den
    Windows-Kommandozeileninterpreter) ausführen kann *(vorher und
    hinterher testen!)*:
<!-- Windows-Einstellungen\Sicherheitseinstellungen\Richtlinien für die Softwareeinschränkung\ -->

    -   Richtlinien für Softwareeinschränkung (ggf. neu erstellen) →
        Zusätzliche Regeln → RK → Wählen Sie „Neue Pfadregel“ oder „Neue
        Hashregel“  → `C:\Windows\System32\cmd.exe`

         + Was ist „besser“: Pfad oder Hash?
         + Was ist eigentlich ein *Hash*?
         + Was ist eigentlich „besser“: Das hier gemachte *Blacklisting* oder doch ein
           konsequentes *Whitelisting* erlaubter Programme?
		 + Kopieren Sie `C:\Windows\System32\cmd.exe` in den Desktop von `__USER1__` bzw. `__USER2__`, melden Sie sich als `__USER1__` oder `__USER2__` an und starten Sie `cmd.exe` von Ihrem Desktop aus! Was passiert?
		 + *(Bonus:)* Hacken Sie nun `cmd.exe` (im Desktop), indem Sie mit einem HexEditor einen Text-String manipulieren (Screenshot!) und starten Sie die manipulierte Version
		   als `__USER1__` bzw. `__USER2__`! Was passiert jetzt?

(@)  Unterbinden Sie, dass  `__USER1__` bzw. `__USER2__`  auf jegliche **Wechseldatenträger**
     (USB-Sticks, ...) *schreiben* kann *(brauchen Sie nicht zu testen)*!
<!-- Richtlinien für lokalen Computer\__USER1__1\Benutzerkonfiguration\Administrative Vorlagen\System\Wechselmedienzugriff\Wechseldatenträger: Schreibzugriff verweigern -->

Für den *ganzen Computer* (Gruppenrichtlinienobjekt *Richtlinien für Lokaler Computer*) im Abschnitt „Computerkonfiguration \\ Administrative Vorlagen“:

(@)  Verzögern Sie die Installation neuerer Windows-Versionen, indem Sie die sogenannten **Funktionsupdates** für eine definierten Zeitraum zurückstellen. Ändern Sie dazu den **Zeitpunkt für den Empfang von Vorabversionen und Funktionsupdates** auf einen längeren Zeitraum (120 Tage).
<!-- \Windows-Komponenten\Windows Update\Vom Windows Update angebotene Updates verwalten\Zeitpunkt für den Empfang von Vorabversionen und Funktionsupdates auswählen -->
Was ist die maximale Zeitdauer, um die man diese Art der Updates verzögern kann?
<!-- 365 Tage -->

(@)  Verhindern Sie den automatischen **Neustart** nach Updates während der Nutzungszeit
<!-- \Windows-Komponenten\Windows Update\Endbenutzeroberfläche verwalten\Automatischen Neustart nach Updates während der Nutzungszeit deaktivieren -->
*(sinnvolle Werte wählen)*.  


**Test**:

(@)   Testen Sie *jede* der Einstellungen (und korrigieren Sie ggf. die
      Konfiguration, bis es funktioniert)! *(Testergebnisse ins Protokoll - wo möglich mit Screenshot!)*

(@) Wann werden die einzelnen Gruppenrichtlinien jeweils
           angewendet:

      -   sofort ?
      -   nach Neuanmeldung des Benutzers ?
      -   nach Neustart des Systems ?

(@)  Welche Informationen sehen Sie bei Punkt (@Bild), was ändert sich bei Punkt (@Taskleiste),
     welche Fehlermeldung sehen Sie bei Punkt (@Cmd),
     wenn Sie -- als nicht befugter Benutzer -- die
     Einstellungen zu ändern versuchen bzw. das gesperrte Programm aufrufen?

== E.1 Konfiguration lokaler Sicherheitsrichtlinien
Lokale Sicherheitsrichtlinien lassen sich nur über das `GPO`
(Gruppenrichtlinienobjekt) Lokaler Computer anwenden
("Computerkonfiguration → Windows-Einstellungen →
Sicherheitseinstellungen") – ansonsten verhalten Sie sich wie die anderen
Gruppenrichtlinien:

(@)  Erzwingen Sie eine minimale **Kennwortlänge** von 10 Zeichen und testen
    Sie diese Richtlinie!
<!-- Computerkonfiguration\Windows-Einstellungen\ Sicherheitseinstellungen\Kontorichtlinien\Kennwortrichtlinien\Minimale Kennwortlänge-->

(@)  *Bonus:* Erzwingen Sie eine automatische Kontosperrung für Benutzer nach 3
    ungültigen Anmeldeversuchen *(Screenshot der Sperrnachricht!)*!
<!-- Computerkonfiguration\Windows-Einstellungen\ Sicherheitseinstellungen\Kontorichtlinien\Kennwortsperrungsrichtlinien\Kontosperrungsschwelle-->

    -  Wie lange gilt die Kontosperrung standardmäßig?
    -  Gilt diese auch für Administratoren? *(Bevor Sie das testen,
        legen Sie sicherheitshalber einen zusätzlichen
        Administratoren-Account an, sollten Sie sich aussperren oder reduzieren
        Sie die Sperrdauer...)* 

(@)  Welche Benutzergruppen dürfen die **Systemzeit** ändern?
<!-- Computerkonfiguration\Windows-Einstellungen\ Sicherheitseinstellungen\Lokale Richtlinien \ Zuweisen von Benutzerrechten \ Ändern der Systemzeit ==> Lokaler Dienst, Netzwerkdienst -->
(@)  Welche Benutzer/Gruppen dürfen das System herunterfahren?
<!-- Computerkonfiguration\Windows-Einstellungen\ Sicherheitseinstellungen\Lokale Richtlinien \ Zuweisen von Benutzerrechten \ Herunterfahren des Systems ==> Administratoren, Benutzer, Sicherungs-Operatoren -->

*( Das Arbeiten mit Sicherheitsvorlagen -- mit den letzten beiden Snap-Ins unserer 
Konsole -- werden wir uns für einen späteren Zeitpunkt aufheben :-) )*

<!---

*(Bonus -- Optional) Arbeiten mit Sicherheitsvorlagen*
======================================================

Lokale Sicherheitsrichtlinien kann man, im Gegensatz zu den anderen
Gruppenrichtlinien, in Text-Konfigurationsdateien *(Vorlagen =
Templates)* abspeichern, die man dann auf einen anderen PC
transportieren und dort wieder anwenden kann – dazu kann kann man die
Werkzeuge `Sicherheitsvorlagen und Sicherheitsanalyse` verwenden.
Übrigens kann man auch Registry-Einstellungen so direkt festlegen.

→ Konfigurieren Sie nun die Systemsicherheit mit diesen beiden Snap-Ins.
Dazu werden wir eine Windows 11-Standardvorlage für
Sicherheitseinstellungen (`defltbase.inf`) in einen neue
„Sicherheitsdatenbank“ laden, einige sicherheitsrelevante Anpassungen
(Soll-Zustand) vornehmen, den Soll-Zustand mit dem Ist-Zustand
vergleichen und dann – wenn alles unseren Erwartungen entspricht –
unseren Computer mit diesen neuen Sicherheitseinstellungen
konfigurieren:

(@)  Im Kontextmenü der „Sicherheitskonfiguration und -analyse“, öffnen
    Sie eine neue Datenbank und geben ihr einen Namen.
(@)  Importieren Sie jetzt die Standard-(Basis-)Sicherheitsvorlage
    `defltbase.inf`, Sie finden diese im Verzeichnis
    `\Windows\inf`.
(@)  Wieder im Kontextmenü, wählen Sie "Computer jetzt analysieren" und
    geben Sie einen Dateinamen für die Log-Datei an.
(@)  Sie erhalten nun eine Gegenüberstellung der Konfiguration laut
    Vorlage und der aktuellen Systemkonfiguration. Wenn Sie z.B. in die
    Abschnitte "Kontorichtlinien", "Lokale Richtlinien" und
    "Ereignisprotokoll" gehen, sollten Sie im Großen und Ganzen (bis auf
    etwaige Änderungen, die Sie auf ihrem Übungs-PC früher gemacht
    haben) keine Abweichungen sehen! Frage: Wie werden Übereinstimmungen
    bzw. Abweichungen zwischen Ihrer Datenbank und dem aktuellen
    PC-Status dargestellt?
(@)  Erstellen Sie nun eine *neue* Sicherheitsvorlage zur weiteren
    Bearbeitung: Exportieren sie dazu den Inhalt der aktuellen
    Sicherheitsdatenbank in die Datei `MeineVorlage.inf`, und zwar
    in das Standardverzeichnis
    `%userprofile%\Documents\Security\Templates`. Die neue Vorlage
    sollte dann -- nach Aktualisierung -- im Standardordner des Snap-Ins
    „Sicherheitsvorlagen“ magisch erscheinen -- wenn nicht, korrigieren
    Sie den Pfad beim Abspeichern, bis das der Fall ist!
(@)  Konfigurieren Sie nun die Richtlinien Ihrer Vorlage nach eigenem
    Ermessen für eine erhöhte Systemsicherheit *(Protokoll!)*: Gut zum
    Testen sind z.B. die minimale Passwortlänge, einzelne
    Benutzerberechtigungen (z.B. Ändern der Systemzeit, Herunterfahren
    des Systems...) sowie Sicherheitsoptionen (z.B. Str-Alt-Entf beim
    Anmelden erzwingen – siehe Bonus-Aufgabe der Übung 2...). →
    Vorsicht! Nicht mit der "Sicherheit" übertreiben: Sie können damit
    das System auch ziemlich unbrauchbar machen ;-)
(@)  Wenn Sie fertig sind, wenden Sie die Vorlage auf Ihr System an:

    -    Unter "Sicherheitskonfiguration und -analyse", öffnen Sie eine neue
         Datenbank und importieren Sie Ihre eigene Vorlage
    -   Mithilfe der Analyse vergleichen Sie nochmals Ihr aktuelles System
        mit der selbst erstellten Vorlage
    -   Wenn Sie mit allem einverstanden sind, dann wählen Sie im
        Kontextmenü des Snap-Ins "Computer jetzt konfigurieren"

(@)  Testen Sie nun das neu konfigurierte System und protokollieren Sie
    Ihre Beobachtungen!
(@)  Exportieren Sie abschließend die Sicherheitsvorlage auf den Desktop!

-->


*Viel Spaß!*