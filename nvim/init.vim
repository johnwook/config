" Python
" let g:python_host_prog = '/Users/johnwook/.pyenv/versions/neovim2/bin/python'
" let g:python3_host_prog = '/Users/johnwook/.pyenv/versions/neovim3/bin/python'

" vim-plug(https://github.com/junegunn/vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" Or if you have Neovim >= 0.1.5
set termguicolors

" Theme
" colorscheme OceanicNext
" let g:lightline = {
"       \ 'colorscheme': 'oceanicnext',
"       \ }

" Editor
set expandtab
set tabstop=2
set shiftwidth=2
set number relativenumber
set splitright

" let g:indent_guides_enable_on_vim_startup = 1
" if exists('&signcolumn')  " Vim 7.4.2201
"   set signcolumn=yes
" else
"   let g:gitgutter_sign_column_always = 1
" endif

" Encoding
set fileencoding=utf-8
set encoding=utf-8

set updatetime=300
set hidden
