if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end

source /opt/local/share/asdf/asdf.fish
source /opt/local/share/fzf/shell/key-bindings.fish

starship init fish | source
zoxide init fish | source

# FZF
set FZF_CTRL_T_COMMAND fd --type f --hidden --follow --exclude .git . \$dir
set FZF_CTRL_T_OPTS "
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --border"
set FZF_ALT_C_COMMAND fd --type d --hidden --follow --exclude .git . \$dir
set FZF_ALT_C_OPTS "--preview='tree -C {}'"

# ZELLIJ
set ZELLIJ_AUTO_ATTACH true
set ZELLIJ_AUTO_EXIT true

# SSH
set SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
