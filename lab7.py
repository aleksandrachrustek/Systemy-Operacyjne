import re
import sys

# W zadanym pliku tekstowym należy znaleźć i wyświetlić wszystkie wyrazy (od spacji lub początku linii do spacji lub końca linii),
# w których występuje duża litera na początku, a po niej zmieszane małe litery i cyfry (co najmniej jedna litera i jedna cyfra). 

def find_words(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        text = file.read()

    pattern = r'\b[A-Z][a-z0-9]*[a-z][a-z0-9]*\d[a-z0-9]*\b|\b[A-Z][a-z0-9]*\d[a-z0-9]*[a-z][a-z0-9]*\b'
    matches = re.findall(pattern, text)
    
    for match in matches:
        print(match)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("złe wywolanie skryptu!")
    else:
        file_path = sys.argv[1]
        find_words(file_path)
