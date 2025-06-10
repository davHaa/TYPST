#import "../resources/SEW_Template.typ": create_page_template
#import "../resources/SEW_Template.typ": template
#import "@preview/numbly:0.1.0": numbly
#import "../resources/SEW_Template.typ": count, count2, count6; 
#show: template 

#let filename = "05_py_kasiski";

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
Wir möchten mittels Vigenère-Chiffre verschlüsselte Texte (in deutscher Sprache) entschlüsseln.   

Über mehrere Jahrhunderte galt die Vigenère-Chiffre unknackbar, bis Friedrich Wilhelm Kasiski im Jahr 1863 seinen nach ihm benannten Test veröffentlichte.
Siehe die beigefügten Unterlagen (ITSI 2. Jahrgang).   
Alle Beispiele kommen in das Git Repository, Unterordner kasiski,
Dateiname = kasiski.py.

Wie immer gilt: 

- Type-Annotantions = Type-Hints verwenden#footnote[siehe z.B. https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html] 
- Dokumentation mit Pydoc (siehe Beispiele unten)
- zusätzliche Doctests für jede Methode
- Implementiere ein "Hauptprogramm"#footnote[```if __name__ == "__main__":```{.py}....] für Testfälle, welche die Spezifikation hinreichend abdecken

== B~~~ Caesar
#v(2mm)
Wir programmieren die Caesar-Chiffre und behandeln ausschließlich Texte aus Kleinbuchstaben ohne Sonderzeichen, Whitespaces, Umlaute, etc.
-- damit es nicht unnötig kompliziert wird.   

- property ```key```{.py}: Schlüssel für die Cäsar-Chiffre
- Schreibe die Klasse ```Caesar```{.py} mit folgenden Methoden:

	- ```python def to_lowercase_letter_only(plaintext:str) -> str:```
	```py
		"""Wandelt den plaintext in Kleinbuchstaben um und entfernt alle Zeichen, die keine 
		Kleinbuchstaben aus dem Bereich [a..z] sind.
		>>> caesar = Caesar()
		>>> caesar.to_lowercase_letter_only("Wandelt den plaintext in Kleinbuchstaben um und 
		entfernt alle Zeichen, die keine Kleinbuchstaben aus dem Bereich [a..z] sind.")
		'wandeltdenplaintextinkleinbuchstabenumundentferntallezeichendiekeinekleinbuchstaben
		ausdembereichazsind'
		"""
	```	
	- ```py def encrypt(plaintext:str, key:str = None) -> str:```  

	```python
		"""key ist ein Buchstabe, der definiert, um wieviele Zeichen verschoben wird. 
		Falls kein key übergeben wird, nimmt übernimmt encrypt den Wert vom Property.
		>>> caesar=Caesar("b")
		>>> caesar.key
		'b'
		>>> caesar.encrypt("hallo")
		'ibmmp'
		>>> caesar.decrypt("ibmmp")
		'hallo'
		>>> caesar.encrypt("hallo", "c")
		'jcnnq'
		>>> caesar.encrypt("xyz", "c")
		'zab'
		"""
	```
	
	- ```py def decrypt(crypttext:str, key:str = None) -> str:``` analog zu ```py encrypt```
	- ```py def crack(crypttext:str, elements:int = 1) -> List[str]:``` berechnet eine Liste mit den wahrscheinlichsten Schlüsseln. Die Länge der Liste wird mit  ```elements```{.py} vorgegeben.#footnote[Tipp: Häufigkeitsanalyse -- Welcher Buchstabe ist im Deutschen der häufigste, welcher der zweithäufigste, etc?] 
	
	```python	 
		 """
        >>> str='Vor einem großen Walde wohnte ein armer Holzhacker mit seiner Frau und seinen 
		zwei Kindern; das Bübchen hieß Hänsel und das Mädchen Gretel. Er hatte wenig zu beißen 
		und zu brechen, und einmal, als große Teuerung ins Land kam, konnte er das tägliche Brot 
		nicht mehr schaffen. Wie er sich nun abends im Bette Gedanken machte und sich vor Sorgen 
		herumwälzte, seufzte er und sprach zu seiner Frau: "Was soll aus uns werden? Wie können 
		wir unsere armen Kinder ernähren da wir für uns selbst nichts mehr haben?"'
        >>> caesar = Caesar()
        >>> caesar.crack(str)
        ['a']
        >>> caesar.crack(str, 100)  # mehr als 26 können es nicht sein.
        ['a', 'j', 'n', 'o', 'e', 'w', 'd', 'q', 'z', 'p', 'i', 'h', 'y', 's', 'k', 'x', 'c', 
			'v', 'g', 'b', 'r', 'l']
        >>> crypted = caesar.encrypt(str, "y")
        >>> caesar.crack(crypted, 3)
        ['y', 'h', 'l']
        """
	```
