# Journal de bord du projet encadré

## exercice pour le 6/10d

ajout d'un fichier journal.md

commit et push

pas eu de pull nécessaire car je ne suis pas passé par github 
observation des logs et du status

## exercice 4 15/10
description fonctionnement exemple de script

si nombre d'arguments != 1 alors message d'erreur et exit 

associe le premier argument à une variable FICHIER_URLS

créer 2 variables 

boucle while: 
- lit chaque ligne de FICHIER_URLS (done < $FICHIER_URLS)
- print la ligne courante
- condition si la ligne courante commence par http ou https, =~ comparateur pour savoir si LINE match avec l'expression régulière, le ^ indique le début de la ligne, le s? indique que le s est optionnel
- si oui alors:
    - print "ressemble à une URL valide"
    - incrémente le compteur OK de 1
- sinon alors:
    - print "ne ressemble pas à une URL valide"
    - incrémente le compteur NOK de 1
- fin de la boucle
- affiche le nombre d'URL valides et non valides