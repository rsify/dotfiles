#!/bin/bash
file="$HOME/Documents/note-inbox/$(~/.config/bin/iso-date.sh).md"
touch "$file"
echo -n "$file"
