# conversion des fichiers PDF en TIFF exploitables par tesseract-ocr
# dépend de ImageMagick

mkdir -p 1-tiff
for f in ../../ARRETES*/*.pdf
do
  convert -density 300 "$f" -type Grayscale -background white +matte "$f.tiff"
  mv "$f.tiff" ./1-tiff
done
