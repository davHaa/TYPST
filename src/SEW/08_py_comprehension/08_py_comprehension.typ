#import "../resources/SEW_Template.typ": create_page_template
#import "../resources/SEW_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/SEW_Template.typ": count, count2, count8, count6; 
#show: template 

#let filename = "08_py_comprehension";

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ List/Set/Dictionary Comprehension - Theorie
#v(2mm)
```python
li = [ 1, 2, 3, 4, 5 ]
[ x*x for x in li ]    # --> [1, 4, 9, 16, 25]
```

Das kann man auch mit einer Bedingung kombinieren

```python
li = [ 1, 2, 3, 4, 5]
[ x**3 for x in li if x > 3 ]  # --> [64, 125]
```

oder mehrere Schleifen

```python
[(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
# -> [(1, 3), (1, 4), (2, 3), (2, 1), (2, 4), (3, 1), (3, 4)]
```

```python
# anders formatiert = lesbarer
[ (x, y)
  for x in [1,2,3]
  for y in [3,1,4]
  if x != y
]

```

Anmerkung: das _Kombinieren_ von zwei oder mehr Listen gibt es fertig als `zip()`
(denke an _Reißverschluss_).

```python
all( x >= y
     for x,y in zip(liste, liste[1:])
```

Mit Comprehensions kann man auch Dictionaries

```python
>>> { x:x*x for x in li }    # --> {1: 1, 2: 4, 3: 9, 4: 16, 5: 25}
```

oder ein Set erzeugen.

```python
>>> { x*x for x in li }      # --> {16, 1, 4, 25, 9}
```
- Details siehe #link("https://www.datacamp.com/tutorial/python-list-comprehension")[https://www.datacamp.com/tutorial/python-list-comprehension]
- Überblicksvideo #link("https://www.youtube.com/watch?v=lyDLAutA88s")[https://www.youtube.com/watch?v=lyDLAutA88s] 

Hinweis:
: aus so etwas

```python
    res = [] # oder {} o.ä. -- leer
    for x in ...:
        res.add(...x...)
```

wird

```python
    res = [ ...x...
            for x in ...
        ]
```

Wichtig: das ist *dubios*:

```python
    res = []
    [ res.add(...x...)
      for x in ...
    ]
```

Hier wird mit den Ergebnissen von `add()` eine Liste erzeugt und diese Liste dann verworfen.
Nur als *Nebeneffekt* wird es auch zur Liste hinzugefügt.

== B~~~ Test auf `empty()`:
#v(2mm)
Fast alle Python-Objekte können *als boolean getestet* werden dh. bei einem `if` direkt
eingesetzt werden: entspricht einem Test auf *ist nicht leer*.

```python
 if x:
   do
  
 # nicht
 if len(x) > 0:
   do
```

== C~~~ Aufgabe: Rechtschreibkorrektur
#v(2mm)
Datei: `spellcheck.py`

Finde zu einem möglicherweise falsch geschriebenen Wort die beste Korrektur
(Vereinfachung: alles wird klein geschrieben).

Vorgehen: wir _simulieren_ die möglichen Fehler: ein Buchstabe fehlt oder ist zu viel,
sowie Buchstabendreher. Und zwar nicht für alle Wörter im Wörterbuch (die Liste bzw. ein Dictionary
aller falsch geschrieben Wörter inkl. richtiger Schreibweise wäre viel zu groß),
sondern _umgekehrt_: Wir untersuchen, ob Änderungen (=Rückgängigmachen des Fehlers) am gegebenen
Wort (das der Benutzer möglicherweise mit Tippfehlern eingegeben hat) zu einem Eintrag im Wörterbuch führen. Wir beschränken die Suche auf maximal zwei
Fehler#footnote[etwa wie in #link("https://de.wikipedia.org/wiki/Levenshtein-Distanz")[https://de.wikipedia.org/wiki/Levenshtein-Distanz]
beschrieben].

Möglichst alle Unterprogramme sollten mit List- oder Set-Comprehension gelöst werden.
Selbstverständlich brauchen alle Unterprogramme einen `docstring` und sollten mit Typehints definiert werden.

== C.1~~~ Unterprogramm `read_all_words(filename:str) -> Set[str]`
#v(2mm)
Gegeben: eine Datei mit vielen (allen?) Wörtern. Speichere dieses Wörterbuch in
einem Set, aber *nicht* in deinem `git`-Repository.

- #link("https://wortschatz.uni-leipzig.de/de/download")[https://wortschatz.uni-leipzig.de/de/download]
- #link("http://sourceforge.net/projects/germandict/")[http://sourceforge.net/projects/germandict/]
- Linux/Mac(?): `/usr/share/dict/*`

Hinweis: verwende zum Einlesen/Öffnen der Datei ein `with` (context manager) -- damit braucht
man kein `close()`:

``` python
    with open(...) as f:
       for line in f:
          ...
```

Ein `set` ist ähnlich einer Liste (aber ohne definierte Reihenfolge, ohne doppelte
Einträge) bzw. einem Dictionary (aber nur die `Keys`, keine `Values`). Und man
kann `set`s recht einfach kombinieren#footnote[siehe Theoriestunde und https://docs.python.org/3/library/stdtypes.html#set-types-set-frozenset>]: `& | ^`

