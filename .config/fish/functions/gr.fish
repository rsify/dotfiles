# Defined via `source`
function gr --wraps='git reset' --description 'alias gr git reset'
  git reset $argv; 
end
