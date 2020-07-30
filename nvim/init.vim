" vim-plug(https://github.com/junegunn/vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

" Git
Plug 'airblade/vim-gitgutter'

" FZF
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Theme
Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'

" Editor
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'justinmk/vim-gtfo'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nelstrom/vim-visual-star-search'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" Focus
Plug 'junegunn/limelight.vim' 
Plug 'junegunn/goyo.vim' 

" Initialize plugin system
call plug#end()

" Plugin configurations
let g:indent_guides_enable_on_vim_startup = 1
let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ }
let g:sneak#label = 1

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
set updatetime=300
set signcolumn=yes
set cmdheight=2
colorscheme iceberg
autocmd FileType json syntax match Comment +\/\/.\+$+

" Key bindings
nnoremap <F5> :UndotreeToggle<cr>
vmap '' "+y
