cd electeurs*/allFiles
# conversion XML > CSV
for f in *.xml
do
  echo $f
  python3 ../../xml2csv.py $f
done

# nettoyage CSV et renommage
for f in *.csv
do
  csv=$(echo $f | sed 's/_.*/-xml.csv/')
  csvsort $f | uniq > temp
  mv temp ../ok/$csv
done
