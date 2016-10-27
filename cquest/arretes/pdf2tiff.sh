# conversion des fichiers PDF en TIFF exploitables par tesseract-ocr
# dépend de ImageMagick

for f in ../../ARRETES*/*.pdf
do
  convert -density 300 "$f" -type Grayscale -background white +matte "$f.tiff"
  mv "$f.tiff" ./
done
