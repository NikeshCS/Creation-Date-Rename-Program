#!/bin/bash
if [ -z "$1" ]; then 
  echo "Usage: $0 [-h] [-t] [-s string]"
  echo "[-h]: Usage Help"
  echo "[-t]: Rename images with their creation date in the YYYYMMDDD.jpg format"
  echo "[-s string]: Rename images with a string specified by the user in the 000,001,... format"
  exit
fi

while getopts ":hts" opt; do
  case ${opt} in
    h ) echo "Help- Usage: $0 [-h] [-t] [-s string]"
        echo "[-h]: Usage Help"
        echo "[-t]: Rename images with their creation date in the YYYYMMDDD.jpg format"
        echo "[-s string]: Rename images with a string specified by the user in the 000,001,... format"
      ;;
    t ) for filename in *.jpg
        do
          mv -n "$filename" "$(identify -verbose $filename | grep exif | grep DateTimeOriginal | awk '{print $2}' | cut -b 1-10 | sed 's/://g' | sed 's/-//g').jpg"
        done
      ;;
      
    s ) for filename in ~/local/HW3_data/exif_data/*.jpg
        do
          mv -n "$filename" "$(identify -verbose $filename | grep exif | grep DateTimeOriginal | awk '{print $2}' | cut -b 1-10 | sed 's/://g' | sed 's/-//g').jpg"
        done
        i=0
        for file in *.jpg
        do
          j=$( printf "%03d" "$i" )
          mv "$file" "$2$j.jpg"
          (( i++ ))
        done
      ;;
    
   \? )  echo "Error: Usage: $0 [-h] [-t] [-s string]"
         echo "[-h]: Usage Help"
         echo "[-t]: Rename images with their creation date in the YYYYMMDDD.jpg format"
         echo "[-s string]: Rename images with a string specified by the user in the 000,001,... format"
      ;;
  esac
done
