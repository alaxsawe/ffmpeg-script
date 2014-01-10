# This script relies on ffmpeg, flac, and lame.
# If you don't have those installed this script will fail.

#!/bin/sh

# Gather information from the user to write to the metadata file to be called later.
read -p "Enter Track Number: " track
read -p "Enter Artist: " artist
read -p "Enter Album: " album
read -p "Enter Title: " title
read -p "Enter Genre: " genre
read -p "Enter BPM: " bpm
read -p "Enter Release Year: " date

# Write the metadata file
echo ";FFMETADATA1
PICTURE=folder.jpg
APIC=folder.jpg
track=$track
ARTIST=$artist
ALBUM=$album
TITLE=$title
GENRE=$genre
DATE=$date
BPM=$bpm" > "$track - $artist - $title".mdta\

echo "Metadata accepted, converting files..."
# Call FFMPEG to convert the WAV file to FLAC. Comment this to disable this function.
ffmpeg -y -i "$track - $artist - $title".wav -i "$track - $artist - $title".mdta -map_metadata 1 -id3v2_version 3 -write_id3v1 1  -acodec flac "$track - $artist - $title".flac
# Tell FLAC where to find the album art and embed it to the newly created flac file.  If you've commented the previous line, you must also comment this one, otherwise the script will fail.
metaflac --import-picture-from=folder.jpg "$track - $artist - $title".flac
# Call FFMPEG to convert the WAV file to 320k MP3 and embed metadata and artwork.  Comment this to disable this function.
ffmpeg -y -i "$track - $artist - $title".wav -i "$track - $artist - $title".mdta -i folder.jpg -map_metadata 1 -map 0 -map 2 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (Front)" -id3v2_version 3 -write_id3v1 1 -acodec mp3 -b:a 320k "$track - $artist - $title".mp3
