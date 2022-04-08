function safari --description 'Open Safari.app'
	open -a 'safari' (_prefix_url_with_http $argv)
end
