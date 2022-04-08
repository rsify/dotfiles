function bup --wraps='brew upgrade' --description 'alias bup brew upgrade'
  brew upgrade $argv; 
end
