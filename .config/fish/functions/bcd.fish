# Defined in - @ line 1
function bcd --wraps='brew cask doctor' --description 'alias bcd brew cask doctor'
    brew cask doctor $argv;
end
