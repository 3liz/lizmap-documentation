Lizmap - Images for documentation
=================================
This directory contains at its root images for every languages. If you want to translate images for your language create a directory (e.g. fr) and put images with the same name than original in it.

Only add progressive jpg images (better for web). You can convert png to jpg with this imagemagick's command: 
```bash
convert -strip -interlace plane -quality 80 SOURCE.png DESTINATION.jpg
```

For batch
```bash
for i in *.png ; do convert -strip -interlace plane -quality 80 "$i" "${i%.*}.jpg" ; done && ls *.png | xargs rm && git checkout logo.png logo_big.png
```

Note *post* `convert`, `gm` looks to give better result ?
```bash
sudo apt install graphicsmagick
gm convert image.png image.jpg
for i in *.png ; do gm convert "$i" "${i%.*}.jpg" ; done
```
