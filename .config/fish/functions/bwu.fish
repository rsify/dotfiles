function bwu --description 'Unlock Bitwarden vault'
	set -gx BW_SESSION (bw unlock --raw)
end
