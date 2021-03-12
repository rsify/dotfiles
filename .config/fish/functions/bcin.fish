# Defined via `source`
function bcin --wraps='brew cask info' --description 'alias bcin brew cask info'
  brew cask info $argv; 
end
