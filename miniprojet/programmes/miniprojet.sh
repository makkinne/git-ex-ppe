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
echo "<html>

<head>
  <meta charset=\"UTF-8\" />
  <title>Programmation et Projet Encadré</title>
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
  <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/versions/bulma-no-dark-mode.min.css\">
</head>

<body>"

echo "<div class=\"columns is-centered\">
        <div class=\"column is-half\">
          <div class=\"block\">
            <h3 class=\"title is-3 has-background-info has-text-white\">Tableaux français :</h3>"
echo "<table class=\" table is-bordered is-hoverable is-striped \">"
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
echo " </div> </div> </div>"
echo "</body> </html>"