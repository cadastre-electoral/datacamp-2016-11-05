# -*- coding: utf-8 -*-
"""
Created on Sat Nov  5 11:21:19 2016

@author: aeidelman
"""

import pandas as pd
import fuzzywuzzy as fz


ville = 'Noiseau' # prérigny, Ablon-sur-Seine
ville_lower = ville.lower().replace('é', 'e')
ville_majuscule = ville.upper().replace('É', 'E')

if ville in ['Ablon-sur-Seine']:
    ville_majuscule = ville_majuscule.split('-')[0]


## read BAN
ban = pd.read_csv('BAN_odbl_94-csv')
ban = ban[ban['commune'] == ville]
ban_voies = ban.nom_voie.unique()

## read arrété

arrete = pd.read_csv('/home/sgmap/git/datacamp-2016-11-05/' + \
    'cquest/arretes/csv-intermédiaires/' + ville_lower + '.csv')
arrete_voies = arrete.Voie.unique()


# voies de la ban pas dans l'arrété
non_match = [x for x in ban_voies if x not in arrete_voies]
print(non_match)
print(len(non_match))

# voies oubliées par l'arrete
oubliees = [x for x in arrete_voies if x not in ban_voies]
print(oubliees)
print(len(oubliees))

### WE NEED TO USE PIVOT DATA !!

# matching
voies_ban_in_arretes = [x for x in ban_voies if x in arrete_voies]
ban_matchees = ban[ban['nom_voie'].isin(voies_ban_in_arretes)]


ban_matchees1 = ban_matchees.merge(arrete, left_on='nom_voie', right_on='Voie',
                   how='left')

numero = ban_matchees1.numero
numero_pairs = ban_matchees1.numero % 2 == 0

match_pair = (ban_matchees1['Début pair'] < numero) & \
    (numero < ban_matchees1['Fin Pair'])
match_pair[~numero_pairs] = False

match_impair = (ban_matchees1['Début impair'] < numero) & \
    (numero < ban_matchees1['Fin Impair'])
match_impair[numero_pairs] = False

ban_matchees1 = ban_matchees1[match_pair | match_impair]

ban_matchees1 = ban_matchees1[['nom_voie', 'numero', 'code_insee',
       'code_post', 'Bureau', 'x','y']]
ban_matchees1.to_csv('noiseau_new_bureaux.csv', index=False)


## Données des listes électorales
try:
    liste = pd.read_csv('/home/sgmap/git/datacamp-2016-11-05/' + \
        'LISTES ELECTORALES ANONYMISEES/csv-géocodés/' + \
        ville_majuscule + '-xls-geo.csv')
except:
    liste = pd.read_csv('/home/sgmap/git/datacamp-2016-11-05/' + \
        'LISTES ELECTORALES ANONYMISEES/csv-géocodés/' + \
        ville_majuscule + '-ok-geo.csv')

liste = liste[['bureau', 'adresse', 'cp', 'ville', 'latitude', 'longitude',
       'result_housenumber', 'result_name']]

match = ban_matchees1.merge(liste, left_on='nom_voie', right_on='result_name',
                   how='right')

check = (match.Bureau == match.bureau)
print(check.value_counts())

probleme = match.loc[~check, ['Bureau','bureau', 'numero', 'nom_voie']].drop_duplicates()
match.groupby(['Bureau', 'bureau']).size().unstack().fillna(0).astype(int)

