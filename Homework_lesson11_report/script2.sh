#!/bin/bash
search_string=$1
directory=$2


find "$directory" -type f 2>/dev/null | while read -r FILE; do
    if grep -q "$search_string" "$FILE" 2>/dev/null; then
        FILE_SIZE=$(stat --printf="%s" "$FILE" 2>/dev/null)
        echo "Файл: $FILE, Размер: $FILE_SIZE байт"
    fi
done
