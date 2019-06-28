" vim-plug(https://github.com/junegunn/vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" FZF
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

" Plugin specific configuration
let g:vim_markdown_folding_disabled=1

" Executables
let g:python3_host_prog='/Users/johnwook/.virtualenvs/neovim/bin/python'
let g:python_host_prog='/Users/johnwook/.virtualenvs/neovim2/bin/python'

" Vim configuration
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
