# Defined via `source`
function gapp --wraps='git apply' --description 'alias gapp git apply'
  git apply $argv; 
end
