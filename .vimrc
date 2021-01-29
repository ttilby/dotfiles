" ./vimrc

" Installation:
" !! These steps may no long be needed since I migrated to vim-plug
" 1. install pathogen
" 2. cd ~
" 3. yadm submodule update --init --recursive
" 	if there are problems with the submodules, delete them locally first
" 	then try running this again
"
" Steps 2 and 3 will need to be done if a new submodule is added on another
" computer

" Updating:
" 1. yadm pull --recurse-submodules
" 2. yadm submodule update --remote --recursive

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


" Colors
" Link to included wallaby.vim file
" ln -s ~/dotfiles/colors/wallaby.vim ~/.vim/colors/wallaby.vim
"
" gruvbox
" git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" vim-plug
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'jlanzarotta/bufexplorer'
Plug 'nvie/vim-flake8'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-obsession'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-python/python-syntax'
" Plug 'tmhedberg/SimpylFold'

" Initialize plugin system
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


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
" set cursorline
" set cursorcolumn
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set mouse=a mousemodel=popup
" set ruler
set wildmenu
set wildmode=list:longest,full

" folding
set foldmethod=indent
set foldlevelstart=20

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
" nnoremap <leader>dc :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>df :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>r :YcmCompleter GoToReferences<CR>

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Conquer of Completion
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
source $HOME/.vim/modules/coc.vim

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" FZF
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Search for files
nnoremap <leader>f :FZF<CR>
" search for content
nnoremap <leader>g :Rg <CR>
" search for content using word under cursor
nnoremap <leader>d :Rg <C-R><C-W><CR>
let g:fzf_layout = { 'down': '40%' }

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Colors
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set t_Co=256
syntax enable 
filetype off
filetype plugin indent on
" set guifont=Liberation\ Mono\ for\ Powerline\ 13
set guifont=Hack\ Regular\ Nerd\ Font\ Complete 

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" vim-python
" https://github.com/vim-python/python-syntax.git
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
let g:python_highlight_all = 1


" ===== Background =====
" used by some themes, can be dark or light
set background=dark

colorscheme ThemerVim

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
let g:airline#extensions#coc#enabled = 1
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
" CHADTree
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" nnoremap <C-p> <cmd>CHADopen<cr>

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

" Use F10 to show what highlight group is actually used by the word under the
" cursor.
" https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
