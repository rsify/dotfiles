# Defined via `source`
function gsubur --wraps='git submodule update --recursive --remote' --description 'alias gsubur git submodule update --recursive --remote'
  git submodule update --recursive --remote $argv; 
end
