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
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
  doc,
)
