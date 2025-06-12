#import "../resources/SEW_Template.typ": create_page_template
#import "../resources/SEW_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/SEW_Template.typ": count, count2, count6; 
#show: template 

#let filename = "10_py_pandas";

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ Aufgabenstellung
#v(2mm)
Lehrer müssen oft Noten- und Schülerlisten in verschiedenen Formaten zusammenführen.
Entwickle ein kleines Hilfsprogramm für die Kommandozeile (CLI), die einem Lehrer beim Zusammenführen einer Noten- und Schülerliste unterstützt.

Wir verwenden dazu _Regular Expressions_#footnote[`import re`] zum Einlesen einer `.xml`-Datei für die Stammdaten der Schüler und üben wieder den Umgang mit `argparse`.
Die mächtige Bibliothek `pandas`#footnote[https://pandas.pydata.org/docs/user_guide/] hilft uns dabei,

- die `.csv`-Datei mit den Schülernoten einzulesen,
- die Notenliste und die Schülerliste zu verknüpfen,
- das Ergebnis zu filtern
- und wieder in eine csv-Datei zu schreiben.

== B~~~ Allgemeine Hinweise:
#v(2mm)
- Benutze die Python-Bibliothek `argparse` -- siehe Foliensatz / Vorbesprechung
- Überprüfe immer vor dem Einlesen einer Datei, ob diese auch existiert#footnote()[https://pythonspot.com/read-file/]
- Fehlermeldungen sollen -- wie unter Linux üblich -- auf dem Stderror-Device ausgegeben werden#footnote[https://www.w3docs.com/snippets/python/how-do-i-print-to-stderr-in-python.html]. Benutze standardisierte Fehlermeldungen#footnote[https://www.geeksforgeeks.org/python-os-strerror-method/]
- Benutze die beiliegenden Dateien, um die Lösung zu überprüfen
- Alle Beispiele kommen in das Git Repository (_|YYYY|_`_4cn_xxxx_sew4_sem1p  xxxx`=4-stellige Nummer), Dateiname = `noten.py`.
- Type-Annotantions = Type-Hints verwenden#footnote[siehe z.B. https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html] 
- Dokumentation mit PyDoc
- "Hauptprogramm" mit ```if __name__ == "__main__":```{.py}

== C~~~ Beispielaufrufe
#v(2mm)
Die Beispielaufrufe führen zu den beigefügten Dateien.

== C.1~~~ Hilfe
#v(2mm)
```
python noten.py -h
usage: noten.py [-h] [-n N] [-s S] [-m M] [-f F] [-v | -q] outfile

noten.py by Max Mustermann / HTL Rennweg

positional arguments:
  outfile        Ausgabedatei (z.B. result.csv)

options:
  -h, --help     show this help message and exit
  -n N           csv-Datei mit den Noten
  -s S           xml-Datei mit den Schülerdaten
  -m M           Name der Spalte, die zu verknüpfen ist (default = Nummer)
  -f F           Name des zu filternden Gegenstandes (z.B. SEW)
  -v, --verbose  Gibt die Daten Kommandozeile aus
  -q, --quiet    keine Textausgabe
```
== C.2~~~ Ohne Filter, verbose
#v(2mm)
Verknüpft beide Dateien. Man erhält eine `.csv`-Datei mit den relevanten Daten aller SchülerInnen und sämtlichen Gegenständen.
```bash
python noten.py -n noten.csv -s schueler.xml  -v result_all.csv
csv-Datei mit den Noten : noten.csv
xml-Datei mit den Schülerdaten : schueler.xml
Name der Spalte, die zu verknüpfen ist : Nummer
Output-Datei: result_all.csv
```
== C.3~~~ Ohne Filter, verbose
#v(2mm)
Hier erhält man als Ergebnis nur die Noten aus den angegebenen Gegenstand. 	

*Bonus:* Man kann mehrere Gegenstände angeben; das Programm bildet eine zusätzliche Spalte _Schnitt_, um die Durchschnittsnote der ausgewählten Gegenstände zu speichern.

```bash
python noten.py -n noten.csv -s schueler.xml  -f SEW,ITP result_SEW.csv
Output-Datei: result_SEW.csv
```
== D~~~ Hinweise und Tipps:
#v(2mm)
- Die `.xml`-Datei soll nicht mittels Pandas-Methode eingelesen wereden, sondern mit der zu implementierenden Methode `read_xml(filename: str) ->  pd.DataFrame`. Lies die gesamte Datei ein -- z.B.  mit `content = f.read()`. Finde mittels Regular Expression alle Treffer für _Nummer_, _Anrede_, _Vorname_, _Nachname_, _Geburtsdatum_ und speichere sie in einem Pandas-DataFrame.

```python
pattern = re.compile("regular expression", flags=re.DOTALL)
result = re.findall(pattern, content)
df = pd.DataFrame(result, columns=[.....], dtype=str)
```

- Die `.csv`-Datein kann man mittels Hilfsfunktion manuell parsen -- oder eine geeignete Pandas-Methode zum Lesen/Schreiben verwenden.


- Zum Verknüpfen der DataFrames eignet sich die Methode `pd.join()`. Tipp: setze den Index der DataFrames auf die geeignete Spalte.


