#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4; 
#show: template 

#let filename = "00_Computer_Grundlagen";


#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)


= A~~~ Einführung

Vorbereitend für die folgenden Laborübungen wollen wir:

- uns mit der Umgebung zur Rechnervirtualisierung im Labor vertraut machen, dazu
- einen ersten virtuellen Computer ("Virtuelle Maschine", VM) selbst mit ein paar Mausklicks "bauen" und
- darauf ein aktuelles Windows (von einer -- virtuellen -- Installations-DVD) auch selbst installieren.

_Bemerkung:_ In den folgenden Laborübungen werden wir von vorbereiteten virtuellen Maschinen einfach eine Kopie für den Eigengebrauch machen (sog. _Cloning_), damit wir nicht immer
selbst installieren müssen.

Im Anschluss werden wir einige Kenndaten auf unserem virtuellen PC
ermitteln und in einem ersten Labor-Protokoll dokumentieren.

= B~~~ Durchführung

Ihr Übungsprotokoll soll, sofern nicht anders angegeben, in kurzen
Stichworten alle notwendigen Schritte zur Durchführung der Übung
dokumentieren, so dass eine andere Person anhand des Protokolls die
gesamte Übung problemlos später nachvollziehen kann (die Bewertung
erfolgt aufgrund von Korrektheit, Vollständigkeit und Form). Ferner
sollte das Protokoll Ihre Antworten auf alle gestellten Fragen
enthalten.

*Wichtig:* Sie dürfen sich bei einem allfälligen Interview
auf Ihr Protokoll beziehen _(Sie können also während des Betreuergesprächs auch etwas kurz in Ihrem Protokoll nachlesen)_.

= C~~~ Inbetriebnahme der VM

Ihr freundlicher Labor-Lehrer wird Ihnen die wichtigsten Schritte auf einem Testsystem vorführen -- im wesentlichen ist der Ablauf
folgendermaßen:

#count[Virtualisierungs-Software (ein sog. Typ II-Hypervisor) auf dem Host-System "finden" und starten.]

#count1[
  Mit der Virtualisierungs-Software (bei uns derzeit _VMware Workstation_) einen passenden virtuellen Computer (VM) bauen, also:

+ Eine neue VM (_New Virtual Machine → Custom (Advanced)_) anlegen (das Betriebssystem installieren wir später - _I will install operating system later_)

+ Als Betriebssystem wählen Sie `Microsoft Windows` → `Windows 11 x64` 

+ Benennen Sie die VM gleich nach unserem Laborstandard, also etwa
]

