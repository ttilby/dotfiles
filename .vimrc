" ./vimrc

" AutoLoad
" vim-pathogen-git - https://github.com/tpope/vim-pathogen

" Install Notes
" vim-gitgutter - https://github.com/airblade/vim-gitgutter
" vim-airline - https://github.com/vim-airline/vim-airline
" nerdtree - https://github.com/scrooloose/nerdtree

" Colors
" Link to included wallaby.vim file
" ln -s ~/dotfiles/colors/wallaby.vim ~/.vim/colors/wallaby.vim
"
" gruvbox
" git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" General Config
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set number                        " line numbers
set showmode                      " Show current mode at the bottom
set hlsearch                      " highlight searches
set incsearch                     " highlight dynamically as pattern is typed
set clipboard=unnamed             " Use the OS clipboard by default
set showmode                      " Show the current mode
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Document Width 
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set tw=79                         " width of document (used by gd)
set nowrap                        " Don't automatically wrap on load
set fo-=t                         " Don't automatically wrap text when typing
set colorcolumn=120               " Set right bar
highlight ColorColumn ctermbg=233

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Key Bindings
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
let mapleader = ","


" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Colors
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set t_Co=256
syntax enable 
filetype off
filetype plugin indent on
colorscheme wallaby
set guifont=Liberation\ Mono\ for\ Powerline\ 13


" ===== Plugins       ======
" Pathogen
execute pathogen#infect()
execute pathogen#helptags()

" ===== Solarized =====
"set background=dark
"colorscheme solarized 

" ===== gruvbox ======
" colorscheme gruvbox
colorscheme brogrammer
" colorscheme gruvbox
" colorscheme darkside

" ===== NERD Tree =====
" autocmd vimenter * NERDTree


" Make comments italic (must be after any theme settings)
highlight Comment cterm=italic      

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Airline Config
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Note: you need UTF8 support and a Poweline patched font
" /etc/locale.conf
"     LANG=en_US.utf8
set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:bufferline_echo = 0

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" NerdTREE (Git)
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
noremap <C-p> :NERDTreeToggle<CR>     " use Ctrl-p to open/close NERDTree
" autocmd vimenter * NERDTree         " auto open NERDTree when vim starts
let NERDTreeShowHidden=1                  " show hidden files by default

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Fugitive
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set diffopt+=vertical                 " use vertical split for :Gdiff
