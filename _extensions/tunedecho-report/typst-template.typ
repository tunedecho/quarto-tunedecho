$tunedecho.typ()$

// Proposals, statements of work and reports: cover page, running heads, numbered sections.
#let te-report(
  paper: "white",
  title: none,
  subtitle: none,
  doc-type: [Report],
  date: none,
  client: (:),
  prepared-by: [Tuned Echo Systems LLC],
  authors: (),
  toc: false,
  toc_title: none,
  toc_depth: 2,
  sectionnumbering: none,
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
  let wide = te-wide.with(body-width)

  set document(title: if title != none { title } else { doc-type })
  set document(author: authors.map(content-to-string).join(", ")) if authors.len() > 0

  set page(
    paper: "us-letter",
    margin: (left: 0.75in, right: 0.75in + te-extra(body-width), top: 0.9in, bottom: 1.1in),
    fill: te-paper-fill(paper),
    background: te-band(),
    header: context {
      if counter(page).get().first() > 1 {
        wide(te-running-head(c, if title != none { title } else { doc-type }))
      }
    },
    header-ascent: 0.3in,
    footer: context {
      if counter(page).get().first() > 1 {
        wide(te-footer(c, seal: false, descriptor, [Page #counter(page).display()]))
      }
    },
    footer-descent: 0.3in,
  )

  show: te-base.with(c, font: font, heading-font: heading-font, heading-weight: heading-weight, fontsize: fontsize, leading: leading,
                     par-spacing: par-spacing, tracking: tracking,
                     sectionnumbering: sectionnumbering, heading-sizes: (18pt, 14pt, 12pt))

  // Cover page.
  image("wordmark-motto.png", width: 3in)
  v(1.6in)
  te-eyebrow(c, doc-type)
  v(0.4em)
  block(width: 5.5in)[
    #set par(leading: 0.3em)
    #text(font: te-fonts.serif, size: 34pt, weight: 400, fill: c.at("ink"), title)
    #if subtitle != none {
      v(0.5em)
      text(font: te-fonts.sans, size: 14pt, fill: c.at("muted"), subtitle)
    }
  ]
  v(1.1in)
  let cover-field(label, body) = block[
    #set par(leading: 0.5em)
    #te-eyebrow(c, label)
    #v(0.35em)
    #body
  ]
  let fields = ()
  let client-name = client.at("name", default: none)
  if client-name != none {
    let inst = client.at("institution", default: none)
    fields.push(cover-field([Prepared for], if inst != none [#client-name \ #inst] else [#client-name]))
  }
  let by = if authors.len() > 0 [#prepared-by \ #authors.join([, ])] else [#prepared-by]
  fields.push(cover-field([Prepared by], by))
  if date != none { fields.push(cover-field([Date], date)) }
  wide(grid(columns: (1fr,) * fields.len(), column-gutter: 0.4in, ..fields))
  place(bottom + left, image("seal.png", width: 0.8in))
  pagebreak()

  // Contents.
  if toc {
    show outline.entry.where(level: 1): set text(weight: 600, fill: c.at("ink"))
    show outline.entry.where(level: 1): set block(above: 1em)
    outline(
      title: if toc_title == none [Contents] else { toc_title },
      depth: toc_depth,
      indent: 1.2em,
    )
    pagebreak()
  }

  doc
}