== C.2~~~ Unterprogramm `split_word(wort:str) -> List[Tuple[str, str]]`
#v(2mm)
Bestimmt eine Liste aller _Aufteilungen_ des Wortes. Die Listenelemente bestehen aus Tupel mit den Elementen head und tail. 

```python
split_word("abc") # --> [ ("", "abc"), ("a", "bc"), ("ab", "c"), ("abc", "") ]
```
Tipp: `s[3:]` bzw. `s[:3]`

== C.3~~~ Unterprogramm `edit1(wort:str) -> Set[str]`
#v(2mm)
Finde alle Wörter mit Edit-Distanz eins (= ein Tippfehler)


#count8[bestimme mit dem Ergebnis von `split_word()` alle _möglichen_ Wörter mit einem Fehler _weniger_ dh. wobei jeweils

  + Buchstabe fehlt
  + zwei Buchstaben verdreht sind
  + ein Buchstabe durch einen anderen Buchstaben ersetzt wurde
  + ein Buchstabe eingefügt wurde#footnote[`string.ascii_lowercase` oder besser: alle in der Wortliste vorkommenden Zeichen]
]
    Kombiniere dazu die _zwei Wortteile_ (head und tail) von `split_word()` -- der _Fehler_
    tritt an der Trennstelle bzw. zu Beginn des zweiten Wortteils (dem tail) auf. Beispiel:
	
    ```python
		("a", "bc") -->
			"ac"   # ein Buchstabe fehlt
			"acb"  # zwei Buchstaben verdreht
			"aac", "abc", "acc", "adc", ... # ein Buchstabe ersetzt
			"aabc", "abbc", "acbc", ... # ein Buchstabe eingefügt
    ```

    Hier bietet sich `doctest` an -- es gibt doch einige Sonderfälle, die man berücksichtigen sollte.

    Hinweis: benutze _List Comprehension_ (zur Not kann man auch `for`-Schleifen  verwenden).

#count8[liefere alle Möglichkeiten als `set` zurück -- damit gibt es keine doppelten Einträge.]

== C.4~~~ Unterprogramm `edit1_good(wort:str, alle_woerter:List[str]) -> Set[str]`
#v(2mm)
ruft `edit1(wort)` auf und filtert, d.h. liefert aber nur die _richtigen_ Wörter (aus dem Wörterbuch)#footnote[Auch wenn sich hier eine Comprehension anbietet -- es ist
eigentlich eine _Mengenoperation_, und die sind viel schneller].

Tipps / Wiederholung aus der Theorie: 

- Mengen kann man direkt verknüpfen: Durchschnitt, Vereinigung etc. Dafür gibt es Methoden und überladene Operatoren (`&, |, ^`)

```python
    # return {x for x in edit1(word.lower()) if x in alle_woerter}
    # besser:
    return edit1(word.lower()) & alle_woerter

```

- Achtung: `and` bzw. `or` bei Mengen:

```python
	a = {1,2,3}; b={2,3,4}; c=set()
	a or b:  # liefert a (falls true) sonst b: --> {1,2,3}
	a and b: # liefert b (falls a true ist) sonst set() --> {2,3,4}
	c and b: # --> set()
```
== C.5~~~ Unterprogramm `edit2_good(wort:str, alle_woerter:List[str]) -> Set[str]`
#v(2mm)
Bestimme Wörter mit Edit-Distanz zwei:
`edit1(wort1)` für alle Möglichkeiten mit einem Fehler (= Ergebnis von `edit1(wort)`).

Man braucht hier nur _richtige_ Wörter -- gleich filtern spart viel Platz.

== C.6~~~ Unterprogramm `correct(word:str, alle_woerter:List[str]) -> Set[str]`
#v(2mm)

Finde die Korrektur(en) für `word` als _"Liste"_:

- entweder ist das Wort im Wörterbuch (Ergebnis: eine Liste mit einem Eintrag `word`)
- oder (mindestens) ein Wort mit Edit-Distanz eins ist im Wörterbuch (Ergebnis: Liste dieser Wörter)
- oder (mindestens) ein Wort mit Edit-Distanz zwei ist im Wörterbuch (Ergebnis: Liste dieser Wörter)
- oder wir haben keine Idee (zu viele Fehler oder unbekanntes Wort): liefere eine Liste mit dem ursprünglichen Wort

Das kann man in einer Zeile/mit einem Befehl machen -- oder übersichtlicher mit `if`.

Tipp:

- Listen/Sets/Strings/etc. haben eine Methode `__boolean__()` -- _bei einem `if`_ entspricht das dem Test auf _nicht leer_.

- Was liefert `a or b` zurück? (siehe oben)

== C.7~~~ Verbesserungen für Experten:
#v(2mm)
- Wenn die Wortliste ein _normaler_ Text ist (z.B. ein Buch) kann man auch Worthäufigkeiten bestimmen. Die Liste der Korrekturen sollte dann entsprechend sortiert werden


== C.8~~~ Test
#v(2mm)
Ein paar `docstring`s und `doctest`s runden das Projekt ab.

```python
    >>> woerter = read_file("de-en.txt")
    >>> correct("Aalsuppe", woerter)
    {'aalsuppe'}
    >>> correct("Alsuppe", woerter)
    {'aalsuppe'}
    >>> sorted(correct("Alsupe", woerter))
    ['aalsuppe', 'absude', 'alse', 'lupe', 'staupe']
```
