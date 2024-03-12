#!/bin/bash

# Usage:
# Will try to rename files in the same directory as you're currently in. 
# Renaming your files by removing "-Enhanced-NR" and "-Förbättrat-BR" from the currecnt filenamen by default.
# 
# Options:
#   -c            Copy - This will copy your files into the given directory instead of just renaming.
#   -d dir        Directory - Will try to read from given directory instead of your current.
#   -s "string"   String - Will try to remove this string from the file names instead of the defualt "-Enhanced-NR" and "-Förbättrat-BR".

strings_to_remove=("-Enhanced-NR" "-Förbättrat-BR")
read_directory=$(PWD)

while getopts d:s:c: flag
do
    case "${flag}" in
        d)  if [ ! -d $OPTARG ]; then
              echo "Read directory doesn't exists."
              exit 1
            fi
            read_directory=$(cd "${OPTARG}"; pwd -P)
            ;;

        s)  if [ $OPTARG ]; then
              strings_to_remove=("${OPTARG}")
            fi
            ;;

        c)  if [ ! -d $OPTARG ]; then
              mkdir "${OPTARG}"
            fi
            copy_directory=$(cd "${OPTARG}"; pwd -P)
            ;;

        *)  echo "Illegal option"
            exit 1
            ;;
    esac
done

files=("$read_directory/*")
for file in $files;
do

  for string_to_remove in "${strings_to_remove[@]}"
  do

    if [[ $file =~ $string_to_remove ]]; then
      new_file_name="${file//$string_to_remove/}"
  
      if [ $copy_directory ]; then
        new_file_name="${copy_directory}/$(basename -- $new_file_name)"
      fi

      if [ -f $new_file_name ]; then
        echo "- File already exists, adding suffix."
        extension="${new_file_name##*.}"
        new_file_name="${new_file_name%.$extension}_2.${extension}"
      fi

      if [ $copy_directory ]; then
        echo "Copying $file to $new_file_name"
        cp "$file" "$new_file_name"
      else
        echo "Renaming $file to $new_file_name"
        mv "$file" "$new_file_name"
      fi

      break
    fi
  done
done

echo "Done."

exit 0
