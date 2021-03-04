# Defined in - @ line 1
function bd --wraps='brew doctor' --description 'alias bd brew doctor'
  brew doctor $argv;
end
