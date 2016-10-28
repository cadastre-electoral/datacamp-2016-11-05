# conversion des fichiers TIFF multipage en TXT par tesseract-ocr
# comme les orientations varient d'une page à l'autre pour chaque PDF,
# les pages sont traitées une à une

for t in 1a-tiff/*.pdf.tiff
do
  echo $t
  rm -f /tmp/tiff2txt-*.tif
  # conversion multipage en pages uniques numérotées 00..nn par ImageMagick
  convert "$t" /tmp/tiff2txt-%02d.tif
  rm -f "$t.txt"
  for p in /tmp/tiff2txt-*.tif
  do
    echo $p
    # OCR avec tesseract
    tesseract $p stdout -l fra -psm 1 >> "$t.txt"
    rm $p
  done
done

# on range le résultat dans le dossier "1b-txt"
mkdir -p 1b-txt
mv tiff/*.pdf.tiff.txt 1b-txt
