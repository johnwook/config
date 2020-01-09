" vim-plug(https://github.com/junegunn/vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

" Git
Plug 'airblade/vim-gitgutter'

" FZF
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Markdown
Plug 'godlygeek/tabular'

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Theme
Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'

" Editor
Plug 'jiangmiao/auto-pairs'
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

" Plugin specific configuration
let g:coc_node_path='/Users/johnwook/.asdf/installs/nodejs/12.14.1/bin/node'
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \ 'coc-yank'
  \ ]

let g:indent_guides_enable_on_vim_startup = 1
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
let g:sneak#label = 1

" Executables
let g:python3_host_prog='/Users/johnwook/.virtualenvs/neovim/bin/python'
let g:python_host_prog='/Users/johnwook/.virtualenvs/neovim2/bin/python'
let g:ruby_host_prog='/Users/johnwook/.asdf/installs/ruby/2.7.0/lib/ruby/gems/2.7.0/gems/neovim-0.8.1/exe/neovim-ruby-host'
let g:node_host_prog='/Users/johnwook/.asdf/installs/nodejs/12.14.1/.npm/lib/node_modules/neovim/bin/cli' 

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

" coc.nvim
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

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

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> <space>y  :<C-u>CocList --normal yank<cr>
nnoremap <F5> :UndotreeToggle<cr>

" prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
