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

" Editor
Plug 'nelstrom/vim-visual-star-search'
Plug 'mbbill/undotree'
Plug 'junegunn/vim-peekaboo'

" Initialize plugin system
call plug#end()

" Plugin specific configuration
let g:vim_markdown_folding_disabled=1

" Executables
let g:coc_node_path='/Users/johnwook/.asdf/installs/nodejs/10.16.0/bin/node'

let g:python3_host_prog='/Users/johnwook/.virtualenvs/neovim/bin/python'
let g:python_host_prog='/Users/johnwook/.virtualenvs/neovim2/bin/python'
let g:ruby_host_prog='/Users/johnwook/.asdf/installs/ruby/2.6.3/lib/ruby/gems/2.6.0/gems/neovim-0.8.1/exe/neovim-ruby-host'
let g:node_host_prog='/Users/johnwook/.asdf/installs/nodejs/10.16.0/.npm/lib/node_modules/neovim/bin/cli' 
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

" coc.nvim
" commenthighlighting
" - https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
autocmd FileType json syntax match Comment +\/\/.\+$+

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" prettier
" - https://github.com/neoclide/coc-prettier#setup-prettier-command-in-your-initvim-or-vimrc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
