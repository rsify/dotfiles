# Defined via `source`
function bl --wraps='brew list' --description 'alias bl brew list'
  brew list $argv; 
end
