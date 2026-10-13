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
$if(date)$
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
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
  doc,
)
