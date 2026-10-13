Tuned Echo Systems builds mission-fit software for universities, publishers and research organizations, and teaches the methods to build it yourself. The look is a letterhead: cream paper, a wordmark first, and seven colored bars as the only ornament. Everything else is type, rules and space.

## Names and lines

- Legal name: **Tuned Echo Systems LLC**. Everyday name: **Tuned Echo**. Write "Tuned Echo Systems" on first mention in formal documents, "Tuned Echo" after.
- Website tagline: "Tuning your systems to echo your mission". Logo motto: "We tune your systems until they echo your mission." Use the tagline on the web and in headers; the motto appears only as part of `wordmark-motto.png`.
- Descriptor: "Mission-built software for higher education and publishing" (seal, letterhead footer).
- Location: "Brooklyn, New York" in prose, "Brooklyn, NY" in compact lines.

## Voice

- Plain words, short sentences, active voice. Say what is built and what the client gets: "A working prototype of your own workflow in weeks."
- "We" for the company, "you" and "your" for the client. Speak to institutions as peers, from inside academic work, never as a vendor pitching.
- Headings are one sentence and end with a period: "Prototypes that show the institution to itself." Eyebrows and buttons are sentence case, no period.
- Name the method in its four movements, always in order: **Listen, Trace, Tune, Echo**.
- Concrete over grand: name the catalog, the department, the accreditation standard. No buzzwords, hype, exclamation marks or emoji.

## Logos

- **Wordmark**: "Tuned" roman, "Echo" italic, both Instrument Serif, with the key strip under it. On screen set it in live type (see the Wordmark component). Elsewhere use `wordmark.png` (with strip), `wordmark-motto.png` (strip and motto, for letterhead and covers) or `wordmark-reversed.png` (cream ink, for `ink` grounds).
- **Seal**: a tuning fork in a ring reading "Tuned Echo Systems · Mission-built software · Brooklyn, NY". It is the secondary mark: favicons, footers, stickers, the hero beside the wordmark, the back of a deck. Use `seal.png` (ink) or `seal-reversed.png` (cream). Minimum 0.5in in print, 48px on screen.
- Never stretch, recolor, outline, or add effects to either mark. Never put the wordmark and seal side by side at the same size; one leads.

## Color

- Ground: `bg` (cream) on screen, `paper-print` (white) for print by default. Raise panels with `paper`.
- Text: headings and marks in `ink`, running text in `text`, secondary text in `muted`. Text on an ink fill uses `on-ink`.
- The seven key colors (`key-pink` through `key-purple`, plus `key-ink`) are an identity, not a palette. Use them in the key strip, as small markers (dots, pills) and as chart series in strip order. Never for text, buttons, backgrounds or large fills. `key-yellow` reads at 1.9:1 on cream, so pair every colored mark with a label.
- Dividers: `rule` for step rules and dashed notices, `rule-soft` for panel edges. No shadows anywhere; separate with rules and space.
- The Ink theme swaps `bg` and `ink`; `key-ink` follows `ink`, so the seventh bar turns cream on dark.
- Focus: a 2px solid `focus` (key blue) outline, offset 3px, on every interactive element.

## Type

- **Instrument Serif** (`serif`): the wordmark, headings (`display`, `title`), statements and principle lead-ins. Regular weight only; italic for "Echo" and for emphasis within headings.
- **Plus Jakarta Sans** (`sans`): everything you read, `body` at 17px with 1.6 line height on screen, `print-body` at 15px in print. Medium (500) for the tagline and nav, semibold (600) for buttons and the company name.
- **Oswald** (`cond`): uppercase labels only, `eyebrow` and `banner`, with wide tracking. Never for headings or sentences.
- All three load from Google Fonts: `https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Oswald:wght@400;500&family=Plus+Jakarta+Sans:wght@400;500;600&display=swap`. In Word documents the body falls back to Calibri; marks are images, so they never depend on installed fonts.
- Keep running text within `measure` (38rem). Balance headings (`text-wrap: balance`).

## Layout and spacing

- Screen pages sit in a centered column of `page-max` (68rem) with a 16–40px gutter. Sections get `space-22` vertical padding and are divided by a full-width key rule.
- Grids are auto-fit: two columns for services, four for the method, three for principles. Gaps are `space-8` to `space-16`.
- Print pages use `print-margin` (0.75in) on the sides. The first page carries the full letterhead; following pages a small wordmark and running head.
- Corners are square (`radius-0`) for panels and notices, round (`radius-pill`) for bars, markers and buttons. Nothing in between.

## Imagery and motion

- No stock photos, illustrations or icon sets. Visuals are the marks, real screenshots of working systems, and charts.
- Charts use the key colors in strip order, label every series directly, and show where numbers come from.
- Motion appears only on the website seal: the fork is struck on load and every 15 seconds. Honor `prefers-reduced-motion`. Documents and slides are still.

## Components

Load `tokens.css`, the Google Fonts link, and `components/bundle.css`; then use the `te-` classes: Wordmark, KeyStrip (`te-bars`, `te-rule`), Button (`te-btn primary|ghost`), Eyebrow, MethodStep, Principle, Notice (`te-notice`, `te-banner`), and the print Letterhead. Each component's guide gives its markup.
