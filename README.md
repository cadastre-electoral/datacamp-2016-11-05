# Documents et données du datacamp cadastre électoral

Information sur le datacamp: https://www.etalab.gouv.fr/event/open-data-camp-cadastre-electoral

Inscription ouverte sur: https://rdv.etalab.gouv.fr/e/11/open-data-camp-cadastre-electoral


## Objectif du datacamp

Durant cette journée, les participants sont invités à travailler sous la forme d’ateliers afin de répondre à plusieurs défis :

- Comment réaliser une cartographie des bureaux de vote à partir des seuls arrêtés préfectoraux ?

- Quelles méthodes et quels procédés pour généraliser la géolocalisation des bureaux de vote et standardiser les arrêtés préfectoraux ?

- Et tous les autres défis que vous pourrez proposer !


## Documents: Arrêtés

Ces arrêtés définissent les limites géographiques des bureaux de vote.

Ils sont en deux parties, c'est dans les annexes que se trouve la définition textuelle ou sous forme de tableaux des bureaux de votes.

Ils ne sont facilement disponibles en général que sous forme de PDF scannés.

Leur contenu et formatage est hétérogène, c'est donc le principal challenge de ce datacamp !


## Données: Listes Électorales anonymisées

Elles sont disponibles sous forme de fichiers CSV conprenant uniquement:

- le N° du bureau de vote
- l'adresse (numéro et libellé de voie)
- le code postal
- le nom de la commune (ou libellé d'acheminement postal)

Ces fichiers CSV ont été générés à partir de 3 types de sources:

- des fichiers CSV
- des tableaux Excel
- des fichiers XML

Ils ont été remis en forme pour avoir une structure identique (ce qui n'était pas le cas dans les sources).

Ils ont ensuite été géocodés à l'aide de l'API publique de la Base Adresse Nationale (http://adresse.data.gouv.fr/api/) et leur contenu est trié par "score" croissant afin de faire remonter les adresses ayant un géocodage peu fiable en premier.


## Proposition d'améliorations

Vous pouvez d'ores et déjà travailler sur les documents et données mis à disposition.

N'hésitez pas à proposer vos améliorations en amont du datacamp, ceci permettra sûrement de produire certains résultats intermédiaires. Vous pouvez faire des "pull-request" pour intégrer vos améliorations sur ce projet git.

De même, les "issues" peuvent servir d'espace de discussion et le wiki peut servir à documenter les méthodes, process et outils utilisés.

A titre d'information les scripts utilisés pour les traitements préparatoires sont dans le dossier "scripts".


## Données additionnelles utiles

### Fichier FANTOIR (DGFiP) - Licence Ouverte

Il contient les noms de rues et de lieux-dits. Il peut servir à retrouver les libellés des rues dans les arrêtés.

http://www.data.gouv.fr/fr/datasets/fichier-fantoir-des-voies-et-lieux-dits/


### Base Adresse Nationale (BAN) - ODbL

Ce jeu de données contient la position géographique des adresses numérotées, avec le nom de voie et/ou de lieu-dit.

http://www.data.gouv.fr/fr/datasets/ban-base-adresse-nationale/

Version ODbL sur: http://bano.openstreetmap.fr/BAN_odbl/


### Base Adresse Nationale Ouverte (BANO) - ODbL

Ce jeu de données peut compléter la BAN par l'apport de la position des lieux-dits sans adresse numérotées.

http://bano.openstreetmap.fr/data/


### Données géographiques de l'APUR - ODbL

L'APUR (Atelier Parisien d'URbanisme) diffuse plusieurs jeux de données géographiques de réfences:

- Filaire de voirie :
- Tronçons de voirie :
- Parcelles :
- Îlots bâtis:

Le *filaire de voirie* contient toutes les voies d'Île de France, avec leur nom.

Les *tronçons de voirie* contiennent le filaire découpé par tronçons à chaque intersection (à lier avec le filaire pour obtenir les noms). Chaque tronçon possède l'information sur les numéros pairs/impairs de début et de fin.

Les *parcelles* correspondent au surfacique des parcelles cadastrales. Aucun information liées à l'adresse n'est présente.

Les *îlots bâtis* sont les regroupement de parcelles par pâté de maisons.

Voir: http://opendata.apur.org/


### Données OpenStreetMap - ODbL

Un exemple de découpage des bureaux de vote est disponible pour la commune de Saint-Maur-des-Fossés dans la base de données OpenStreetMap.
Il a été créé à la main sur OpenStreetMap à partir des arrêtés PDF (travail fastidieux).

Vous pouvez utiliser l'outil overpass-turbo d'OpenStreetMap pour visualiser les données actuellement dans la base OSM, ainsi que les exporter dans différents format (geojson, xml, etc). Voir: http://overpass-turbo.eu/s/jNL
