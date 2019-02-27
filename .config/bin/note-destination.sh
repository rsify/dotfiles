#!/bin/bash
file="$HOME/Documents/note-inbox/$(~/.config/bin/iso-date.sh)"
touch "$file"
echo -n "$file"
