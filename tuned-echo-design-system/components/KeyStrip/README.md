# KeyStrip

The seven pill-shaped bars, the brand's only ornament.

**Markup:** `<div class="te-bars" aria-hidden="true">` (under the wordmark) or `<div class="te-rule" aria-hidden="true">` (section divider), each holding seven empty `<i></i>`. The container sets the width.

- Always seven bars, always in order: `key-pink`, `key-orange`, `key-yellow`, `key-green`, `key-blue`, `key-purple`, `key-ink`.
- Bars are equal, pill-ended (`radius-pill`) and evenly gapped. Do not reorder, recolor, skip or animate them.
- Use `te-rule` between major sections, at full column width. Not between every block.
- In print, the strip runs full-bleed along the bottom edge of the page (`key-band.png`), square-ended.
- Decorative: always `aria-hidden="true"`.
