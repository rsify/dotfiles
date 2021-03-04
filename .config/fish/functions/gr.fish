# Defined in - @ line 1
function gr --wraps='git reset' --description 'alias gr git reset'
  git reset $argv;
end
