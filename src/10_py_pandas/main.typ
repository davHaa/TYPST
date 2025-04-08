#import "../template.typ": page_template

#set page(width: 210mm, height: 297mm, margin: (top: 10mm, bottom: 20mm, left: 15mm, right: 15mm),header-ascent: -18mm,

header : page_template.header,
  footer : page_template.footer)

  #v(35mm)
= A Aufgabenstellung
Lehrer müssen oft Noten- und Schülerlisten in verschiedenen Formaten zusammenführen. Entwickle ein kleines Hilfsprogramm für die Kommandozeile (CLI), die einem Lehrer beim Zusammenführen einer Noten- und Schülerliste unterstützt.

Wir verwenden dazu _Regular Expressions_#footnote[import re] zum Einlesen einer ```.xml```-Datei für die Stammdaten der Schüler und üben wieder den Umgang mit ```argparse```. Die mächtige Bibliothek ```pandas```#footnote[https://pandas.pydata.org/docs/user_guide/] hilft uns dabei,

- die ```.csv```-Datei mit den Schülernoten einzulesen,
- die Notenliste und die Schülerliste zu verknüpfen,
- das Ergebnis zu filtern
- und wieder in eine csv-Datei zu schreiben.

= B Allgemeine Hinweise:
- Benutze die Python-Bibliothek argparse– siehe Foliensatz / Vorbesprechung
- Überprüfe immer vor dem Einlesen einer Datei, ob diese auch existiert#footnote[https://www.w3docs.com/snippets/python/how-do-i-print-to-stderr-in-python.html]
- Fehlermeldungen sollen– wie unter Linux üblich– auf dem Stderror-Device ausgegeben werden#footnote[https://www.geeksforgeeks.org/python-os-strerror-method/]. Benutze standardisierte Fehlermeldungen#footnote[https://www.geeksforgeeks.org/python-os-strerror-method/]
- Benutze die beiliegenden Dateien, um die Lösung zu überprüfen
- Alle Beispiele kommen in das Git Repository (2024_4cn_xxxx_sew4_sem1p xxxx=4-stellige Nummer), Dateiname = ```noten.py```.
- Type-Annotantions = Type-Hints verwenden#footnote[siehe z.B. https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html]
- Dokumentation mit PyDoc
- “Hauptprogramm” mit ```python if __name__ == "__main__"```:

= C Beispielaufrufe
Die Beispielaufrufe führen zu den beigefügten Dateien.

== C.1 Hilfe
```text python noten.py-h
 usage: noten.py [-h] [-n N] [-s S] [-m M] [-f F] [-v |-q] outfile
 
 noten.py by Max Mustermann / HTL Rennweg
 
 positional arguments:```
#table(
   columns: (auto,auto), stroke: none, row-gutter: 0.00001%,
   [```text outfile```],[```text Ausgabedatei (z.B. result.csv)```]
 )
 ```text options:```
 #table(
   columns: (auto, auto), stroke: none, row-gutter: 0.00001%,
   [```text -h,--help```],[```text  show this help message and exit```],
   [```text -n N```],[```text csv-Datei mit den Noten```],
   [```text -s S```],[```text xml-Datei mit den Schülerdaten```],
   [```text -m M```],[```text AName der Spalte, die zu verknüpfen ist (default = Nummer)```],
   [```text -f F```],[```text Name des zu filternden Gegenstandes (z.B. SEW)```],
   [```text -v,--verbose```],[```text Gibt die Daten Kommandozeile aus```],
   [```text -q,--quiet```],[```text  keine Textausgabe```]
 )
 ```text keine Textausgabe ```
 
== C.2 Ohne Filter, verbose
Verknüpft beide Dateien. Man erhält eine ```.csv```-Datei mit den relevanten Daten aller SchülerInnen und sämtli
chen Gegenständen.

```python python noten.py -n noten.csv -s schueler.xml -v result_all.csv
 csv-Datei mit den Noten : noten.csv
 xml-Datei mit den Schülerdaten : schueler.xml
 Name der Spalte, die zu verknüpfen ist : Nummer
 Output-Datei: result_all.csv ```
 
== C.3 Mit Filter auf SEW und ITP, weder verbose noch quiet
Hier erhält man als Ergebnis nur die Noten aus den angegebenen Gegenstand.

*Bonus:* Man kann mehrere Gegenstände angeben; das Programm bildet eine zusätzliche Spalte _Schnitt_, um die Durchschnittsnote der ausgewählten Gegenstände zu speichern.

``` python noten.py-n noten.csv-s schueler.xml-f SEW,ITP result_SEW.csv
 Output-Datei: result_SEW.csv```

= D Hinweise und Tipps
- Die ```.xml```-Datei soll nicht mittels Pandas-Methode eingelesen wereden, sondern mit der zu implementierenden Methode read_xml(filename: str)-> pd.DataFrame. Lies die gesamte Datei ein– z.B. mit content = f.read(). Finde mittels Regular Expression alle Treffer für _Nummer, Anrede, Vorname, Nachname, Geburtsdatum_ und speichere sie in einem Pandas-DataFrame.
``` pattern = re.compile("regular expression", flags=re.DOTALL)
 result = re.findall(pattern, content)
 df = pd.DataFrame(result, columns=[.....], dtype=str)```
- Die ```.csv```-Datein kann man mittels Hilfsfunktion manuell parsen– oder eine geeignete Pandas-Methode zum
 Lesen/Schreiben verwenden.
- ZumVerknüpfen der DataFrames eignet sich die Methode ```pd.join()```. Tipp: setze den Index der DataFrames auf die geeignete Spalte.