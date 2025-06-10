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