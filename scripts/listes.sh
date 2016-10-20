
echo "traitement des fichiers csv"
# - anonymisation
# - dédoublonnage sur les adresses
cd electeurs*
mkdir -p ok
for f in *.csv
do
  echo $f
  csv=$(echo "$f" | sed 's/.csv/-ok.csv/')
  csvcut -d ';' -e 'ISO8859-1' "$f" -C 2,3,4,5 | csvsort | uniq | sed 's/, / /;s/"//g' > ok/$csv
done

csvcut -d ';' -e 'ISO8859-1' "$f" -C 2,3,4,5 | csvsort | uniq | sed 's/, / /;s/"//g' > ok/$csv

csvcut -d ';' -e 'ISO8859-1' "NOISEAU.CSV" -C 2,3,4,5 | csvsort | uniq | sed 's/, / /;s/"//g' > ok/NOISEAU-ok.csv

# cas particulier KREMLIN BICETRE
csvcut -d ';' -e 'ISO8859-1' "KREMLIN BICETRE.csv" -C 2,3,4 | csvsort | uniq | sed 's/, / /;s/"//g' > "ok/KREMLIN BICETRE-ok.csv"

# cas particulier BRY SUR MARNE
csvcut -d ';' -e 'ISO8859-1' "BRY SUR MARNE.csv" -C 1,3,4,5,6,7,8,11,14,15,16,17 | csvsort | uniq | sed 's/\(.*\),\(.*\),\(.*\),\(.*\),\(.*\)/\1,\2 \3,\4,\5/' > "ok/BRY SUR MARNE-ok.csv"

# cas particulier CHAMPIGNY
csvcut -d ';' -e 'ISO8859-1' "CHAMPIGNY.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/CHAMPIGNY-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "CHEVILLY LARUE.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/CHEVILLY LARUE-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "FONTENAY.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/FONTENAY-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "FRESNES.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/FRESNES-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "IVRY.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/IVRY-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "MAISONS-ALFORT.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/MAISONS-ALFORT-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "SAINT MANDE.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/SAINT MANDE-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "VILLEJUIF.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/VILLEJUIF-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "VILLENEUVE ST GEORGES.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/VILLENEUVE ST GEORGES-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "VITRY.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/VITRY-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "charenton.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/\(.*\),\(.*\),\(.*\),\(.*\),\(.*\),\(.*\)/\1,\2 \3 \4,\5,\6/;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/CHARENTON-ok.csv"
csvcut -d ';' -e 'ISO8859-1' "gentilly.csv" -c 15,20,21,22,24,25 | csvsort | uniq | sed 's/,,/ /;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/GENTILLY-ok.csv"
# cas particulier RUNGIS
csvcut -d ';' -e 'ISO8859-1' "RUNGIS.CSV" -c 9,14,15,16,17,18 | csvsort | uniq | sed 's/\(.*\),\(.*\),\(.*\),\(.*\),\(.*\),\(.*\)/\1,\2 \3 \4,\5,\6/;s/NumeroVoie.*LibelleVoie/Adresse/' > "ok/RUNGIS-ok.csv"

echo "traitement des fichiers XLS"
for f in *.xls
do
  echo $f
  csv=$(echo $f | sed 's/.xls/-xls.csv/')
  in2csv --no-inference "$f" | csvcut -C 2,3,4,5 | sed 's/\.0,/,/' | csvsort | uniq > "ok/$csv"
done
# ARCUEIL et SANTENY ont plus de colonnes...
in2csv --no-inference "ARCUEIL.xls" | csvcut -c 15,20,22,24,25 | csvsort | uniq | sed 's/\(.*\),\(.*\),\(.*\),\(.*\),\(.*\)/\1,\2 \3,\4,\5/;s/\.0 / /' > "ok/ARCUEIL-xls.csv"
in2csv --no-inference "SANTENY.xls" | csvcut -c 3,12,13,10,11 | csvsort | uniq | sed 's/\(.*\),\(.*\),\(.*\),\(.*\),\(.*\)/\1,\2 \3,\4,\5/' > "ok/SANTENY-xls.csv"


cd -


cd elect*/ok
echo "traitement des fichiers XML"
bash xml2csv.sh

# harmonisation des noms de colonnes
for f in *.csv
do
  echo "bureau,adresse,cp,ville" > temp
  tail "$f" -n +2 >> temp
  mv temp "$f"
done

mkdir -p geocode
# géocodage des fichiers CSV avec l'API de la BAN
# et tri par score croissant (moins bons résultats en premier)
time for f in *.csv
do
  echo $f
  out=$(echo $f | sed 's/.csv$/-geo.csv/')
  # on élimine les 0 en préfixe de numéros
  sed 's/,0*/,/g;s!/! !' "$f" > temp
  http --timeout 600 -f POST http://api-adresse.data.gouv.fr/search/csv/ columns=adresse columns=cp columns=ville postcode=cp data@temp | csvsort -c result_score > "geocode/$out"
done
# cas particulier ST MAUR DES FOSSES / LA VARENNE ST HILAIRE
# on ajoute le code INSEE pour filtre dessus et pas d'ajout de CP + VILLE car trop d'erreurs dans la source
sed 's/,0*/,/g;s!/! !;s/$/,94068/' "ST MAUR DES FOSSES-xls.csv" > temp;  http --timeout 600 -f POST http://api-adresse.data.gouv.fr/search/csv/ columns=adresse citycode=94068 data@temp | csvcut -C 5 | csvsort -c result_score > "geocode/ST MAUR DES FOSSES-xls-geo.csv"
