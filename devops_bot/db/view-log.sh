#!/bin/bash

WAL_DIR="/var/log/postgresql" 
export PATH=$PATH:/usr/lib/postgresql/15/bin

MAX_FILES=10
COUNT=0

for WAL_FILE in $(ls -t $WAL_DIR); do  
    if [ -f "$WAL_DIR/$WAL_FILE" ] && [ $COUNT -lt $MAX_FILES ]; then
        echo "Содержимое файла $WAL_FILE:"
        pg_waldump "$WAL_DIR/$WAL_FILE" | tail -n 50
        echo "----------------------------------------------"
        ((COUNT++))
    fi
done

if [ $COUNT -eq 0 ]; then
    echo "Файлы WAL не найдены."
fi
