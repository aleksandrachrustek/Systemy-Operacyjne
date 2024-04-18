# W zadanym drzewie katalogów wylistować wszystkie pliki regularne, których nazwa 
# pokrywa się z nazwą katalogu w którym się znajdują. Dla potrzeb tego zadania, 
# należy porównywać nazwy plików/katalogów bez rozszerzeń. 

#!/bin/bash
#set -x

list_files_matching_directory_name() {
    local dir="$1"

    find "$dir" -type f | awk -v dir="$dir" '
        {
            filename = $0
            gsub(/^.*\//, "", filename)
            gsub(/\.[^.]+$/, "", filename)
            dir_no_ext = gensub(/\.[^.]+$/, "", dir)
            if (filename == dir_no_ext) {
                print $0
            }
        }
    '
}


if [ "$#" -ne 1 ]; then
    echo "Użycie: $0 ścieżka_do_katalogu"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "$1 nie jest katalogiem."
    exit 1
fi

list_files_matching_directory_name "$1"
