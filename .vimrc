" ./vimrc

" Installation:
" 1. install pathogen
" 2. git submodule init
" 3. git submodule update --recursive
"
" Steps 2 and 3 will need to be done if a new submodule is added on another
" computer

" AutoLoad
" vim-pathogen-git - https://github.com/tpope/vim-pathogen

" Required external programs
" 1. fzf
"       need to ensure the runtime path (rtp) below is properly set
" 2. ripgrep

" NeoVim---------------
" If switching to neovim, run these commands to link up original vim configs
" ln -s ~/.vimrc ~/.config/nvim/init.vim
" ln -s ~/.vim/bundle ~/.config/nvim/bundle
" ln -s ~/.vim/autoload ~/.config/nvim/autoload
" ln -s ~/.vim/colors ~/.config/nvim/colors

" Install Notes
" vim-gitgutter - https://github.com/airblade/vim-gitgutter
" vim-airline - https://github.com/vim-airline/vim-airline
" nerdtree - https://github.com/scrooloose/nerdtree
" flake8 - git@github.com:nvie/vim-flake8.git (python checking)
"        - require local install of flake8
"        - pip install flake8
" vim-obession - git://github.com/tpope/vim-obsession.git
" YouCompleteMe - https://github.com/ycm-core/YouCompleteMe.git
"        - requires additional installation:
"           - cd ~/.vim/bundle/YouCompleteMe
"           - ./install.py

" Colors
" Link to included wallaby.vim file
" ln -s ~/dotfiles/colors/wallaby.vim ~/.vim/colors/wallaby.vim
"
" gruvbox
" git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" General Config
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if &compatible
    set nocompatible
endif

" hybrid line numbers
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * set norelativenumber
augroup END

" Save whenever switching windows or leaving vim
au FocusLost,WinLeave * :silent! wa

set showmode                      " Show current mode at the bottom
set hlsearch                      " highlight searches
set incsearch                     " highlight dynamically as pattern is typed
set ignorecase                    " case insensitive search (unless specified)

set smartcase                     " override ignorecase if search string has capitals
" set clipboard=unnamed             " Use the OS clipboard by default
set clipboard+=unnamedplus
set showmode                      " Show the current mode
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set mouse=a mousemodel=popup
" set ruler
set wildmenu
set wildmode=list:longest,full

" remove trailing whitespace on save
" autocmd BufWritePre * :%s/\s\+$//e

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Document Width 
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set tw=79                         " width of document (used by gd)
set nowrap                        " Don't automatically wrap on load
set fo-=t                         " Don't automatically wrap text when typing
set colorcolumn=88                " Set right bar
highlight ColorColumn ctermbg=233
set scrolloff=8                   " Start scrolling when x lines away from margins

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Key Bindings
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
let mapleader = ","

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Buffer management
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" manual management
" nnoremap <F5> :buffers<CR>:buffer<Space>
" using bufexplorer plugin
nnoremap <F5> :ToggleBufExplorer<CR>


" Stop highlight after searching
nnoremap <silent> <leader>, :noh<cr>

" Change split navigation to not
" require 'CTRL-W'. 
" Just use 'CTRL-H/J/K/L' 
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>   

" YouCompleteMe
nnoremap <leader>dc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>df :YcmCompleter GoToDefinition<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>

" FZF
nnoremap <leader>f :FZF<CR>
nnoremap <leader>g :Rg<CR>
if isdirectory("/home/todd/.fzf")
    set rtp+=~/.fzf
endif
if isdirectory("/usr/local/opt/fzf")
    set rtp+=/usr/local/opt/fzf
endif

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Colors
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set t_Co=256
syntax enable 
filetype off
filetype plugin indent on
" colorscheme wallaby
set guifont=Liberation\ Mono\ for\ Powerline\ 13

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Netrw
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" let g:netrw_liststyle = 3
" let g:netrw_winsize = 25
" let g:netrw_browse_split = 4

" ===== FZF.vim =======
" https://github.com/junegunn/fzf#installation
"set runtimepath+=~/.fzf 

" ===== Plugins       ======
" Pathogen - this will auto load plugins from .vim/bundle
execute pathogen#infect()
execute pathogen#helptags()
filetype plugin indent on

" ===== Solarized =====
"set background=dark
"colorscheme solarized 

" ===== gruvbox ======
" colorscheme gruvbox
colorscheme brogrammer
" colorscheme darkside

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
" adds an indicator (default "$") to the status line if session is currently
" tracked by vim-obsession
let g:airline#extensions#obession#enabled = 1
let g:bufferline_echo = 0

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" NerdTREE (Git)
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" use Ctrl-p to open/close NERDTree
noremap <C-p> :NERDTreeToggle<CR>
noremap <leader>p :NERDTreeFind<CR>
" auto open NERDTree when vim starts
" autocmd vimenter * NERDTree         
" auto open NERDTree when vim starts if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" close vim if only window left open in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" show hidden files by default
let NERDTreeShowHidden=1


" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Fugitive
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" set diffopt+=vertical                 " use vertical split for :Gdiff

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Flake (python checking)
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" automatically check style when writing python code
let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1

autocmd BufWritePost *.py call Flake8()
