# Defined in /Users/nikersify/.config/fish/alias.fish @ line 242
function firefox --description 'Open Firefox.app'
    open -a 'firefox' (_prefix_url_with_http $argv)
end
