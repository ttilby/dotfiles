" ./vimrc

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
" gruvbox
" git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox

" =-=-=-=-=
" Python virtual env's for neovim
" =-=-=-=-=
" See https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
"
" $ pyenv install 2.7.18
" $ pyenv virtualenv 2.7.18 neovim2
" $ pyenv activate neovim2
" $ pyenv which python
let g:python_host_prog = '/home/todd/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/todd/.pyenv/versions/neovim3/bin/python'

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" vim-plug
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Add plugins below, source .vimrc with ':so %' and run :PlugInstall
" or restart vim for this to happen automatically

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
Plug 'gruvbox-community/gruvbox'
Plug 'chriskempson/base16-vim'
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'vim-airline/vim-airline'
Plug 'glepnir/galaxyline.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-obsession'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'towolf/vim-helm'
Plug 'mbbill/undotree'
Plug 'puremourning/vimspector'
Plug 'hashivim/vim-terraform'

if has("nvim-0.5")
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
else
    Plug 'vim-python/python-syntax'
endif

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
set hidden                        " keeps modified buffers in the background
" set cursorline
" set cursorcolumn
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set noswapfile
set nobackup
set mouse=a mousemodel=popup
" set ruler
set wildmenu
set wildmode=list:longest,full
set termguicolors

" folding
set foldmethod=indent
set foldlevelstart=20

" remove trailing whitespace on save
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup CUSTOM
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END


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
let mapleader = " "

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
" nnoremap <leader>d :Rg <C-R><C-W><CR>
let g:fzf_layout = { 'down': '40%' }

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Colors
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set t_Co=256
syntax enable
filetype off
filetype plugin indent on
" set guifont=Liberation\ Mono\ for\ Powerline\ 13
set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ 13

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" vim-python
" https://github.com/vim-python/python-syntax.git
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" let g:python_highlight_all = 1


" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Treesitter (0.5 only)
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if has("nvim-0.5")
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "python", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
    },
    indent = {
        enable = true
    }
}
EOF
endif


" ===== Background =====
" used by some themes, can be dark or light
set background=dark

" colorscheme ThemerVim
" colorscheme gruvbox
colorscheme base16-onedark


" Make comments italic (must be after any theme settings)
highlight Comment cterm=italic gui=italic

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Airline Config
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Note: you need UTF8 support and a Poweline patched font
" /etc/locale.conf
"     LANG=en_US.utf8

" set laststatus=2
" set ttimeoutlen=50
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" " adds an indicator (default "$") to the status line if session is currently
" " tracked by vim-obsession
" let g:airline#extensions#obession#enabled = 1
" let g:airline#extensions#coc#enabled = 1
" let g:bufferline_echo = 0

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" GalaxyLine Config
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" https://github.com/glepnir/galaxyline.nvim
lua << EOF
    -- require('plugins.galaxyline')
    -- require('plugins.galaxyline_siduck76')
    require('plugins.galaxyline_yutkat')
EOF

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" NerdTREE
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" use Ctrl-p to open/close NERDTree
" noremap <C-p> :NERDTreeToggle<CR>
" noremap <leader>p :NERDTreeFind<CR>

" noremap <silent> <expr> <leader>p g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
"
"
" " auto open NERDTree when vim starts if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
" " close vim if only window left open in NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
" " show hidden files by default
" let NERDTreeShowHidden=1
"
" " used by vim-devicons
" let g:webdevicons_enable_nerdtree = 1
" let g:webdevicons_enable_airline_statusline = 1

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Nvim Tree
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" https://github.com/kyazdani42/nvim-tree.lua
source $HOME/.config/nvim/plugins/nvim-tree.vim


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

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" UndoTree
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" https://github.com/mbbill/undotree
nnoremap <leader>u :UndotreeToggle<CR>
set undodir=~/.vim/undodir
set undofile

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Vimspector
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" <Plug>VimspectorStop
" <Plug>VimspectorRestart
" <Plug>VimspectorPause
" <Plug>VimspectorToggleBreakpoint
" <Plug>VimspectorToggleConditionalBreakpoint
" <Plug>VimspectorAddFunctionBreakpoint
" <Plug>VimspectorRunToCursor
" <Plug>VimspectorBalloonEval

nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nmap <leader>d5 <Plug>VimspectorContinue
nmap <leader>db <Plug>VimspectorToggleBreakpoint
nmap <leader>dcb <Plug>VimspectorToggleConditionalBreakpoint

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" vim-terraform
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" https://github.com/hashivim/vim-terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1
