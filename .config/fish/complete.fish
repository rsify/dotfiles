if test $hostname = 'potet.local'
	# requires `brew install findutils`
	complete --command o -xa "(gfind ~/Documents/vet -type f -not -path '*/Archive/*' -name '*.md' -printf '%P\n')"
end
