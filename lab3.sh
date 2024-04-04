#W zadanym drzewie katalogów znaleźć katalogi zawierające mniej niż
#$2 (zadany parametr), a więcej lub równo $3 podkatalogi. Skrypt
#musi uwzględniać ostrość nierówności! Podpowiedź: liczbę podkatalogów
#można określić na podstawie liczby dowiązań twardych do katalogu. 

#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Sposób użycia: $0 ścieżka_do_katalogu liczba_mniej niż liczba_więcej lub_równo"
    exit 1
fi

path=$1
less_than=$(( $2 + 2 ))
more_or_equal=$(( $3 + 2 ))

if [ ! -d "$path" ]; then
    echo "Podana ścieżka nie istnieje lub nie jest katalogiem."
    exit 1
fi

#Znajdź katalogi zawierające mniej niż $less_than i więcej lub równo $more_or_equal podkatalogów
find "$path" -mindepth 1 -type d \( -links +$less_than \) -a \( -links $more_or_equal -o -links -$more_or_equal \) -a -print
