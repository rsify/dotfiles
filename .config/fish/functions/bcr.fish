# Defined via `source`
function bcr --wraps='brew cask reinstall' --description 'alias bcr brew cask reinstall'
  brew cask reinstall $argv; 
end
