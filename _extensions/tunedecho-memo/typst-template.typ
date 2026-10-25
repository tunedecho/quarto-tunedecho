$tunedecho.typ()$

// Internal memo: small wordmark, To/From/Date/Re block, body.
#let te-memo(
  paper: "white",
  title: none,
  date: none,
  recipient: (),
  sender: (),
  cc: (),
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

  set document(title: if title != none [Memo: #title] else [Memo])

  set page(
    paper: "us-letter",
    margin: (left: 0.75in, right: 0.75in + te-extra(body-width), top: 0.8in, bottom: 1.1in),
    fill: te-paper-fill(paper),
    background: te-band(),
    header: context {
      if counter(page).get().first() > 1 {
        let parts = ([Memo],)
        if title != none { parts.push(title) }
        parts.push([Page #counter(page).display()])
        wide(te-running-head(c, parts.join([ · ])))
      }
    },
    header-ascent: 0.25in,
    footer: wide(te-footer(c, seal: false, descriptor, location)),
    footer-descent: 0.3in,
  )

  show: te-base.with(c, font: font, heading-font: heading-font, heading-weight: heading-weight, fontsize: fontsize, leading: leading,
                     par-spacing: par-spacing, tracking: tracking,
                     section-rules: false, heading-sizes: (14pt, 12.5pt, 12pt))

  image("wordmark.png", width: 1.6in)
  v(0.3in)
  te-eyebrow(c, [Memorandum])
  v(0.5em)

  let field(label, value) = te-field(c, label, value)
  let joined(xs) = xs.join([, ])
  block(below: 0.6em)[
    #set par(leading: 0.5em)
    #stack(
      spacing: 0.55em,
      ..(
        if recipient.len() > 0 { (field([To], joined(recipient)),) } else { () },
        if sender.len() > 0 { (field([From], joined(sender)),) } else { () },
        if cc.len() > 0 { (field([Cc], joined(cc)),) } else { () },
        if date != none { (field([Date], date),) } else { () },
        if title != none { (field([Re], text(weight: 600, fill: c.at("ink"), title)),) } else { () },
      ).flatten()
    )
  ]
  wide(line(length: 100%, stroke: 1.5pt + c.at("rule")))
  v(0.6em)

  doc
}
