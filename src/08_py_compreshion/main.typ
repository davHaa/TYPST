#let sharepoint = "https://htl3r.sharepoint.com/sites/IT-SYT-BS/Freigegebene%20Dokumente"
#let mainPage = "https://www.htlrennweg.at/"

#set page(
  width: 210mm,
  height: 297mm,
  margin: (top: 50mm, bottom: 25mm, left: 25mm, right: 25mm),

  header: [
    
        // Left column - Logo
        #image("../htl3r_logo.jpg", width: 40mm)
        
        // Right column - Header content
        #align(right)[
          #link(sharepoint)[
            #text(weight: "bold", size: 1.2em, "SEW 4: py comprehension")
          ]
          #v(-4mm)
          #text("Übungsblatt 09")
          #v(-3mm)
          #text(size: 0.9em, "Schuljahr 2024/25 an der ")
          #link(mainPage)[
            #text(size: 0.9em, "HTL Wien 3 Rennweg")
          ]
          #v(-3mm)
          #link(mainPage)[
            #text(size: 0.9em, "Rennweg 89b, 1030 Wien")
          ]
          #v(-2mm)
          #line(length: 100%)
        ]
      ],

  footer: [
    #line(length: 100%)
    #v(1mm)
    #align(left)[Version vom 18. März 2025]
  ]
)


= A List/Set/Dictionary Comprehension - Theorie

```python
li = [1, 2, 3, 4, 5]
[ x*x for x in li ]  # --> [1, 4, 9, 16, 25]
```

Das kann man auch mit einer Bedingung kombinieren

```python
li = [1, 2, 3, 4, 5]
[ x**3 for x in li if x > 3 ]  # --> [64, 125]
```

 oder mehrere Schleifen

```python
[(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
#-> [(1, 3), (1, 4), (2, 3), (2, 1), (2, 4), (3, 1), (3, 4)]

# anders formatiert = lesbarer
[ (x, y)
  for x in [1,2,3]
  for y in [3,1,4]
  if x != y
]
```

 Anmerkung: das Kombinieren von zwei oder mehr Listen gibt es fertig als   #strong[zip()] (denke an Reißverschluss).


```python
 all( x >= y
      for x,y in zip(liste, liste[1:])
```

Comprehensions für Dictionaries:

```python
 >>> { x:x*x for x in li } #--> {1: 1, 2: 4, 3: 9, 4: 16, 5: 25}
```

Oder für ein Set:

```python
>>> { x*x for x in li } #--> {16, 1, 4, 25, 9}
```

- Details siehe  #link("https://www.datacamp.com/tutorial/python-list-comprehension", "https://www.datacamp.com/tutorial/python-list-comprehension")
- Überblicksvideo #link("https://www.youtube.com/watch?v=lyDLAutA88s", "https://www.youtube.com/watch?v=lyDLAutA88s")

#block[
  #strong[Hinweis:] aus so etwas

```python
    res = []  # oder {} o.ä. -- leer
    for x in ....:
        res.add(...x...)
```

  wird

```python
    res = [ ...x...
            for x in ... 
        ]
```

  Wichtig: das ist _dubios_:

```python
    res = []
    [ res.add(...x...)
      for x in ... 
    ]
```

Hier wird mit den Ergebnissen von #strong[add()] eine Liste erzeugt und diese Liste dann verworfen.
Nur als _Nebeneffekt_ wird es auch zur Liste hinzugefügt.
]


= B Test auf empty():

 Fast alle Python-Objekte können als boolean getestet werden dh. bei einem #strong[if] direkt eingesetzt werden: entspricht
 einem Test auf ist nicht leer.

```python
  if x:
    do

# nicht
  if len(x) > 0:
    do
```


= C Aufgabe: Rechtschreibkorrektur
Datei: #strong[spellcheck.py]
#block[
 Finde zu einem möglicherweise falsch geschriebenen Wort die beste Korrektur (Vereinfachung: alles wird klein
 geschrieben).
]
#block[
 Vorgehen: wir simulieren die möglichen Fehler: ein Buchstabe fehlt oder ist zu viel, sowie Buchstabendreher.
 Und zwar nicht für alle Wörter im Wörterbuch (die Liste bzw. ein Dictionary aller falsch geschrieben Wörter
 inkl. richtiger Schreibweise wäre viel zu groß), sondern umgekehrt: Wir untersuchen, ob Änderungen (=Rück
gängigmachen des Fehlers) am gegebenen Wort (das der Benutzer möglicherweise mit Tippfehlern eingegeben
 hat) zu einem Eintrag im Wörterbuch führen. Wir beschränken die Suche auf maximal zwei Fehler.
]
 #block[
 Möglichst alle Unterprogramme sollten mit List- oder Set-Comprehension gelöst werden. Selbstverständlich brauchen alle Unterprogramme einen docstring und sollten mit Typehints definiert werden.
]

==  C.1 Unterprogramm python read_all_words(filename:str)-> Set[str]
Gegeben: eine Datei mit vielen (allen?) Wörtern. Speichere dieses Wörterbuch in einem Set, aber #strong[nicht] in deinem git-Repository.

- #link("https://wortschatz.uni-leipzig.de/de/download", "https://wortschatz.uni-leipzig.de/de/download")
- #link("http://sourceforge.net/projects/germandict/", "http://sourceforge.net/projects/germandict/")
- Linux/Mac(?): #link("https://sourceforge.net/projects/germandict/", "/usr/share/dict/*")

