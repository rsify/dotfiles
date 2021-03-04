# Defined in - @ line 1
function grb --wraps='git rebase' --description 'alias grb git rebase'
  git rebase $argv;
end
