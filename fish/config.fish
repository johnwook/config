source /opt/homebrew/opt/asdf/libexec/asdf.fish

eval "$(/opt/homebrew/bin/brew shellenv)"
fzf --fish | source
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

# SSH
set SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# pnpm
set -gx PNPM_HOME "/Users/johnwook/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end

test -f ~/.inshellisense/fish/init.fish && source ~/.inshellisense/fish/init.fish
