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
Plug 'sheerun/vim-polyglot'
Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'

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
syntax on
colorscheme iceberg

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" coc.nvim
autocmd FileType json syntax match Comment +\/\/.\+$+

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Setup keymap to open yank list like:
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr><Paste>

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" To enable highlight current symbol on CursorHold, add:
autocmd CursorHold * silent call CocActionAsync('highlight')
