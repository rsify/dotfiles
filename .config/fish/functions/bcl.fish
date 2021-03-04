# Defined in - @ line 1
function bcl --wraps='brew cask list' --description 'alias bcl brew cask list'
  brew cask list $argv;
end
