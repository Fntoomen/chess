#!/bin/env sh
rm -rf ./pieces/*.png
for i in ./pieces/* ; do inkscape -o $i.png -w 128 $i; done
