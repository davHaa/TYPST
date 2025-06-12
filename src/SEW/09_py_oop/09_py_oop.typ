
#import "../resources/SEW_Template.typ": create_page_template
#import "../resources/SEW_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/SEW_Template.typ": count, count2, count8, count6; 
#show: template 

#let filename = "09_py_oop";

#set page(
  width: 210mm, 
  height: 297mm, 
  margin: (top: 35mm, bottom: 25mm, left: 15mm, right: 15mm),
  header-ascent: 5mm, 
  header: create_page_template(filename).header,
  footer: create_page_template(filename).footer
)

== A~~~ Objektorientierte Programmierung in Python
#v(2mm)
siehe

- #link("https://docs.python.org/3/tutorial/classes.html#a-first-look-at-classes")[https://docs.python.org/3/tutorial/classes.html#a-first-look-at-classes]
- #link("http://anandology.com/python-practice-book/object_oriented_programming.html")[http://anandology.com/python-practice-book/object_oriented_programming.html]
- #link("http://learnpythonthehardway.org/book/ex40.html")[http://learnpythonthehardway.org/book/ex40.html]

```python
class Employee:
  'Common base class for all employees'
  empCount = 0  # class variable shared by all instances

  def __init__(self, name, salary): # always: self as 1st parameter
    "Constructor"
    self.name = name     # instance variable unique to each instance
    self.salary = salary
    Employee.empCount += 1

emp = Employee("Zara", 2000) # create new Employee
print( emp, emp.name )

class Worker(Employee): # Baseclass(es) in ()
  pass                  # empty block - no operation

```

Wichtig (und gefährlich): man kann jederzeit Attribute _dazugeben_, diese entstehen bei der
Zuweisung (wie andere Variablen auch)

- Ausgabe von Text: #[
  #set list(marker: [--])
  - `print` kann mehrere Dinge ausgeben dh. keine `+` und kein `str()` z.B.:  ```python  print("Wert:", wert) ```
  - formatierte Ausgabe geht ab 3.6 mit f-Strings#footnote[#link("https://docs.python.org/3/reference/lexical_analysis.html#f-strings")[https://docs.python.org/3/reference/lexical_analysis.html#f-strings]]. Die alte Variante mit `%` (wie `printf`) sollte man nicht mehr einsetzen.
  - es gibt benannte Parameter für den _Zwischenraum_, das _Endezeichen_ und die Datei, in die geschrieben wird
]

== B~~~ Aufgabe: Bruch
== B.1~~~ Klasse

Datei: `Fraction.py`

Eine Klasse `Fraction` für Bruchzahlen: Zähler und Nenner

- Konstruktor mit 2 Zahlen (bei einem Wert soll der Nenner 1 sein)
    `*` `__init__(self, zaehler, nenner)`

         wie Java: Konstruktor: #[#set list(marker: [--])
 - `self` entspricht in Java `this`, muss angeben werden!,
 - `__` (zwei Unterstriche bzw. *dunder* sind Python interne Funktionen).
             - werden nicht *direkt* aufgerufen (niemals!)
             - `Fraction(1,2) --> Fraction.__init__(1,2)`
]

         - `self` entspricht in Java `this`, muss angeben werden!,
         - `__` (zwei Unterstriche bzw. *dunder* sind Python interne Funktionen).
             - werden nicht *direkt* aufgerufen (niemals!)
             - `Fraction(1,2) --> Fraction.__init__(1,2)`

    - Python kann Methoden/Funkionen nicht überladen (kein, ein oder zwei
      Parameter) -- dafür gibt es aber Default-Werte.
        - `__init__(self, zaehler=0, nenner=1)`
        - obwohl: `from functools import singledispatch` kann das *emulieren*
    - da es in Python kein `private` gibt: üblich ist der Name mit einem
      Unterstrich `_numerator`#footnote[siehe
      https://docs.python.org/3/tutorial/classes.html#tut-private].

- Sonderfälle:
    - Im Fehlerfall: Exception `ArithmeticError`
    - was macht man mit dem Vorzeichen?

- Ausgabe sollte möglich sein -- das geht über die *dunder*-Methoden:
    - `__str__`  für `print`, die Umwandlung in Text (~Java: `toString()`)
        - Wichtig: `5/3` wird bei uns als `1 2/3` ausgegeben.
    - `__repr__` eine vollständige Darstellung
        - wie man das Objekt erzeugen würde (meist gilt `eval(repr(obj)) == obj`)
        - zB. `Fraction(1, 2)`
    - siehe: https://docs.python.org/3/library/reprlib.html

- alle Operatoren damit man mit Brüchen *rechnen* kann#footnote[siehe
  https://docs.python.org/3/library/operator.html bzw.
  https://rszalski.github.io/magicmethods/]:
    - `__add__(self, otherfraction)`

        - aus `a+b` macht Python  `a.__add__(b)` bzw. `ClassA.__add__(a, b)`

    - Wichtig: Kürzen nicht vergessen! wo ist es sinnvoll?
    - Achtung: `__div__` ist Python 2! `__truediv__` bzw. `__floordiv__` bei Python 3.
    - Vergleichs-Operatoren braucht nicht alle implementieren: `@functools.total_ordering`
    - man kann auch `NotImplemented` liefern (als Wert!, das ist keine Exception),
      dann wird zB. die *reverse* Methode versucht (siehe unten: Verbesserungen).
    - auf die `__i...__` Methoden verzichten wir dh. `a += b` (`__iadd__`) brauchen wir nicht.

- Python kann mehrere Zuweisungen *gleichzeitig*, man kann damit einige
  Hilfsvariablen sparen, aber es ist vielleicht auch unübersichtlicher:

```python
    z, n = 1, 3
    # same as/actually a tuple assignment
    (z, n) = (1, 3)
```

- Zugriff auf Zähler und Nenner: nicht wie in Java mit `get...()` sondern
  mit *Properties* #footnote[siehe
  https://docs.python.org/3/library/functions.html#property]

  `_numerator` und `_denominator` als Attribute, `numerator` und `denominator` als
    Property^[genau so benennen - das wird getestet!].

  Achtung: beim Setzen -- wann soll/darf man kürzen? eigentlich nur wenn
  man Zähler und Nenner setzt, aber das ist dann eigentlich eine Zuweisung...
  also kein Setzen der Werte.

- man sollte Brüche auch in `float` umwandeln können (`__float__`).

== B.2~~~ Test