# Defined via `source`
function ngin --wraps='npm info -g' --description 'alias ngin npm info -g'
  npm info -g $argv; 
end
