# -*- coding: utf-8 -*-
"""
Created on Sat Nov  5 11:21:19 2016

@author: aeidelman
"""

import pandas as pd
import fuzzywuzzy as fz

ville = 'Périgny'
## read BAN
ban = pd.read_csv('BAN_odbl_94-csv')
ban = ban[ban['commune'] == ville]
ban_voies = ban.nom_voie.unique()

## read arrété
ville_lower = ville.lower().replace('é', 'e')
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

# 
voies_ban_in_arretes = [x for x in ban_voies if x in arrete_voies]
ban_matchees = ban[ban['nom_voie'].isin(voies_ban_in_arretes)]
ban_matchees = ban_matchees.merge(arrete, left_on='nom_voie', right_on='Voie',
                   how='inner')



## Données des listes électorales
ville_majuscule = ville.upper().replace('É', 'E')
liste = pd.read_csv('/home/sgmap/git/datacamp-2016-11-05/' + \
    'LISTES ELECTORALES ANONYMISEES/csv-géocodés/' + \
    ville_majuscule + '-xls-geo.csv')

match = ban_matchees.merge(liste, left_on='nom_voie', right_on='result_name',
                   how='inner')

check = (match.Bureau == match.bureau)
print(check.value_counts())


