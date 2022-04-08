function chrome --description 'Open Google Chrome.app'
	open -a 'google chrome' (_prefix_url_with_http $argv)
end
