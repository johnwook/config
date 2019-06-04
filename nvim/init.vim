" Python
" let g:python_host_prog = '/Users/johnwook/.pyenv/versions/neovim2/bin/python'
" let g:python3_host_prog = '/Users/johnwook/.pyenv/versions/neovim3/bin/python'

" vim-plug(https://github.com/junegunn/vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()


" Theme
" colorscheme OceanicNext
" let g:lightline = {
"       \ 'colorscheme': 'oceanicnext',
"       \ }
"
set termguicolors

set fileencodings=utf-8,euc-kr,latin1

set expandtab
set number relativenumber
set shiftwidth=2
set tabstop=2

set hidden
set splitbelow
set splitright

set updatetime=100

set signcolumn=yes
