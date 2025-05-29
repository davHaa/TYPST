#import "../resources/BS_Template.typ": create_page_template
#import "../resources/BS_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/BS_Template.typ": count,count1, count2, count4, count5, count6; 
#import "../resources/BS_Template.typ" : my_box
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

#count[Einen Überblick über alle Festplatten und Partitionen erhält man mit folgenden Kommandos.]

Welche Festplatten und Partitionen gibt es derzeit? Benutzen Sie folgendev Kommandos _(Ausgabe ins Protokoll!)_:
