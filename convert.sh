# This script relies on ffmpeg, flac, and lame.
# If you don't have those installed this script will fail.
# It also assumes that you have an alias set up in your shell for the script called "convert".

#!/bin/bash
read -p "Enter Track Number: " track
read -p "Enter Artist: " artist
read -p "Enter Album: " album
read -p "Enter Title: " title
read -p "Enter Genre (Only Techno, Psytrance, Downtempo, or none are valid entries): " genre
read -p "Enter BPM: " bpm
read -p "Enter Release Year: " date
echo ";FFMETADATA1
PICTURE=folder.jpg
APIC=folder.jpg
track=$track
ARTIST=$artist
ALBUM=$album
TITLE=$title
GENRE=$genre
DATE=$date
BPM=$bpm" > "$track - $artist - $title".txt\
&& ffmpeg -y -i "$track - $artist - $title".wav -i "$track - $artist - $title".txt -map_metadata 1 -id3v2_version 3 -write_id3v1 1  -acodec flac "$track - $artist - $title".flac\
&& metaflac --import-picture-from=folder.jpg "$track - $artist - $title".flac\
&& ffmpeg -y -i "$track - $artist - $title".wav -i "$track - $artist - $title".txt -i folder.jpg -map_metadata 1 -map 0 -map 2 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (Front)" -id3v2_version 3 -write_id3v1 1 -acodec mp3 -b:a 320k "$track - $artist - $title".mp3\
