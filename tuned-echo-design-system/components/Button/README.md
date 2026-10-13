# Button

A pill-shaped call to action, in two variants: `primary` (ink fill) and `ghost` (ink outline).

**Markup:** `<a class="te-btn primary" href="…">Label</a>` or `<button class="te-btn ghost">Label</button>`.

- At most one primary per view, placed first. A ghost may follow it.
- Labels are short, sentence case, and start with a verb: "Start a conversation", "See the work".
- Primary is `ink` with `on-ink` text; ghost is transparent with an `ink` border and turns `paper` on hover. Both have a 1.5px border and `radius-pill`.
- Focus shows a 2px `focus` outline, offset 3px. Never remove it.
- No icons, no arrows, no colored buttons. The key colors are not for actions.
