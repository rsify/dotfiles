# Defined via `source`
function ngi --wraps='npm install -g' --description 'alias ngi npm install -g'
  npm install -g $argv; 
end
