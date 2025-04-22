#let sharepoint = "https://htl3r.sharepoint.com/sites/IT-SYT-BS/Freigegebene%20Dokumente"
#let mainPage = "https://www.htlrennweg.at/"
#let fach = "SYT/BS"
#let schoolyear = "2024/25"

// Define a function that takes filename as a parameter
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
      #v(-10mm)
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