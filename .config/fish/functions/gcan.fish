function gcan --wraps='git commit --amend --no-edit' --description 'alias gcan git commit --amend --no-edit'
  git commit --amend --no-edit $argv; 
end
