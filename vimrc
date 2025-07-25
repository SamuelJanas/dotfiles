" ~/.vimrc

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'

call plug#end()

nmap <C-_> gcc
vmap <C-_> gc

syntax enable
filetype plugin indent on
set background=dark
colorscheme gruvbox

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

let mapleader = " "

" Navigation
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap YY :%y+<CR>
nnoremap <Esc> :noh<CR>
vnoremap < <gv
vnoremap > >gv
nnoremap K i<CR><Esc>

" FZF keybindings
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>e :Explore<CR>

" Toggle spellcheck
nnoremap <leader>sc :setlocal spell!<CR>


call plug#end()

syntax enable
filetype plugin indent on
set background=dark
colorscheme gruvbox

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
set hlsearch
set scrolloff=10
set updatetime=1000
set spelllang=en,pl
set spelloptions=camel
set complete+=kspell
set path+=**

let mapleader = " "

" Navigation
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap YY :%y+<CR>
nnoremap <Esc> :noh<CR>
vnoremap < <gv
vnoremap > >gv
nnoremap K i<CR><Esc>

" FZF keybindings
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>e :Explore<CR>

" Toggle spellcheck
nnoremap <leader>sc :setlocal spell!<CR>

