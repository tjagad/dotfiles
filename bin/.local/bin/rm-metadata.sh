#! /bin/sh

mkdir -p t

for f in *; do
	ffmpeg -i $f -map_metadata -1 -c:v copy -c:a copy t/$f
done