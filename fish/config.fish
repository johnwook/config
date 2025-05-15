eval "$(/opt/homebrew/bin/brew shellenv)"
fzf --fish | source
starship init fish | source
zoxide init fish | source

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# asdf-golang
set -l _asdf_golang_plugin_dir $ASDF_DATA_DIR
if test -z "$_asdf_golang_plugin_dir"
  set _asdf_golang_plugin_dir "$HOME/.asdf"
end
source "$_asdf_golang_plugin_dir/plugins/golang/set-env.fish"

# FZF
set FZF_CTRL_T_COMMAND "fd --type f --hidden --follow --exclude .git . \$dir"
set FZF_CTRL_T_OPTS "
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --border"
set FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git . \$dir"
set FZF_ALT_C_OPTS "--preview='dust -br {}'"

# SSH
# set SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# pnpm
set -gx PNPM_HOME "/Users/johnwook/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end