== C~~~ Vigènere
#v(2mm)
Schreibe die Klasse `Vigènere` mit den selben Methoden zum Ver- und Entschlüsseln wie ```py Caesar```. 
Der ```py key``` ist bei dieser Chiffre ein String.  
Tipp: Benutze die Klasse ```py Caesar```!  

== D~~~ Kasiski
#v(2mm)
Der Kasiski-Test ist ein Verfahren zur Entschlüsselung von Texten, die mit der Vigenère-Chiffre verschlüsselt wurden. 
Wir implementieren die Klasse ```Kasiski```{.py}, die dabei hilft, die Vigenère-Chiffre zu knacken.
Hier gibt es eine Online-Anwendung zum Testen des Verfahrens -- bitte unbedingt ausprobieren: #link("https://www.dominikus-gymnasium.de/kasiski-test-spiel.html")[https://www.dominikus-gymnasium.de/kasiski-test-spiel.html]

Hinweis: wir behandeln wieder ausschließlich Texte aus Kleinbuchstaben ohne Sonderzeichen, Whitespaces, Umlaute, etc.

- ```py __init__(self, crypttext:str="") ```{.py} Initialisiert die Klasse mit dem gegebenen verschlüsselten ```crypttext```
- property ```py crypttext```: zu knackender Text 

- ```py allpos(self, text:str, teilstring:str) -> List[int]```

```python
	"""Berechnet die Positionen von teilstring in text.
    Usage examples:
	>>> k = Kasiski()
	>>> k.allpos("heissajuchei, ein ei", "ei")
	[1, 10, 14, 18]
	>>> k.allpos("heissajuchei, ein ei", "hai")
	[]"""
``` 
Hinweis: PyCharm kann solche Doctests direkt ausführen: Run / Edit Configurations / Add New Configuration – Python Tests / Doctests.  
Die Testfälle erzeugt man interaktiv und kopiert den Text dann ganz einfach in den Docstring.


- ```py alldist(self, text:str, teilstring:str) -> Set[int]```

```python
	"""Berechnet die Abstände zwischen allen Vorkommnissen des Teilstrings im verschlüsselten Text.  
    Usage examples:
    >>> k = Kasiski()
	>>> k.alldist("heissajuchei, ein ei", "ei")
    {4, 8, 9, 13, 17}
    >>> k.alldist("heissajuchei, ein ei", "hai")
    set()"""
``` 

