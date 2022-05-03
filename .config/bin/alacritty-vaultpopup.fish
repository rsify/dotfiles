#!/usr/bin/fish

cd vet

set -l out (ag --hidden --silent --ignore Archive --ignore .obsidian -g . | fzf --reverse --bind=alt-enter:print-query)

if test $status = 0
	vim -c ':set linebreak' $out
end
