# Tuned Echo Quarto templates: plan

A Quarto extension that turns markdown (with embedded R or Python) into Tuned Echo styled documents: letters, memos, proposals and reports, and slides. One brand file feeds every format.

## Goals

- Write in markdown, embed code when useful, render to the document type of choice.
- Every output uses the Tuned Echo design system: Instrument Serif for display, Plus Jakarta Sans for text, Oswald for labels, cream or white paper, ink text, the seven-bar key strip as the only ornament.
- Print formats go through Typst, not LaTeX. Screen formats go through HTML and reveal.js.
- Brand values live in one place and are copied from the design system's `tokens.json`, never retyped by hand.

## Repository layout

Quarto reads a format name as `<extension>-<base format>`, so `tunedecho-letter-typst` must be an extension called `tunedecho-letter`. The print formats are therefore small extensions of their own that share the files in `tunedecho`.

```
quarto-tunedecho/
  _extensions/
    tunedecho/
      _extension.yml          registers tunedecho-html and tunedecho-revealjs
      _brand.yml              generated from tokens.json
      assets/                 wordmark, seal, key band PNGs
      fonts/                  the three Google fonts, OFL
      typst/
        tokens.typ            generated colors and fonts
        tunedecho.typ         shared styles: palette, key band, strip, eyebrow, footer, base
        page.typ              empty; each format sets its own page
      html/
        tunedecho.scss        HTML theme
        revealjs.scss         slides theme
        _tokens.scss          generated SCSS variables
        _assets.scss          generated data URIs for the marks
        _marks.scss           key strip as SVG
        tokens.css, components.css   copied from the design system
        fonts.html            Google Fonts link
        title-slide.html      reveal.js title slide partial
    tunedecho-letter/         typst-template.typ, typst-show.typ, _extension.yml
    tunedecho-memo/
    tunedecho-report/
  templates/                  letter.qmd, memo.qmd, report.qmd, slides.qmd
  tests/                      render checks
  tools/brand-from-tokens.py
  tuned-echo-design-system/   the exported design system folder
  _quarto.yml                 project file: renders templates/ and tests/ into _output/, sets brand
  README.md
  plan.md
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

`_brand.yml` is generated from `tuned-echo-design-system/tokens.json` by `tools/brand-from-tokens.py`:

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
- YAML fields: `recipient` (name, title, institution, address lines), `date`, `salutation`, `closing`, `signature` (name, title), `contact`, `paper`. (`to` and `from` are reserved by Quarto, so the memo uses `recipient` and `sender`.)

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

## Decisions made while building (2026-10-13)

- Code blocks use the system monospace stack (Menlo, DejaVu Sans Mono). Nothing extra shipped.
- The report has no table of contents by default; `toc: true` adds one after the cover.
- The three fonts ship in `_extensions/tunedecho/fonts/` (about 700 KB) with their OFL files. Typst finds them through `_brand.yml`, so a project must set `brand: _extensions/tunedecho/_brand.yml`.
- HTML and slides place the marks as CSS data URIs generated from the PNGs, so they never depend on file paths at render time.
- The design system folder stays named `tuned-echo-design-system/`.
