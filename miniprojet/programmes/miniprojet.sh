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

echo "<table>"
echo "<tr><th>Numéro de ligne</th><th>URL</th><th>Code HTTP</th><th>Charset</th><th>Nombre de mots</th></tr>"
while read -r line; 
do
  echo "<tr>"
  if [[ $line =~ ^https?:// ]]; then
    echo -n -e "<td>$count_line</td><td>${line}</td><td>"
    curl -s -i -o /dev/null -w '%{http_code}' "$line"
    echo -n -e "</td><td>"
    curl -s -i "$line" | grep "charset" | head -1 | sed -n -e 's/^.*charset=//p' | tr -d '\r\n'
    echo -n -e "</td><td>"
    n_mots=$(lynx -dump -nolist "$line" 2>/dev/null | wc -w)
    echo "$n_mots </td>"
	  count_line=$((count_line + 1))
  else
    echo -n -e "<td>$count_line</td><td>${line}</td><td>"
    echo "ne ressemble pas à une URL valide </td>"
    count_line=$((count_line + 1))
  fi
  echo "</tr>"
done < "$file";
echo "</table>"
