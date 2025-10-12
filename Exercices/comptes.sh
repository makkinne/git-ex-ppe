#!/bin/bash

directory=$1
mot="Location" # Mot à chercher

if [ ! -d "$directory" ]; then 
  echo "renseignez un dossier valide"
  exit 1
fi

echo "méthode avec find"
# Compte le nombre d'occurrences du mot dans les fichiers du répertoire
find "$directory" -type f -exec grep -o "$mot" {} \; | wc -l
# find "$directory" -type f -> cherche tous les fichiers dans le répertoire
# grep -o "$mot" {} \; -> cherche le mot dans chaque fichier et affiche chaque occurrence sur une nouvelle ligne
# | wc -l -> compte le nombre de lignes (c'est-à-dire le nombre d'occurrences du mot)

###################
#autre méthode
###################
# numOcc variable pour stocker le nombre d'occurrences
numOcc=0

echo "méthode avec des boucles for"
for subdir in "$directory"/*/; do #itérer sur chaque sous-répertoire
  for file in "$subdir"*; do #itérer sur chaque fichier
    if [ -f "$file" ]; then
      numOcc=$((numOcc + $(grep -o "$mot" "$file" | wc -l)))
    fi
  done
done
echo "Le mot '$mot' apparaît $numOcc fois dans les fichiers du répertoire '$directory'."

exit 0