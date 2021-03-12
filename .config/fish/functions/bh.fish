# Defined via `source`
function bh --wraps='brew help' --description 'alias bh brew help'
  brew help $argv; 
end
