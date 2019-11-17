# Defined in /Users/nikersify/.config/fish/alias.fish @ line 224
function _prefix_url_with_http
    set res $argv

	if test -n "$argv"
		if not string match 'http*://*' $res
			set res "http://"$res
		end
	end

	echo $res
end
