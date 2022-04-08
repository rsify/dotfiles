function glg --wraps='git log --color=always --format=oneline --abbrev-commit --decorate | head' --description 'alias glg git log --color=always --format=oneline --abbrev-commit --decorate | head'
  git log --color=always --format=oneline --abbrev-commit --decorate | head $argv; 
end
