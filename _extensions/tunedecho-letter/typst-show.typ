#show: doc => te-letter(
$if(paper)$
  paper: "$paper$",
$endif$
$if(date)$
  date: [$date$],
$endif$
  recipient: (
$if(recipient.name)$
    name: [$recipient.name$],
$endif$
$if(recipient.title)$
    title: [$recipient.title$],
$endif$
$if(recipient.institution)$
    institution: [$recipient.institution$],
$endif$
    address: ($for(recipient.address)$[$recipient.address$],$endfor$),
  ),
$if(salutation)$
  salutation: [$salutation$],
$endif$
$if(closing)$
  closing: [$closing$],
$endif$
  signature: (
$if(signature.name)$
    name: [$signature.name$],
$endif$
$if(signature.title)$
    title: [$signature.title$],
$endif$
  ),
  contact: (
$if(contact.name)$
    name: [$contact.name$],
$endif$
    lines: ($for(contact.lines)$[$contact.lines$],$endfor$),
  ),
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
