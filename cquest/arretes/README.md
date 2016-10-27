# Proposition de traitements des arrêtés

Les arrêtés sont disponibles sous forme de fichiers PDF (scans).

## Etape 1: OCR

Cette étape permet de récupérer le texte (approximatif) contenu dans les documents PDF.


## Etape 2: extraction des données voies/adresses par bureau de vote

L'objectif est d'analyser le contenu du texte et d'obtenir en final des données tabulaires homogènes.

Pour quelques communes, un exemple de fichier CSV cible a été fait (à la main) pour permettre de travailler sur l'étape suivante.


## Etape 3: transformation en découpage géographique

A partir des données CSV extraite des PDF des arrêtés, il faut faire l'appariement avec les tronçons de voies et adressespour obtenir les contours correspondants à chaque bureau de vote.

L'objectif ici est de produire un fichier géographique (geojson, shapefile, etc).
