$tokens.typ()$

// Tuned Echo shared Typst styles. Included by every print format.
// Colors and fonts come from tokens.typ, generated from the design system.

// Pick the palette for a paper stock: "white" (default), "cream", or "ink".
#let te-palette(paper) = {
  if paper == "ink" { te-dark } else { te-light }
}

#let te-paper-fill(paper) = {
  if paper == "cream" { te-light.at("bg") }
  else if paper == "ink" { te-dark.at("bg") }
  else { te-light.at("paper-print") }
}

// The full-bleed key band along the bottom edge of every page. 8px = 1/12in = 6pt.
#let te-band(height: 6pt) = {
  place(bottom + left, dx: 0pt, dy: 0pt,
    image("key-band.png", width: 100%, height: height, fit: "stretch"))
}

// Seven pill bars at column width: the section rule.
#let te-strip(c, height: 3pt, gap: 4pt) = {
  grid(
    columns: (1fr,) * 7,
    column-gutter: gap,
    ..te-key-order.map(k => box(width: 100%, height: height, radius: height / 2, fill: c.at(k)))
  )
}

// A small condensed uppercase label (the Eyebrow component).
#let te-eyebrow(c, body, size: 8.5pt, fill: none) = {
  let f = if fill == none { c.at("muted") } else { fill }
  text(font: te-fonts.cond, size: size, weight: 400, tracking: 0.18em, fill: f, upper(body))
}

// print-small: contact block, running heads and footers. 9pt, never smaller.
#let te-small(c, body, fill: none) = {
  let f = if fill == none { c.at("muted") } else { fill }
  text(font: te-fonts.sans, size: 9pt, fill: f, body)
}

#let te-hairline(c) = line(length: 100%, stroke: 0.75pt + c.at("rule"))

// Page width between the 0.75in print margins on US Letter.
#let te-full-width = 7in

// The text column is narrower than the page furniture. The page's right margin
// absorbs the difference; te-wide lets headers, footers and the letterhead run
// back out to the full width.
#let te-extra(body-width) = calc.max(0pt, te-full-width - body-width)
#let te-wide(body-width, body) = pad(right: -te-extra(body-width), body)

// Running head on continuation pages: small wordmark left, a line of text right.
#let te-running-head(c, right-text) = {
  grid(
    columns: (auto, 1fr),
    align: (left + horizon, right + horizon),
    image("wordmark.png", width: 1.05in),
    te-small(c, right-text),
  )
}

// Footer: optional seal, a rule, then descriptor left and a line right.
#let te-footer(c, seal: false, left-text, right-text) = {
  let strip = {
    te-hairline(c)
    v(4pt)
    grid(
      columns: (1fr, auto),
      align: (left, right),
      te-small(c, left-text),
      te-small(c, right-text),
    )
  }
  if seal {
    grid(
      columns: (auto, 1fr),
      column-gutter: 10pt,
      align: (left + horizon, left + horizon),
      image("seal.png", width: 0.65in),
      strip,
    )
  } else {
    strip
  }
}

// Base document styles shared by every print format.
#let te-base(
  c,
  font: none,
  heading-font: none,
  heading-weight: auto,
  fontsize: 12pt,
  leading: 0.7em,
  par-spacing: 1.35em,
  tracking: 0pt,
  sectionnumbering: none,
  heading-sizes: (16pt, 13.5pt, 12pt),
  section-rules: true,
  doc,
) = {
  let body-font = if font == none { te-fonts.body } else { font }
  set text(font: body-font, size: fontsize, fill: c.at("text"), tracking: tracking, lang: "en", region: "US")
  set par(justify: false, leading: leading, spacing: par-spacing)
  set heading(numbering: sectionnumbering)

  // Section headings: the heading sans at regular weight, ink. Size and the change
  // of face mark the heading; if body and headings share a face, semibold does.
  // Instrument Serif is a condensed display face, kept for titles only.
  let head-font = if heading-font == none { te-fonts.heading } else { heading-font }
  let head-weight = if heading-weight != auto { heading-weight } else if head-font == body-font { 600 } else { 400 }
  show heading: set text(font: head-font, weight: head-weight, fill: c.at("ink"))
  show heading: set block(above: 1.6em, below: 0.8em)
  show heading.where(level: 1): set text(size: heading-sizes.at(0))
  show heading.where(level: 2): set text(size: heading-sizes.at(1))
  show heading.where(level: 3): set text(size: heading-sizes.at(2))
  show heading.where(level: 1): it => {
    if section-rules {
      v(0.6em, weak: true)
      line(length: 100%, stroke: 1.5pt + c.at("rule"))
      v(0.1em)
    }
    it
  }

  // Emphasis and strong.
  show strong: set text(weight: 600)

  // Links: ink, underlined with a soft rule.
  show link: it => underline(stroke: 0.6pt + c.at("rule"), offset: 2pt, text(fill: c.at("ink"), it))

  // Code.
  show raw: set text(font: te-fonts.mono, size: 0.88em)
  show raw.where(block: true): set block(
    fill: c.at("paper"), stroke: 0.75pt + c.at("rule-soft"),
    inset: 9pt, radius: 0pt, width: 100%,
  )

  // Lists.
  set list(marker: text(fill: c.at("ink"))[•], indent: 0.4em, body-indent: 0.6em)
  set enum(indent: 0.4em, body-indent: 0.6em)

  // Tables: no vertical rules, an ink rule under the header, soft rules between rows.
  set table(
    inset: (x: 8pt, y: 6pt),
    stroke: (x, y) => (
      bottom: if y == 0 { 1pt + c.at("ink") } else { 0.5pt + c.at("rule-soft") },
    ),
  )
  show table.cell.where(y: 0): set text(weight: 600, fill: c.at("ink"))
  // Keep a table whole on one page rather than splitting it after a row or two.
  show table: it => block(breakable: false, it)

  // Figures and tables sit on the left edge of the column, as the text does.
  show figure: set align(left)
  show figure.caption: set text(font: te-fonts.sans, size: 9pt, fill: c.at("muted"))
  show figure.caption: set align(left)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: [Table])

  // Block quotes and rules.
  show quote.where(block: true): set block(inset: (left: 12pt), stroke: (left: 1.5pt + c.at("rule")))
  show quote.where(block: true): set text(fill: c.at("muted"))

  doc
}

// A labeled block, as in a memo header: eyebrow label, then value.
#let te-field(c, label, value) = {
  grid(
    columns: (0.9in, 1fr),
    align: (left + top, left + top),
    te-eyebrow(c, label, fill: c.at("ink")),
    text(fill: c.at("text"), value),
  )
}
