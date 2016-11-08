# Pré-requis
Pour executer les 2 scripts sh et SQL il faut au préalable créer une base Postgres+Postgis (nommée "cadelec" dans le script shell)

# Source des données
Tronçons routiers : données issues de la BDUNI, base de production de l'IGNF
Géocodage des listes électorales : conversion en shapefile de https://github.com/cadastre-electoral/datacamp-2016-11-05/blob/master/LISTES%20ELECTORALES%20ANONYMISEES/csv-g%C3%A9ocod%C3%A9s/Villecresnes-xml-geo.csv 

# Chronologie
Procéder d'abord au chargement des 2 shapefiles via le shell, puis executer le SQL
