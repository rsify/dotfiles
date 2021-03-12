# Defined via `source`
function gl1 --wraps='git log -n 1' --description 'alias gl1 git log -n 1'
  git log -n 1 $argv; 
end
