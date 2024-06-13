#!/usr/bin/env python3

# W zadanym drzewie katalogów znaleźć katalogi, do których wykonujący skrypt nie ma prawa zapisu,
# zawierające co najmniej $2 podkatalogi inne niż ‘.’ i ‘..’

import os
import sys

def find_non_writable_dirs_with_subdirs(root_dir, min_subdirs):
    result_dirs = []

    for current_dir, subdirs, _ in os.walk(root_dir):
        try:
            if not os.access(current_dir, os.W_OK):
                valid_subdirs = [d for d in subdirs if not os.path.islink(os.path.join(current_dir, d))]
                
                if len(valid_subdirs) >= min_subdirs:
                    result_dirs.append(current_dir)
        except PermissionError:
            continue

    return result_dirs

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Skrypt został wywołany niepoprawnie!")
        sys.exit(1)

    root_directory = sys.argv[1]
    min_subdirs = int(sys.argv[2])

    directories = find_non_writable_dirs_with_subdirs(root_directory, min_subdirs)
    
    if directories:
        print("Katalogi bez prawa zapisu z co najmniej {} podkatalogami:".format(min_subdirs))
        for directory in directories:
            print(directory)
    else:
        print("Nie znaleziono takich katalogów.")
