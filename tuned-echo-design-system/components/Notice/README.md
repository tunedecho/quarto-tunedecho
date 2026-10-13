# Notice

A dashed, square `paper` panel for status that is temporary or not yet available, plus a full-width ink banner for site-wide status.

**Markup:** `<div class="te-notice"><span class="label">Coming soon</span><p>…</p></div>`; banner: `<div class="te-banner" role="status">…</div>` at the very top of the page.

- The dashed border signals "draft" or "in progress". Remove the notice once the thing exists; do not use it for ordinary callouts.
- Label: two or three words in the `eyebrow` style, `ink`. Body: one or two sentences in `muted` that offer a next step.
- The banner is for one site-wide message only, uppercase `banner` style, `on-ink` on `ink`.
