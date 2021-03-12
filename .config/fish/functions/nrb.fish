# Defined via `source`
function nrb --wraps='npm rebuild' --description 'alias nrb npm rebuild'
  npm rebuild $argv; 
end
