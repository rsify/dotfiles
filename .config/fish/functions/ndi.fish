# Defined in - @ line 1
function ndi --wraps='npm install -D' --description 'alias ndi npm install -D'
  npm install -D $argv;
end
