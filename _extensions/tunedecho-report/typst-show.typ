#show: doc => te-report(
$if(paper)$
  paper: "$paper$",
$endif$
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(doc-type)$
  doc-type: [$doc-type$],
$endif$
$if(date-text)$
  date: [$date-text$],
$elseif(date)$
  date: [$date$],
$endif$
  client: (
$if(client.name)$
    name: [$client.name$],
$endif$
$if(client.institution)$
    institution: [$client.institution$],
$endif$
  ),
$if(prepared-by)$
  prepared-by: [$prepared-by$],
$endif$
$if(by-author)$
  authors: ($for(by-author)$$if(it.name.literal)$[$it.name.literal$],$endif$$endfor$),
$endif$
$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc_title: [$toc-title$],
$endif$
  toc_depth: $toc-depth$,
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(descriptor)$
  descriptor: [$descriptor$],
$endif$
$if(location)$
  location: [$location$],
$endif$
$if(mainfont)$
  font: "$mainfont$",
$endif$
$if(headingfont)$
  heading-font: "$headingfont$",
$endif$
$if(headingweight)$
  heading-weight: $headingweight$,
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(leading)$
  leading: $leading$,
$endif$
$if(par-spacing)$
  par-spacing: $par-spacing$,
$endif$
$if(tracking)$
  tracking: $tracking$,
$endif$
$if(body-width)$
  body-width: $body-width$,
$endif$
  doc,
)
