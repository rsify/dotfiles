# Defined via `source`
function ct --wraps='vim ~/.tmux.conf' --description 'alias ct vim ~/.tmux.conf'
  vim ~/.tmux.conf $argv; 
end
