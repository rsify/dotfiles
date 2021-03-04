# Defined in - @ line 1
function bcup --wraps='brew cask upgrade' --description 'alias bcup brew cask upgrade'
  brew cask upgrade $argv;
end
