#!/bin/bash

engine=$(printf "Leetcode\nGoogle\nDuckDuckGo\nImages\nMaps\nGitHub\nWhatsApp\nSubstack" | dmenu -i) || exit 0

query=""
query_param_reqd=1

case "${engine,,}" in 
  google) query="https://www.google.com/search?q=" ;;
  duckduckgo) query="https://duckduckgo.com/?ia=web&q=" ;;
  images) query="https://duckduckgo.com/?ia=images&iax=images&q=" ;;
  maps) 
    type_search=$(printf "Place\nDirections" | dmenu -i) || exit 0
    case "${type_search,,}" in
      place)
        query="https://maps.google.com/maps/search/" ;;
      directions)
        query="https://maps.google.com/maps/dir/Lotus+Boulevard,+Sector+100,+Noida,+Uttar+Pradesh+201304/" ;;
    esac
    ;;
  whatsapp) 
    query="https://web.whatsapp.com/"
    query_param_reqd=0
    ;;
  *) 
    query="https://duckduckgo.com/?ia=web&q="
    query+="${engine// /+}"
    query_param_reqd=0
    ;;
esac

if ((query_param_reqd))
then
  param=$(printf '' | dmenu -p 'Search: ') || exit 0
  param=${param// /+}
  query+="$param"
fi

surf "$query"
