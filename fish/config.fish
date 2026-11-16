/opt/homebrew/bin/brew shellenv fish | source

fzf --fish | source
starship init fish | source
zoxide init fish | source

# FZF
set FZF_CTRL_T_COMMAND "fd --type f --hidden --follow --exclude .git . \$dir"
set FZF_CTRL_T_OPTS "
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --border"
set FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git . \$dir"
set FZF_ALT_C_OPTS "--preview='dust -br {}'"

fish_add_path "$HOME/.local/bin"

# bat configuration
set -gx BAT_THEME "ansi"

# Pulumi
fish_add_path --global "$HOME/.pulumi/bin"

mise activate fish --shims | source
if status is-interactive
    mise activate fish | source
    if not set -q CODEX_SHELL
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
