# Defined via `source`
function gb --wraps='git branch' --description 'alias gb git branch'
  git branch $argv; 
end
