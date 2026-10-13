# Wordmark

The "Tuned *Echo*" lockup set in live type, with the seven-bar key strip beneath it.

**Markup the consumer provides:** `<a class="te-wordmark" style="font-size:…"><span class="wm-text">Tuned <em>Echo</em></span><span class="te-bars" aria-hidden="true">` plus seven empty `<i></i>`, closing `</span></a>`. Everything scales from the `font-size` you set on `.te-wordmark`.

- "Tuned" is always roman and "Echo" always italic, both in `serif`. Never bold, never all caps, never a different face.
- The strip is exactly as wide as the words and sits `0.45em` below them. Order is fixed: pink, orange, yellow, green, blue, purple, ink.
- Under about 32px, drop the strip (nav bar) or use the PNG `wordmark.png` instead.
- On screen, prefer live type. In print, Word and slides, use the PNG files in Logos so the font is not needed.
- Give the wordmark clear space of at least the cap height of "T" on every side.
