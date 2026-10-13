# Tuned Echo Quarto templates: plan

A Quarto extension that turns markdown (with embedded R or Python) into Tuned Echo styled documents: letters, memos, proposals and reports, and slides. One brand file feeds every format.

## Goals

- Write in markdown, embed code when useful, render to the document type of choice.
- Every output uses the Tuned Echo design system: Instrument Serif for display, Plus Jakarta Sans for text, Oswald for labels, cream or white paper, ink text, the seven-bar key strip as the only ornament.
- Print formats go through Typst, not LaTeX. Screen formats go through HTML and reveal.js.
- Brand values live in one place and are copied from the design system's `tokens.json`, never retyped by hand.

## Repository layout

```
quarto-tunedecho/
  _extensions/tunedecho/
    _extension.yml            registers the formats below
    _brand.yml                colors, fonts, logos (Quarto brand file)
    assets/
      wordmark.png
      wordmark-motto.png
      wordmark-reversed.png
      seal.png
      seal-reversed.png
      seal.svg
      key-band.png
    typst/
      tunedecho.typ           shared Typst styles: fonts, colors, key strip, page geometry
      letter.typ              letterhead first page + continuation pages
      memo.typ
      report.typ              proposals, SOWs, reports with cover page
      typst-template.typ      Quarto entry points (one per format)
      typst-show.typ
    html/
      tunedecho.scss          HTML documents
      revealjs.scss           slides
    fonts/                    optional local copies of the three Google fonts
  templates/
    letter.qmd                starter documents, one per format
    memo.qmd
    report.qmd
    slides.qmd
  design-system/              the exported design system folder (README, tokens.json, components, assets)
  README.md                   install and usage
  plan.md                     this file
```

## Formats

| Format name | Engine | Use |
|---|---|---|
| `tunedecho-letter-typst` | Typst | Letters on letterhead. Recipient block, date, signature from YAML. |
| `tunedecho-memo-typst` | Typst | Internal memos and short notes. Small wordmark, To/From/Date/Re block. |
| `tunedecho-report-typst` | Typst | Proposals, SOWs, reports. Cover page with wordmark-motto and seal, running heads, numbered sections, tables and figures. |
| `tunedecho-html` | HTML | The same report for the web and email. |
| `tunedecho-revealjs` | reveal.js | Slides. Title slide with wordmark and key strip, section slides, closing slide with the seal. |

Later, if needed: `tunedecho-dashboard` (Quarto dashboards) and `tunedecho-invoice-typst`.

## Brand file

`_brand.yml` is filled from `design-system/tokens.json`:

- `color`: `bg`, `paper`, `ink`, `text`, `muted`, `rule`, `rule-soft`, and the seven key colors. Map `foreground` to `text`, `background` to `bg` (screen) or white (print), `primary` to `ink`.
- `typography`: `headings` Instrument Serif 400, `base` Plus Jakarta Sans, `monospace` a plain mono (JetBrains Mono or system mono). Oswald is used only inside the Typst and SCSS files for eyebrow labels.
- `logo`: `small` = `seal.png`, `medium` = `wordmark.png`, `large` = `wordmark-motto.png`, with light/dark variants where the reversed files exist.

Quarto applies `_brand.yml` to HTML, reveal.js, dashboards and Typst automatically; the SCSS and Typst files add what the brand file cannot express (the key strip, the rule between sections, the footer band).

## Letterhead details (Typst)

- US Letter, 0.75in side margins, white paper by default; `paper: cream` switches to `#f6f2ea`.
- First page header: `wordmark-motto.png` at 2.6in wide, left; contact block right-aligned in 9pt, company name semibold in ink.
- Footer: `seal.png` at 0.65in, rule line, "Mission-built software for higher education and publishing" and "Brooklyn, NY".
- Bottom edge: full-bleed key band, 8px tall, square ends, on every page.
- Continuation pages: small `wordmark.png`, running head with recipient, date and page number.
- Body 11pt Plus Jakarta Sans, 1.6 line height.
- YAML fields: `to` (name, title, institution, address lines), `date`, `salutation`, `closing`, `signature` (name, title), `paper`.

## Build order

1. Export the design system folder into `design-system/`.
2. Write `_brand.yml` by reading `tokens.json`; add a small script (`tools/brand-from-tokens.py`) so it can be regenerated.
3. `tunedecho.typ`: fonts, colors, key strip function, page geometry.
4. `letter.typ` and the `tunedecho-letter-typst` format. Render `templates/letter.qmd` and compare against the letterhead on the canvas and `Tuned-Echo-Letterhead.docx`.
5. `memo.typ`, `report.typ` and their formats.
6. `tunedecho.scss` and the HTML format.
7. `revealjs.scss` and the slides format.
8. README: install (`quarto add tunedecho/quarto-tunedecho`), one example per format.

## Decisions

- Typst over LaTeX for print: faster, easier to style, matches the design system directly.
- Fonts load from Google Fonts for HTML. For Typst, install the three fonts locally or keep copies in `fonts/` and point Typst at them, so renders match on every machine.
- Marks are image files, never redrawn in Typst or CSS; the wordmark in HTML and slides may be live type, as on tunedecho.com.
- Key colors are for the strip, markers and chart series in strip order, never for text or backgrounds.

## Open questions

- Which mono font for code blocks.
- Whether the report format needs a table of contents by default.
- Whether to ship the fonts in the repo (license allows it; adds about 1 MB).
