# W zadanym katalogu ($1) znajdź dowiązania symboliczne do
# obiektów w tym samym katalogu $1 i usuń je.

#!/bin/bash

# Sprawdzenie liczby argumentow
if [ $# -ne 1 ]; then
    echo "Niepoprawna liczba argumentow!"
    exit 1
fi

katalog="$1"

# Sprawdzanie czy podana ścieżka jest katalogiem
if [ ! -d "$katalog" ]; then
    echo "$katalog nie jest katalogiem!"
    exit 1
fi

# Przechodzenie przez wszystkie pliki w katalogu
for plik in "$katalog"/* ; do
    # Sprawdzanie czy plik jest dowiązaniem symbolicznym
    if [ -L "$plik" ] ; then
        # Pobieranie ścieżki docelowej
        cel=$(readlink "$plik")
        # Pobieranie nazwy pliku z pełną ścieżką
        nazwa=$(basename "$plik")
        # Sprawdzanie czy ścieżka docelowa jest w tym samym katalogu
        if [ "$(dirname "$cel")" = "$katalog" ]; then
            # Usuwanie dowiązania symbolicznego
            rm "$plik"
            echo "Usunięto dowiązanie symboliczne: $nazwa"
        fi
    else 
    	echo "Nie znaleziono dowiązań symbolicznych"
    fi
done