- ```py dist_n_tuple(self, text:str, laenge:int) -> Set[Tuple[str, int]]```
```python
	"""Überprüft alle Teilstrings aus text mit der gegebenen laenge und liefert ein Set 
	mit den Abständen aller Wiederholungen der Teilstrings in text.  
    Usage examples:
	>>> k = Kasiski()
	>>> k.dist_n_tuple("heissajuchei", 2) ==  {('ei', 9), ('he', 9)}
	True
	>>> k.dist_n_tuple("heissajuchei", 3) ==  {('hei', 9)}
	True
	>>> k.dist_n_tuple("heissajuchei", 4) == set()
	True
	>>> k.dist_n_tuple("heissajucheieinei", 2) ==  \
		{('ei', 5), ('ei', 14), ('ei', 3), ('ei', 9), ('ei', 11), ('he', 9), ('ei', 2)}
	True
    """
``` 
- ```py dist_n_list(self, text:str, laenge:int) -> List[int]```
```python
	"""Wie dist_tuple, liefert aber nur eine aufsteigend sortierte Liste der 
	Abstände ohne den Text zurück. 	In der Liste soll kein Element mehrfach vorkommen. 
    Usage examples:
    >>> k = Kasiski()
    >>> Kasiski.dist_n_list("heissajucheieinei", 2)
    [2, 3, 5, 9, 11, 14]
    >>> Kasiski.dist_n_list("heissajucheieinei", 3)
    [9]
    >>> Kasiski.dist_n_list("heissajucheieinei", 4)
    []"""
``` 


- ```py ggt(self, x:int, y:int)->int```  
Benutze den Euklidischen Algorithmus, um den ggt der beiden Zahlen zu berechnen.#footnote[siehe z.B. https://www.geeksforgeeks.org/gcd-in-python/]
```python
	"""Ermittelt den größten gemeinsamen Teiler von x und y.
    Usage examples:
    >>> k = Kasiski()
	>>> k.ggt(10, 25)
    5
    >>> k.ggt(10, 25)
    5"""
```
	
- ```py ggt_count(self, zahlen:List[int])->Counter``` 
Verwende in dieser Methode Pythons `Counter`#footnote[https://realpython.com/python-counter/#getting-started-with-pythons-counter]! Beispiel:
```python
	"""
	>>> from collections import Counter
	>>> c=Counter([5,8,6,5,3,8,5,3,6,5])
	>>> print(c)
	Counter({5: 4, 8: 2, 6: 2, 3: 2})
	>>> c.most_common()
	[(5, 4), (8, 2), (6, 2), (3, 2)]""" 
```	
Implementiere nun die Methode ```py ggt_count(self, zahlen:List[int])->Counter```.  
Wir erhalten damit eine Funktion, die die möglichen Schlüssellängen basierend auf den gemeinsamen Faktoren ermittelt.
```python
	"""Bestimmt die Häufigkeit der paarweisen ggt aller Zahlen aus list. 
    Usage examples:
	>>> k = Kasiski()
	>>> k.ggt_count([12, 14, 16])
	Counter({2: 2, 12: 1, 4: 1, 14: 1, 16: 1})
	>>> k.ggt_count([10, 25, 50, 100])
	Counter({10: 3, 25: 3, 50: 2, 5: 1, 100: 1})
"""
```

- ```py get_nth_letter(self, s:str, start:int, n:int)->str```
```python
	"""Extrahiert aus s jeden n. Buchstaben beginnend mit index start. 
    Usage examples:
	>>> k = Kasiski()
	>>> k.get_nth_letter("Das ist kein kreativer Text.", 1, 4)
	'asektrx'"""
```

- ```py crack_key(len:int)->str```. Liefert den wahrscheinlichsten key zurück. Tipps:
 - ```py crypttext``` (Property!) auf Teilstrings der Länge `len` analysieren
	- mit den bereits implementierten Methoden die wahrscheinliche Länge des Schlüssels ermitteln. 
	- Berechne die einzelnen Buchstaben des Schlüsselwortes mittels Worthäufigkeiten. 

== E~~~ Vigènere
#v(2mm)
Programmiere im Hauptprogramm ein Beispiel, in welchem ein mittels Vigenère-Chiffre verschlüsselter Text geknackt wird.
Als Beispieltext zum Verschlüsseln und Knacken eignet sich z.B. ein längerer Absatz eines Werkes von Projekt-Gutenberg#footnote[https://www.projekt-gutenberg.org/].


