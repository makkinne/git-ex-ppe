#!/bin/bash

if [ "$#" -ne 4 ]; then
	echo "Usage : $0 <repertoire> <annee|'*'> <mois|'*'> <nb_lieux>"
	exit 1
fi

directory=$1
annee=$2
mois=$3
nb_lieux=$4

if [ ! -d "$directory" ]; then
	echo "renseignez un dossier valide"
	exit 1
fi

#créer un fichier lieuxCompte_lieux.txt dans le répertoire courant
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# Extraction des lieux distincts et écriture dans lieuxCompte_lieux.txt
# et supprime les espaces pour éviter les erreurs
# Modification de la commande find pour filtrer par année et mois
if [ "$annee" = "*" ] && [ "$mois" = "*" ]; then
    find "$directory" -type f -name "*.ann" -exec grep -hP '\tLocation\s+[0-9]+\s+[0-9]+\s+.*' {} + | awk -F'\t' '{print $3}' | tr -d ' ' > $DIR/lieuxCompte_lieux.txt
elif [ "$mois" = "*" ]; then
    find "$directory" -type f -name "${annee}_*.ann" -exec grep -hP '\tLocation\s+[0-9]+\s+[0-9]+\s+.*' {} + | awk -F'\t' '{print $3}' | tr -d ' ' > $DIR/lieuxCompte_lieux.txt
elif [ "$annee" = "*" ]; then
    # ajout d'un zéro si nécessaire
    mois=$(printf "%02d" "$mois") #condition si deja 2 chiffres
    find "$directory" -type f -name "*_${mois}_*.ann" -exec grep -hP '\tLocation\s+[0-9]+\s+[0-9]+\s+.*' {} + | awk -F'\t' '{print $3}' | tr -d ' ' > $DIR/lieuxCompte_lieux.txt
else
    # ajout d'un zéro si nécessaire
    mois=$(printf "%02d" "$mois")
    find "$directory" -type f -name "${annee}_${mois}_*.ann" -exec grep -hP '\tLocation\s+[0-9]+\s+[0-9]+\s+.*' {} + | awk -F'\t' '{print $3}' | tr -d ' ' > $DIR/lieuxCompte_lieux.txt
fi

# Compter les occurrences de chaque lieu et trier par ordre décroissant
# n'afficher que les nb_lieux premiers résultats
sort $DIR/lieuxCompte_lieux.txt | uniq -c | sort -nr | head -n "$nb_lieux"

rm "$DIR/lieuxCompte_lieux.txt"

###################### 
# correction
###################### 
echo "La correction "
# cat "${annee}_${mois}_*.ann" -exec grep location {} + | cut -f3 | sort | uniq -c | sort -n | tail -n $nb_lieux
find "$directory" -type f -name "*${annee}_${mois}_*.ann" -exec grep -hP '\tLocation\s+[0-9]+\s+[0-9]+\s+.*' {} + | cut -f3 | sort | uniq -c | sort -n | tail -n "$nb_lieux"
echo "solution avec cat" 
cat "${directory}""${annee}"/*"${annee}"_"${mois}"*.ann | grep Location | cut -f3 | sort | uniq -c | sort -n | tail -n $nb_lieux
exit 0
