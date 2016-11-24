# -*- coding: utf-8 -*-
"""
Created on Sat Nov  5 14:51:32 2016

@author: sgmap
"""

import os
import pandas as pd

path_listes = '/home/sgmap/git/datacamp-2016-11-05/' + \
        'LISTES ELECTORALES ANONYMISEES/csv/'

liste94 = pd.DataFrame()

for file in os.listdir(path_listes):
    path_file = os.path.join(path_listes, file)
    tab = pd.read_csv(path_file)
    liste94 = liste94.append(tab, ignore_index=True)

vraie_liste = liste94[['bureau', 'adresse', 'ville']]
vraie_liste['adresse'] = vraie_liste['adresse'].str.lower()
vraie_liste.drop_duplicates(inplace=True)

pb = vraie_liste[['adresse', 'ville']].duplicated(keep=False)
problemes = vraie_liste[pb]
print(sum(pb))

nb_bureau_par_adresse = problemes.groupby(['adresse', 'ville']).size()

print(nb_bureau_par_adresse.sort_values())
print(problemes['ville'].value_counts())