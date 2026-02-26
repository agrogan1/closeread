// Some definitions presupposed by pandoc's typst output.
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let d = (:)
  let fields = old_block.fields()
  fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  return block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subrefnumbering: "1a",
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => numbering(subrefnumbering, n-super, quartosubfloatcounter.get().first() + 1))
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => {
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          }

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let old_title = old_title_block.body.body.children.at(2)

  // TODO use custom separator if available
  let new_title = if empty(old_title) {
    [#kind #it.counter.display()]
  } else {
    [#kind #it.counter.display(): #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block, 
    block_with_new_content(
      old_title_block.body, 
      old_title_block.body.body.children.at(0) +
      old_title_block.body.body.children.at(1) +
      new_title))

  block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color, 
        width: 100%, 
        inset: 8pt)[#text(icon_color, weight: 900)[#icon] #title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}

#let report(title: none, date: none, content) = {
  set page(
    width: 48in,   // Custom width
    height: 36in, // Custom height (Quarto size example)
    margin: (top: 1in, bottom: 1in, x: 1in),
    columns: 2
  )
  // other potential setup here
  content
}

#set page(
  paper: "us-letter",
  margin: (x: 1.25in, y: 1.25in),
  numbering: "1",
)

#show: doc => article(
  title: [Positive and Negative Parenting, and Child Development Outcomes],
  subtitle: [Variation, Commonality and Possible Universals Across Multiple Countries],
  authors: (
    ( name: [Andy Grogan-Kaylor],
      affiliation: [],
      email: [] ),
    ),
  date: [2026-02-26],
  toc_title: [Table of contents],
  toc_depth: 3,
  cols: 1,
  doc,
)

= The Scope of the Issue
<the-scope-of-the-issue>
#block[
- UNICEF considers children globally to be in crisis: political violence, climate change, and poverty affect many children,
- In this time of crisis, parenting is one crucial area of focus.
- According to UNICEF data, $1 / 3$ of children are subject to physical punishment; $2 / 3$ to some form of violent punishment.
- In a review of 50 years of literature on physical punishment, #cite(<Gershoff2016>, form: "prose") connect physical punishment to poor mental health outcomes, and other poor outcomes over the life course. #cite(<Ward2023>, form: "prose") examines the relationship of multiple forms of parental discipline to child outcomes.

]
= Both Universals and Variation Are Important
<both-universals-and-variation-are-important>
#quote(block: true)[
"Despite the incredible diversity existing among and within human cultures, there are many phenomena that occur regularly in all known societies. These commonalities, or universals, while deriving in part from human nature, may also have specific social, cultural, and systemic sources. We need to develop a working understanding of these universals so that we might advance legitimate, empirically based human science set on creating knowledge that is politically relevant to fostering real solutions to the problems that complicate human co-existence in the Age of the Anthropocene." @Antweiler2016
]

= Universals and Variation (2)
<universals-and-variation-2>
#quote(block: true)[
"#cite(<Hanel2019>, form: "prose") cite research suggesting that 'highlighting similarities between groups improves interpersonal and intergroup attitudes.' Others have argued that 'build\[ing\] bonds of commonality across our differences' might be an impetus for social transformation @Hunt-Hendrix2024."
]

= Data
<data>
MICS data collected by UNICEF from Low and Middle Income Countries (LMIC) around the world. $N = 224 \, 647 upright(" families") ; N_(c o u n t r i e s) = 60$

= Parenting Behaviors Vary #emph[Somewhat]
<parenting-behaviors-vary-somewhat>
Verbal reasoning (78%) and shouting (64%) are the most common parental discipline behaviors toward young children.

#bibliography("positive-and-negative-parenting.bib")

