function tm --wraps tmux
  tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf $agrv
end
