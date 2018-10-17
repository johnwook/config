" Python
let g:python_host_prog = '/Users/johnwook/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/johnwook/.pyenv/versions/neovim3/bin/python'

" vim-plug(https://github.com/junegunn/vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'mhartington/oceanic-next'
Plug 'mhinz/vim-startify'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-sensible'

Plug '/usr/local/opt/fzf'

" Initialize plugin system
call plug#end()

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
colorscheme OceanicNext
let g:lightline = {
      \ 'colorscheme': 'oceanicnext',
      \ }

" Editor
set expandtab
set tabstop=2
set shiftwidth=2
set number

" Encoding
set fileencoding=utf-8
set encoding=utf-8

set updatetime=300
