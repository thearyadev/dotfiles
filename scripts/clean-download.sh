#!/bin/bash

DOWNLOADS_DIR="$HOME/Downloads"

if [ ! -d "$DOWNLOADS_DIR" ]; then
    echo "Downloads directory not found"
    exit 1
fi

has_non_hidden_items=false
for item in "$DOWNLOADS_DIR"/*; do
    if [ -f "$item" ] || [ -d "$item" ]; then
        has_non_hidden_items=true
        break
    fi
done

if [ "$has_non_hidden_items" = true ]; then
    DATE=$(date +%Y%m%d)
    HIST_DIR="$DOWNLOADS_DIR/.hist-$DATE"
    
    mkdir -p "$HIST_DIR"
    
    for item in "$DOWNLOADS_DIR"/*; do
        if [ -f "$item" ] || [ -d "$item" ]; then
            mv "$item" "$HIST_DIR/"
        fi
    done
    
    echo "Moved items to $HIST_DIR"
else
    echo "No non-hidden items to organize"
fi
