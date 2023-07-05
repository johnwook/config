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

# Homebrew
set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
set -q PATH; or set PATH ''; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

# pnpm
set -gx PNPM_HOME "/Users/johnwook/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
>>>>>>> Stashed changes
