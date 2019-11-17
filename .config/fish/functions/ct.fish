# Defined in - @ line 1
function ct --wraps='vim ~/.tmux.conf' --description 'alias ct vim ~/.tmux.conf'
    vim ~/.tmux.conf $argv;
end
