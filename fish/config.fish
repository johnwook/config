starship init fish | source
zoxide init fish | source
source (brew --prefix asdf)/libexec/asdf.fish

set FZF_CTRL_T_COMMAND fd --type f --hidden --follow --exclude .git . \$dir
set FZF_CTRL_T_OPTS "
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --border"
set FZF_ALT_C_COMMAND fd --type d --hidden --follow --exclude .git . \$dir
set FZF_ALT_C_OPTS "--preview='tree -C {}'"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/johnwook/google-cloud-sdk/path.fish.inc' ]; . '/Users/johnwook/google-cloud-sdk/path.fish.inc'; end
