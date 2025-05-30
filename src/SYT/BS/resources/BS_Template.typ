
#import "@preview/numbly:0.1.0": numbly
#let sharepoint = "https://htl3r.sharepoint.com/sites/IT-SYT-BS/Freigegebene%20Dokumente"
#let mainPage = "https://www.htlrennweg.at/"
#let fach = "SYT/BS"
#let schoolyear = "2024/25" 

#let create_page_template(filename) = {
  let uebungsName = filename.split("_").slice(1).join(" ")
  let uebungsNummer = filename.slice(0, 2)


  (
    header: [
      #table(
        columns: (50%, 50%), rows: (90pt), stroke: none, align: (left, right),  
        image("htl3r_logo.jpg"),
        [#link(sharepoint)[
                #text(weight: "bold", size: 1.2em, fach + ": " + uebungsName)
              ]
              #v(-4mm)
              #text("Übungsblatt " + uebungsNummer)
              #v(-3mm)
              #text(size: 0.9em, "Schuljahr " + schoolyear + " an der")
              #link(mainPage)[
                #text(size: 0.9em, "HTL Wien 3 Rennweg")
              ]
              #v(-3mm)
              #link(mainPage)[
                #text(size: 0.9em, "Rennweg 89b, 1030 Wien")
                
              ]
              ]
      )
      
      #line(length: 100%)
      
    ],
    footer: [
      #line(length: 100%)
      #table(
          columns: (50%, 50%), rows: (auto), align: (left, right), stroke: none,
          [#text("Version vom 25. März 2025")],
          [#context [#here().page()]/#context[#counter(page).final().at(0)]]
      ),
    ]
  )
}

#let template(doc) = [
  #show "ORDNER_XXXX": [xxxx_YYNextYY_HTL3R]
  #show "XXXX": [Setzen Sie hier Ihre Eduvidual-Kennung ein. z.B. `1234`]
  #show "|YYYY|": it => datetime.today().display("[year]")
  #show "YY": it => datetime.today().display("[year repr:last_two]")
  #show "__YY__": it => datetime.today().display("[year repr:last_two]")
  #show "|LastYYYY|": it => (datetime.today() - duration(days: 366)).display("[year]")
  #show "LastYY": it => (datetime.today() - duration(days: 366)).display("[year repr:last_two]")
  #show "|NextYYYY|": it => (datetime.today() + duration(days: 366)).display("[year]")
  #show "NextYY": it => (datetime.today() + duration(days: 366)).display("[year repr:last_two]")
  #show ">>AP<<": [Ersetzen Sie `##` durch Ihre Eduvidual-Kennung modulo 100. d.h. die letzten 2 Stellen der Eduvidual-Kennung ohne führende 0 -- z.B.: 9901 durch 1]
  #show ">>SHOW_TEACHER<<": [Fügen Sie einen Screenshot in Ihr Protokoll ein und zeigen Sie Ihrem Lehrer, dass Sie diesen Punkt gelöst haben!]
  #show ">>SSMOODLE<<": [Fügen Sie einen Screenshot in Ihr Protokoll ein und laden Sie diesen in Eduvidual hoch!]
  #show ">>SSPROTOKOLL<<": [Fügen Sie einen Screenshot in Ihr Protokoll ein!]
  #show "SSMOODLE": [Fügen Sie einen Screenshot in Ihr Protokoll ein und laden Sie diesen in Eduvidual hoch!]
  #show "__JUCHHEISSA__": [Hurra, gefunden!]
  #show "__NEUEDATEI__": [Datei99]
  #show "__ZEFIX__": [Oje, IHR VORNAME hat nichts gefunden!]
  #show "SSPROTOKOLL": [Fügen Sie einen Screenshot in Ihr Protokoll ein!]
  #show ">>HEUTIGER_DATUMSSTRING<<": it => datetime.today().display("Heute ist [weekday], der [day]. [month]. [year].")
  #doc
]


 #let my_box(title, body) = {
    box(stroke: 1pt, outset: 4pt, title)
}



//Nummerierung (1) - a) 
#let q-counter = counter("count")
#let count(body) = {
  set enum(
    full: true,
    numbering: numbly("{1:(1)}", "{2:a})"),
  )
  q-counter.step()
  context enum(
    start: q-counter.get().first(), 
    body
  )
}
//Nummerierung (1) - a. - i
#let q-counter = counter("count")
#let count1(body) = {
  set enum(
    full: true,
    numbering: numbly("{1:(1)}", "{2:a.}", "{3:i.}", "{4:1.}"),
  )
  q-counter.step()
  context enum(
    start: q-counter.get().first(), 
    body
  )
}

//Nummerierung (1) - 1. 
#let q-counter = counter("count")
#let count2(body) = {
  set enum(
    full: true,
    numbering: numbly("{1:(1)}", "{2:1.}"),
  )
  q-counter.step()
  context enum(
    start: q-counter.get().first(), 
    body
  )
}

//Nummerierung a.) 
#let q-counter = counter("count4")
#let count4(body) = {
  set enum(
    full: true,
    numbering: numbly("{1:a.}"),
  )
  q-counter.step()
  context enum(
    start: q-counter.get().first(), 
    body
  )
}

//Nummerierung (1) - (a) 
#let q-counter = counter("count")
#let count5(body) = {
  set enum(
    full: true,
    numbering: numbly("{1:(1)}", "({2:a})"),
  )
  q-counter.step()
  context enum(
    start: q-counter.get().first(), 
    body
  )
}

//Nummerierung (1) - a.
#let q-counter = counter("count")
#let count6(body) = {
  set enum(
    full: true,
    numbering: numbly("{1:(1)}", "{2:a.}"),
  )
  q-counter.step()
  context enum(
    start: q-counter.get().first(), 
    body
  )
}

