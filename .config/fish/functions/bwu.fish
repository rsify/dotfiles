# Defined in /Users/maciek/.config/fish/alias.fish @ line 261
function bwu --description 'Unlock Bitwarden vault'
	set -gx BW_SESSION (bw unlock --raw)
end
