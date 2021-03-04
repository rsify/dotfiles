# Defined in - @ line 1
function bl --wraps='brew list' --description 'alias bl brew list'
  brew list $argv;
end
