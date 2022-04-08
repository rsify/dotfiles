function lsa --wraps='exa -ax --sort type' --description 'alias lsa exa -ax --sort type'
  exa -ax --sort type $argv; 
end
