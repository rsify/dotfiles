# Defined in - @ line 1
function gaa --wraps='git add --all' --description 'alias gaa git add --all'
  git add --all $argv;
end
