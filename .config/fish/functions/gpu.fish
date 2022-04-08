function gpu --wraps='git pull' --wraps='git push -u origin master' --description 'alias gpu git push -u origin master'
  git push -u origin master $argv; 
end
