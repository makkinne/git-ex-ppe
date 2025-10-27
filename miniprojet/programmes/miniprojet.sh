#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "en attente d'un argument : fichier d'urls"
    exit 1
fi

file=$1

if [ ! -f "$file" ]; then
  echo "renseignez un fichier valide"
  exit 1
fi

count_line=0
n_mots=0

while read -r line; 
do
  if [[ $line =~ ^https?:// ]]; then
	  echo -n -e "$count_line"'\t'${line}; #-e means 'enable interpretation of backslash escapes
    echo -n -e '\t' #saute une ligne
    curl -s -i -o /dev/null -w '%{http_code}' "$line" #récupère le code http
    echo -n -e '\t' #-n empêche le saut de lugne 
curl -s -i "$line" | grep "charset" | head -1 | sed -n -e 's/^.*charset=//p' | tr -d '\r\n' # tronc des retour à la ligne et retour curseur 
    echo -n -e '\t'
    n_mots=$(lynx -dump -nolist "$line" 2>/dev/null | wc -w)
    echo $n_mots
	  count_line=$((count_line + 1))
  else
    echo -n -e "$count_line"'\t'${line}'\t';
    echo "ne ressemble pas à une URL valide "
    count_line=$((count_line + 1))
  fi
done < "$file";
