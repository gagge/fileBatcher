# fileBatcher
Small tool for renaming/copying files in a terminal

## Usage

``$ ./filebatcher.sh``

 Will try to rename files in the directory as you're currently in. 
 Renaming your files by removing "-Enhanced-NR" and "-Förbättrat-BR" from the currecnt filenames by default.

``$ ./filebatcher.sh -d /path/to/files``

Will try to rename the files in a given directory instead of your current.

``$ ./filebatcher.sh -c /path/to/copied/files``

Will try to copy files from the directory as you're currently in to the given path.

``$ ./filebatcher.sh -s "remove-this-string-from-file-name"``

Will try to rename or copy the files in the directory you're currently in, but with the given string.
