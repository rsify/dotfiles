function gsuba --wraps='git submodule add' --description 'alias gsuba git submodule add'
  git submodule add $argv; 
end
