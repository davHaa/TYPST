#let sharepoint = "https://htl3r.sharepoint.com/sites/IT-SYT-BS/Freigegebene%20Dokumente"
#let mainPage = "https://www.htlrennweg.at/"
#let filename = "dateiNameEingeben"
#let prefix = str.slice(filename, 0, 2)



#let page_template = (
  header: [
    #table(
      columns: (50%, 50%), rows: (90pt), stroke: none, align: (left, right),
      image("htl3r_logo.jpg"),
      [#link(sharepoint)[
              #text(weight: "bold", size: 1.2em, "SYT/BS: Windows Erstinstallation")
            ]
            #v(-4mm)
            #text("Übungsblatt " + prefix)
            #v(-3mm)
            #text(size: 0.9em, "Schuljahr 2024/25 an der ")
            #link(mainPage)[
              #text(size: 0.9em, "HTL Wien 3 Rennweg")
            ]
            #v(-3mm)
            #link(mainPage)[
              #text(size: 0.9em, "Rennweg 89b, 1030 Wien")
            ]]
    )
    #line(length: 100%)
    #v(-10mm)
  ],
  footer: [
    #line(length: 100%)
    #table(
      columns: (50%, 50%), rows:(auto), align: (left, right), stroke: none,
      [Version vom 25. März 2025],
      [test]
    )
  ]
)
