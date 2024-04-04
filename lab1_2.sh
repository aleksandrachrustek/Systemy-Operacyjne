#16. W zadanym katalogu znalezc podkatalogi nie zawierajace
#plikow wykonywalnych. Podkatalogi moga zawierac podpod-
#katalogi oraz dowiazania symboliczne wskazujace na pliki 
#wykonywalne.

#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Uzycie: $0 katalog"
	exit 1
fi

dir=$1

if [ ! -d "$dir" ]; then
	echo "Argument musi byc katalogiem"
	exit 1
fi

for subdir in "$dir" /*/; do
	if [ -n "$(find "$subdir" -maxdepth 1 -type f -executable)" ]; then
		echo "Podkatalog zawiera pliki wykonywalne: $subdir"
	else 
		echo "Podkatalog nie zawiera plikow wykonywalnych: $subdir"
	fi
done

