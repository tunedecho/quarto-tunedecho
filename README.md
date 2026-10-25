# quarto-tunedecho

Quarto formats that turn markdown, with embedded R or Python when you want it, into Tuned Echo documents: letters on letterhead, memos, proposals and reports, HTML pages and reveal.js slides. Every format reads the same brand values, generated from the design system's `tokens.json`.

| Format | Engine | Use |
|---|---|---|
| `tunedecho-letter-typst` | Typst | Letters on letterhead. Recipient block, date, signature from YAML. |
| `tunedecho-memo-typst` | Typst | Internal memos. Small wordmark, To/From/Cc/Date/Re block. |
| `tunedecho-report-typst` | Typst | Proposals, statements of work, reports. Cover page, running heads, numbered sections. |
| `tunedecho-html` | HTML | The same report for the web. |
| `tunedecho-revealjs` | reveal.js | Slides. Wordmark title slide, section slides, a closing slide with the seal. |

## Install

Quarto 1.6 or later. All fonts ship inside the extension, so nothing needs installing.

```bash
quarto add tunedecho/quarto-tunedecho
```

This installs four folders under `_extensions/`: `tunedecho` (shared styles, fonts, assets, the HTML and slide formats) and `tunedecho-letter`, `tunedecho-memo`, `tunedecho-report` (the print formats). Keep them together.

Then point your project at the brand file, in `_quarto.yml`:

```yaml
brand: _extensions/tunedecho/_brand.yml
```

That one line gives Typst the fonts and HTML the colors. If you render single files without a project, add the same `brand:` line to the document's YAML instead.

Starter documents are in `templates/`. Copy one next to your `_extensions/` folder and edit.

## Letter

```yaml
---
format: tunedecho-letter-typst
date: today
recipient:
  name: Dr. Jane Example
  title: Dean of Libraries
  institution: Example University
  address:
    - 100 College Avenue
    - Anytown, NY 10000
salutation: Dear Dr. Example,
closing: Sincerely,
signature:
  name: Matt Crump
  title: Founder, Tuned Echo Systems LLC
paper: white
---
```

The first page carries the full letterhead: wordmark with motto, contact block, seal in the footer, the key band along the bottom edge. Later pages get a small wordmark and a running head with the recipient, date and page number. `paper: cream` switches to cream stock. `salutation` defaults to "Dear {recipient name},".

The contact block prints placeholders until you fill it in. Set it once in `_quarto.yml` so every letter picks it up:

```yaml
contact:
  name: Tuned Echo Systems LLC
  lines:
    - 123 Example Street
    - Brooklyn, NY 11201
    - hello@tunedecho.com
    - tunedecho.com
```

## Memo

```yaml
---
format: tunedecho-memo-typst
title: Catalog migration, week two
date: today
recipient: [Cataloging team, Dr. Jane Example]
sender: Matt Crump
cc: Library IT
---
```

`title` becomes the Re line. `recipient`, `sender` and `cc` take a string or a list.

## Report, proposal, statement of work

```yaml
---
format: tunedecho-report-typst
title: A single view of the catalog.
subtitle: Proposal and statement of work for Example University Libraries
doc-type: Proposal
date: today
client:
  name: Dr. Jane Example, Dean of Libraries
  institution: Example University
author: Matt Crump
toc: false
---
```

Use `date-text: "[Date]"` in place of `date` for a placeholder or any wording Quarto should not parse as a date. The cover shows the wordmark with motto, the `doc-type` eyebrow, the title, and "Prepared for / Prepared by / Date" blocks, with the seal at the foot. Sections are numbered by default (`number-sections: false` turns it off). `toc: true` adds a contents page after the cover. Tables, figures, cross-references and callouts work as in any Quarto document.

## HTML and slides

```yaml
format: tunedecho-html
```

```yaml
format: tunedecho-revealjs
```

Level-one headings (`#`) make section slides. A slide with the class `{.te-closing}` shows the seal above its heading. The design system's component classes (`te-eyebrow`, `te-notice`, `te-step`, `te-principle`, `te-rule`) are loaded in both HTML formats, so fenced divs such as `::: {.te-notice}` work.

## Brand values

Never retype a color or a font name. Edit `tuned-echo-design-system/tokens.json` and regenerate:

```bash
python3 tools/brand-from-tokens.py
```

The script writes `_brand.yml`, the Typst constants (`typst/tokens.typ`), the SCSS variables (`html/tokens.scss`), the marks as CSS data URIs (`html/_assets.scss`), and copies `tokens.css` and the component CSS into the extension.

## Repository layout

```
_extensions/
  tunedecho/            shared: _brand.yml, assets/, fonts/, typst/ (tokens.typ, tunedecho.typ), html/ (themes), HTML + reveal formats
  tunedecho-letter/     letter format (typst-template.typ, typst-show.typ)
  tunedecho-memo/       memo format
  tunedecho-report/     report format
templates/              starter documents, one per format
tests/                  render checks (a two-page letter on cream, a Figtree letter)
tools/brand-from-tokens.py
tuned-echo-design-system/   the exported design system (source of truth)
```

Render everything in this repository with `quarto render`; outputs land in `_output/`.

## Type

Running text is set in **Newsreader**, a clean text serif, at 12pt in print with open paragraph spacing and a 6.25in text column (about 75 characters a line). Section headings use Figtree at regular weight. Instrument Serif, the wordmark's face, is kept for titles: the report cover, the web page title and slides. Plus Jakarta Sans is kept for small text only: the contact block, running heads, footers and captions. Oswald is for uppercase labels.

**Figtree** is also the sans alternative for body text (headings then switch to semibold so they still stand out). Choose it per document, or in `_quarto.yml` for a whole project:

```yaml
mainfont: Figtree
fontsize: 11pt
leading: 0.75em
```

The print formats (letter, memo, report) accept these options:

| Option | Default | Meaning |
|---|---|---|
| `mainfont` | Newsreader | Body typeface. `Figtree` and `Plus Jakarta Sans` are also shipped. |
| `headingfont` | Figtree | Section heading typeface. |
| `headingweight` | `400` | Heading weight. `600` when body and headings share a face. |
| `fontsize` | `12pt` | Body size. Use `11pt` with Figtree. |
| `leading` | `0.7em` | Space between lines. |
| `par-spacing` | `1.35em` | Space between paragraphs. |
| `body-width` | `6.25in` | Width of the text column. `7in` fills the page between the margins. |

HTML and slides use Newsreader for running text as well, loaded from Google Fonts.

## Fonts

Newsreader, Figtree, Instrument Serif, Plus Jakarta Sans and Oswald are included under `_extensions/tunedecho/fonts/` with their SIL Open Font License files. Typst finds them through the brand file. HTML and slides load the same families from Google Fonts. Code uses the system monospace (Menlo, DejaVu Sans Mono).
