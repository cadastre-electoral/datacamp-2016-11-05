from bs4 import BeautifulSoup
import sys
import csv

def coalesce(s,d=''):
    if s is None:
        return d
    else:
        return s

liste = BeautifulSoup(open(sys.argv[1]),'lxml')

csvfile = open(sys.argv[1].replace('xml','csv'), 'w')
wr = csv.writer(csvfile)
wr.writerow(['NoBureauDeVote','TypeVoie','CodePostal','VilleLocalite'])
for electeur in liste.find_all('electeur'):
    row = [electeur.nobureaudevote.string,
           (coalesce(electeur.adresseelecteur.numerovoie.string)+' '+
           coalesce(electeur.adresseelecteur.typevoie.string)+' '+
           coalesce(electeur.adresseelecteur.libellevoie.string)).replace('  ',' '),
           electeur.adresseelecteur.codepostal.string,
           electeur.adresseelecteur.villelocalite.string]
    wr.writerow(row)
