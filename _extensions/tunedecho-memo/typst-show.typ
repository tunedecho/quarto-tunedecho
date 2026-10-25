#show: doc => te-memo(
$if(paper)$
  paper: "$paper$",
$endif$
$if(title)$
  title: [$title$],
$endif$
$if(date)$
  date: [$date$],
$endif$
  recipient: ($for(recipient)$[$recipient$],$endfor$),
  sender: ($for(sender)$[$sender$],$endfor$),
  cc: ($for(cc)$[$cc$],$endfor$),
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
