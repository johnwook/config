# Defined in - @ line 1
function ll --wraps='lsd -l' --description 'alias ll=lsd -l'
  lsd -l $argv;
end
