#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "rentrer une commande sous la forme : ./script.sh <mot qui va être cherché> <repertoire>"
    exit 1
fi

mot=$1 # Mot à chercher

directory=$2

if [ ! -d "$directory" ]; then 
  echo "renseignez un dossier valide"
  exit 1
fi

# Compte le nombre d'occurrences du mot dans les fichiers du répertoire
# find "$directory"/2016 -type f -exec grep -o "$mot" {} \; | wc -l
# find "$directory"/2017 -type f -exec grep -o "$mot" {} \; | wc -l
# find "$directory"/2018 -type f -exec grep -o "$mot" {} \; | wc -l

occ=0

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # permet de lancer le script depuis n'importe où

occ=$("$DIR/compte_par_type.sh" "$mot" "$directory"/2016)
echo "Le mot '$mot' a été trouvé $occ fois dans le répertoire 2016"
occ=$("$DIR/compte_par_type.sh" "$mot" "$directory"/2017)
echo "Le mot '$mot' a été trouvé $occ fois dans le répertoire 2017"
occ=$("$DIR/compte_par_type.sh" "$mot" "$directory"/2018)
echo "Le mot '$mot' a été trouvé $occ fois dans le répertoire 2018"


exit 0