" ~/.vimrc

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'

call plug#end()

nmap <C-_> gcc
vmap <C-_> gc

syntax enable
filetype plugin indent on

set number
set relativenumber
set laststatus=2
set list
set listchars=tab:>·,trail:·,extends:…,precedes:…
set termguicolors
set ignorecase
set smartcase
set noerrorbells
set noswapfile
set autoread
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set scrolloff=10
set updatetime=1000
set spelllang=en,pl
set spelloptions=camel
set complete+=kspell
set path+=**

set background=dark
colorscheme gruvbox

let mapleader = " "

" Navigation
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap YY :%y+<CR>
nnoremap <Esc> :noh<CR>
vnoremap < <gv
vnoremap > >gv
nnoremap K i<CR><Esc>
