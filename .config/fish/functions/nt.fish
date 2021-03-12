# Defined via `source`
function nt --wraps='npm test' --description 'alias nt npm test'
  npm test $argv; 
end
