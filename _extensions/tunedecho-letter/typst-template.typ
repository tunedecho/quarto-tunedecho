$tunedecho.typ()$

// Letter on Tuned Echo letterhead.
#let te-letter(
  paper: "white",
  date: none,
  recipient: (:),
  salutation: none,
  closing: [Sincerely,],
  signature: (:),
  contact: (:),
  descriptor: [Mission-built software for higher education and publishing],
  location: [Brooklyn, NY],
  font: none,
  heading-font: none,
  heading-weight: auto,
  fontsize: 12pt,
  leading: 0.7em,
  par-spacing: 1.35em,
  tracking: 0pt,
  body-width: 6.25in,
  doc,
) = {
  let c = te-palette(paper)
  let to-name = recipient.at("name", default: none)
  let sig-name = signature.at("name", default: none)
  let wide = te-wide.with(body-width)

  set document(title: if to-name != none [Letter to #to-name] else [Letter])
  set document(author: content-to-string(sig-name)) if sig-name != none

  set page(
    paper: "us-letter",
    margin: (left: 0.75in, right: 0.75in + te-extra(body-width), top: 0.8in, bottom: 1.3in),
    fill: te-paper-fill(paper),
    background: te-band(),
    header: context {
      if counter(page).get().first() > 1 {
        let parts = ()
        if to-name != none { parts.push(to-name) }
        if date != none { parts.push(date) }
        parts.push([Page #counter(page).display()])
        wide(te-running-head(c, parts.join([ · ])))
      }
    },
    header-ascent: 0.25in,
    footer: context {
      wide(te-footer(c, seal: counter(page).get().first() == 1, descriptor, location))
    },
    footer-descent: 0.3in,
  )

  show: te-base.with(c, font: font, heading-font: heading-font, heading-weight: heading-weight, fontsize: fontsize, leading: leading,
                     par-spacing: par-spacing, tracking: tracking)

  // Letterhead: wordmark with motto left, contact block right, at full width.
  wide(grid(
    columns: (1fr, auto),
    align: (left + top, right + top),
    image("wordmark-motto.png", width: 2.6in),
    block[
      #set par(leading: 0.55em)
      #set align(right)
      #te-small(c)[
        #text(weight: 600, fill: c.at("ink"), contact.at("name", default: [Tuned Echo Systems LLC])) \
        #contact.at("lines", default: ()).join(linebreak())
      ]
    ],
  ))
  v(0.4in)

  // Date and recipient.
  if date != none {
    block(below: 1.4em, date)
  }
  let lines = ()
  if to-name != none { lines.push(to-name) }
  if recipient.at("title", default: none) != none { lines.push(recipient.title) }
  if recipient.at("institution", default: none) != none { lines.push(recipient.institution) }
  for line in recipient.at("address", default: ()) { lines.push(line) }
  if lines.len() > 0 {
    block(below: 1.4em)[
      #set par(leading: 0.55em)
      #lines.join(linebreak())
    ]
  }

  // Salutation.
  if salutation != none {
    block(below: par-spacing, salutation)
  } else if to-name != none {
    block(below: par-spacing)[Dear #to-name,]
  }

  doc

  // Closing and signature.
  if closing != none {
    v(0.4em)
    block(below: 0.5in, closing)
  }
  if sig-name != none {
    block[
      #set par(leading: 0.55em)
      #text(weight: 600, fill: c.at("ink"), sig-name)
      #if signature.at("title", default: none) != none [
        \ #text(fill: c.at("muted"), signature.title)
      ]
    ]
  }
}
