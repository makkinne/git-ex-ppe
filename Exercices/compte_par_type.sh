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
find "$directory" -type f -exec grep -o "$mot" {} \; | wc -l

exit 0