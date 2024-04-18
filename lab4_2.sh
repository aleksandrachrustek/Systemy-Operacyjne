# W zadanym drzewie katalogów wylistować wszystkie pliki regularne, których nazwa 
# pokrywa się z nazwą katalogu w którym się znajdują. Dla potrzeb tego zadania, 
# należy porównywać nazwy plików/katalogów bez rozszerzeń. 

#!/bin/bash
#set -x

list_files_matching_directory_name() {
    local dir="$1"

    for entry in "$dir"/*; do
        if [ -f "$entry" ]; then
            filename=$(basename -- "$entry")
            filename_no_ext="${filename%.*}"

            dirname=$(basename -- "$dir")
            dirname_no_ext="${dirname%.*}"

            if echo "$filename_no_ext" | awk -v dir="$dirname_no_ext" '{if ($0 == dir) {exit 0} else {exit 1}}'; then
                echo "$entry"
            fi

        elif [ -d "$entry" ]; then
            list_files_matching_directory_name "$entry"
        fi
    done
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
