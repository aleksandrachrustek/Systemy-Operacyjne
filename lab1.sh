#8. Policzenie wszystkich plików w zadanym katalogu
#(parametr wywołania skryptu), do których ustawione jest
#prawo dostępu do wykonania ("execute").

#!/bin/bash

if [ $# -ne 1 ]; then 
	echo "Niepoprawna liczba argumentów."
	exit 1
fi

if [ ! -d $1 ]; then
	echo "Nie ma katalogu $1"
	exit 1
fi

cd $1
licznik=0

for plik in *
do 
	if [ -x $plik ] && [ -f $plik ]; then
		let licznik=licznik+1
	fi
done
echo "Liczba plikow z prawem do wykonywania w podanym katalogu: $licznik"

