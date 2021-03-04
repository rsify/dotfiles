# Defined in - @ line 1
function bcrm --wraps='brew cask uninstall' --description 'alias bcrm brew cask uninstall'
  brew cask uninstall $argv;
end
