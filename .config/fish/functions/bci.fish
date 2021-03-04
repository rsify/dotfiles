# Defined in - @ line 1
function bci --wraps='brew cask install' --description 'alias bci brew cask install'
  brew cask install $argv;
end