Hinweis: verwende zum Einlesen/Öffnen der Datei ein #strong[with] (context manager) – damit braucht man kein
 close():
 

```python
  with open(...) as f:
     for line in f:
        ...
```

 Ein set ist ähnlich einer Liste (aber ohne definierte Reihenfolge, ohne doppelte Einträge) bzw. einem Dictionary
 (aber nur die Keys, keine #strong[Values]). Und man kann sets recht einfach kombinieren2: #strong[& | ^]

==  C.2 Unterprogramm split_word(wort:str)-> List[Tuple[str, str]]
 Bestimmt eine Liste aller Aufteilungen des Wortes. Die Listenelemente bestehen aus Tupel mit den Elementen
 head und tail.

```python
split_word("abc") #--> [ ("", "abc"), ("a", "bc"), ("ab", "c"), ("abc", "") ]
```
Tipp: s[3:] bzw. s[:3]

==  C.3 Unterprogramm edit1(wort:str)-> Set[str]
Finde alle Wörter mit Edit-Distanz eins (= ein Tippfehler)

#enum(
  enum.item(1)[ Bestimme mit dem Ergebnis von #strong[split_word()] alle _möglichen_ Wörter mit einem Fehler _weniger_, dh. wobei jeweils])


 #set enum(numbering: "a)")

+ ein Buchstabe fehlt 
+ zwei Buchstaben verdreht sind
+ ein Buchstabe durch einen anderen Buchstaben ersetzt wurde
+ ein Buchstabe eingefügt wurde
     

Kombiniere dazu die zwei Wortteile (head und tail) von split_word() - der Fehler tritt an der Trennstelle bzw. zu Beginn des zweiten Wortteils (dem tail) auf. Beispiel:

```python
("a", "bc")-->
 "ac" # ein Buchstabe fehlt
 "acb" # zwei Buchstaben verdreht
 "aac", "abc", "acc", "adc", ... # ein Buchstabe ersetzt
 "aabc", "abbc", "acbc", ... # ein Buchstabe eingefüg
```
Hier bietet sich `doctest` an-- es gibt doch einige Sonderfälle, die man
berücksichtigen sollte.

#set enum(numbering: "1.")
#enum(
  enum.item(2)[Hinweis: benutze List Comprehension (zur Not kann man auch `for`-Schleifen verwenden).])

==  C.4 Unterprogrammedit1_good(wort:str, alle_woerter:List[str])-> Set[str]
#block[ruft edit1(wort) auf und filtert, d.h. liefert aber nur die richtigen Wörter (aus dem Wörterbuch).]

Tipps / Wiederholung aus der Theorie:

- Mengenkann mandirekt verknüpfen: Durchschnitt, Vereinigung etc. Dafür gibt es Methoden und überladene
 Operatoren (&, |, ^)
 
```python
    # return {x for x in edit1(word.lower()) if x in alle_woerter}
    # besser:
    return edit1(word.lower()) & alle_woerter
```
- Achtung: and bzw. or bei Mengen:

```python
    a = {1,2,3}; b={2,3,4}; c=set()
    a or b: # liefert a (falls true) sonst b:--> {1,2,3}
    a and b: # liefert b (falls a true ist) sonst set()--> {2,3,4}
    c and b: #--> set()
```

== C.5 Unterprogrammedit2_good(wort:str, alle_woerter:List[str])-> Set[str]
#block[Bestimme Wörter mit Edit-Distanz zwei: edit1(wort1) für alle Möglichkeiten mit einem Fehler (= Ergebnis von edit1(wort)).]
#block[Man braucht hier nur richtige Wörter– gleich filtern spart viel Platz.]

==  C.6 Unterprogramm correct(word:str, alle_woerter:List[str])-> Set[str]

Finde die Korrektur(en) für word als “Liste”:

-  entweder ist das Wort im Wörterbuch (Ergebnis: eine Liste mit einem Eintrag word)
-  oder (mindestens) ein Wort mit Edit-Distanz eins ist im Wörterbuch (Ergebnis: Liste dieser Wörter)
-  oder (mindestens) ein Wort mit Edit-Distanz zwei ist im Wörterbuch (Ergebnis: Liste dieser Wörter)
-  oder wir haben keine Idee (zu viele Fehler oder unbekanntes Wort): liefere eine Liste mit dem ursprünglichen Wort
 
Das kann man in einer Zeile/mit einem Befehl machen– oder übersichtlicher mit if

Tipp:

- Listen/Sets/Strings/etc. haben eine Methode boolean()– bei einem if entspricht das dem Test auf nicht leer.

-Was liefert a or b zurück? (siehe oben)

==  C.7 Verbesserungen für Experten:

- Wenn die Wortliste ein normaler Text ist (z.B. ein Buch) kann man auch Worthäufigkeiten bestimmen. Die
 Liste der Korrekturen sollte dann entsprechend sortiert werden

==  C.8 Test

Ein paar docstrings und doctests runden das Projekt ab.
```python
    >>> woerter = read_file("de-en.txt")
    >>> correct("Aalsuppe", woerter)
    {'aalsuppe'}
    >>> correct("Alsuppe", woerter)
    {'aalsuppe'}
    >>> sorted(correct("Alsupe", woerter))
    ['aalsuppe', 'absude', 'alse', 'lupe', 'staupe']
```



