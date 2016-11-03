# Proposition de traitements des arrêtés

Les arrêtés définissant les bureaux de votes sont disponibles sous forme de fichiers PDF (scans).

Le problème étant complexe, appliquons le principe du "diviser pour régner" et découpons-le en sous problèmes plus simples à résoudre séparément.

## Etape 1: OCR (PDF -> TXT)

Cette étape permet de récupérer le texte (approximatif) contenu dans les scans PDF.

2 scripts proposés:
- 1a_pdf2tiff.sh : conversion des fichiers PDF en fichiers TIFF multipage
- 1b_tiff2txt.sh : conversion des TIFF en TXT à l'aide de tesseract-ocr

Les fichiers texte extraits automatiquement sont dans le dossier "1b-txt"


## Etape 2: extraction des données voies/adresses par bureau de vote (TXT -> CSV)

L'objectif est d'analyser le contenu du texte et d'obtenir en final des données tabulaires homogènes.

Pour quelques communes, un exemple de fichier CSV cible a été fait (à la main) pour permettre de travailler sur l'étape suivante.
Ce type de fichier est relativement rapide à ressaisir.


## Etape 3: transformation en découpage géographique (CSV -> GéoJson)

A partir des données CSV extraite des PDF des arrêtés, il faut faire l'appariement avec les tronçons de voies et adresses pour obtenir les contours correspondants à chaque bureau de vote.

L'objectif ici est de produire un fichier géographique (geojson, shapefile, etc).

Un exemple de fichier cible est disponible pour la commune de Saint-Maur-des-Fossés. Il a été créé à la main sur OpenStreetMap à partir des arrêtés PDF (travail fastidieux).
Vous pouvez utiliser l'outil overpass-turbo d'OpenStreetMap pour visualiser les données actuellement dans la base OSM, ainsi que les exporter dans différents format (geojson, xml, etc). Voir: http://overpass-turbo.eu/s/jNL
