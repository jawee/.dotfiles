syntax on

set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set expandtab
set shiftwidth=2
set tabstop=2 softtabstop=2
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
" set termguicolors
set scrolloff=8

set cmdheight=2

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set background=dark

if executable('rg')
  let g:rg_derive_root='true'
endif

let loaded_matchparen = 1

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "
let g:netrw_browse_split=2

let g:netrw_winsize = 25

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
