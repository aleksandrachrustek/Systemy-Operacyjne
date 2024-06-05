import os
import shutil

def copy_directory(source_dir, dest_dir):
    try:
        # Tworzenie katalogu docelowego, jeśli nie istnieje
        if not os.path.exists(dest_dir):
            os.makedirs(dest_dir)

        # Iteracja przez wszystkie elementy w katalogu źródłowym
        for item in os.listdir(source_dir):
            source_item = os.path.join(source_dir, item)
            dest_item = os.path.join(dest_dir, item)

            if os.path.islink(source_item):
                # Pominięcie dowiązań symbolicznych
                continue
            # Sprawdzenie czy to plik czy katalog
            elif os.path.isfile(source_item):
                # Sprawdzenie uprawnień do odczytu
                if os.access(source_item, os.R_OK):
                    # Skopiowanie pliku
                    shutil.copy2(source_item, dest_item)
                else:
                    # Stworzenie pustego pliku
                    open(dest_item, 'w').close()
                # Ustawienie praw dostępu takich samych jak w oryginalnym pliku
                shutil.copymode(source_item, dest_item)
            elif os.path.isdir(source_item):
                # Stworzenie pustego katalogu
                os.makedirs(dest_item, exist_ok=True)
                # Ustawienie praw dostępu takich samych jak w oryginalnym katalogu
                shutil.copymode(source_item, dest_item)
            

    except Exception as e:
        print(f"Wystąpił błąd podczas kopiowania: {e}")


source_directory = '/home/stud/achruste/zadania'
destination_directory = '/home/stud/achruste/zadaniakopia'

copy_directory(source_directory, destination_directory)

