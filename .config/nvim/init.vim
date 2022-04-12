" ./vimrc

" Required external programs
"       need to ensure the runtime path (rtp) below is properly set
" 2. ripgrep
" 3. flake8

" NeoVim---------------
" If switching to neovim, run these commands to link up original vim configs
" ln -s ~/.vimrc ~/.config/nvim/init.vim
" ln -s ~/.vim/bundle ~/.config/nvim/bundle
" ln -s ~/.vim/autoload ~/.config/nvim/autoload
" ln -s ~/.vim/colors ~/.config/nvim/colors

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Upgrading to latest nightly NeoVim
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
" curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o ~/Downloads/nvim-nightly
"  or
" curl -L https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage -o ~/Downloads/nvim-stable
"
" chmod u+x nvim-nightly
" ./nvim-nightly --version
" rm /usr/local/bin/nvim
" mv nvim-nightly /usr/local/bin/nvim_0.5.0-dev1354
" cp /usr/local/bin/nvim_0.5.0-dev1354 /usr/local/bin/nvim
" nvim --version

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Useful info
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" https://github.com/nanotee/nvim-lua-guide
"
" LSP -----------------
" LspInstallInfo to install / update language servers

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Python virtual env's for neovim
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" See https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
"
" $ pyenv install 2.7.18
" $ pyenv virtualenv 2.7.18 neovim2
" $ pyenv activate neovim2
" $ pip install neovim
" $ pyenv which python
let g:python_host_prog = '/home/todd/.pyenv/versions/neovim2/bin/python'
" $ pyenv install 3.7.8
" $ pyenv virutalenv 3.7.8 neovim3
" $ pyenv activate neovim3
" $ pip install neovim
" $ pyenv which python
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
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'kyazdani42/nvim-web-devicons'
Plug 'glepnir/galaxyline.nvim'
" Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-obsession'
" Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'towolf/vim-helm'
Plug 'mbbill/undotree'
" Plug 'puremourning/vimspector'
Plug 'hashivim/vim-terraform'
" Plug 'jvirtanen/vim-hcl'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" nvim-cpm
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

if has("nvim-0.5")
    Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}
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
" use `set ft?` to see filetype of current buffer
let nu_blacklist = ['NvimTree', 'nerdtree']
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if index(nu_blacklist, &ft) < 0 | set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if index(nu_blacklist, &ft) < 0 | set norelativenumber
augroup END

" Save whenever switching windows or leaving vim
au FocusLost,WinLeave * :silent! wa

" set showmode                      " Show current mode at the bottom
" set hlsearch                      " highlight searches
" set incsearch                     " highlight dynamically as pattern is typed
" set ignorecase                    " case insensitive search (unless specified)
" set smartcase                     " override ignorecase if search string has capitals
" set clipboard=unnamed             " Use the OS clipboard by default
" set clipboard+=unnamedplus
" set showmode                      " Show the current mode
" set hidden                        " keeps modified buffers in the background
" set cursorline
" set cursorcolumn
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
" set shiftround
" set expandtab
" set noswapfile
" set nobackup
" set mouse=a mousemodel=popup
" set ruler
" set wildmenu
" set wildmode=list:longest,full
" set termguicolors
" set signcolumn=yes

" Stop highlight after searching
nnoremap <silent> <leader>, :noh<cr>

let mapleader = " "

" folding
" set foldmethod=indent
set foldlevelstart=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" remove trailing whitespace on save
" If this needs to be temporarily disabled:
"   set eventignore=BufWritePre
"   Then save the file
"   To re-enable:
"   set eventignore=""
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup CUSTOM
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END

" Set registers
call setreg("x", "        import pdb; pdb.set_trace()", "l")

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
" Buffer management
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" using bufexplorer plugin
nnoremap <F5> :ToggleBufExplorer<CR>


" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Colors
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
set t_Co=256
syntax enable
filetype off
filetype plugin indent on
" set guifont=Liberation\ Mono\ for\ Powerline\ 13
set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ 13

" ===== Background =====
" used by some themes, can be dark or light
set background=dark

" colorscheme ThemerVim
" colorscheme gruvbox
colorscheme base16-onedark


" Make comments italic (must be after any theme settings)
highlight Comment cterm=italic gui=italic

" Use F10 to show what highlight group is actually used by the word under the
" cursor.
" https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Lua configs
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
lua require('user.options')
lua require('user.lsp')
lua require('user.cmp')
lua require('user.galaxyline_yutkat')
lua require('user.gitsigns')

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Treesitter (0.5 only)
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if has("nvim-0.5")
lua << EOF
require'nvim-treesitter.configs'.setup {
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {"python", "bash", "json", "lua", "dockerfile", "yaml"},
    highlight = {
        enable = true,              -- false will disable the whole extension
    },
    indent = {
        enable = false,             -- removed to fix python indentation 08/04/2021
    },
}
EOF
endif

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Flake (python checking)
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" automatically check style when writing python code
let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1

augroup flake
    autocmd!
    autocmd BufWritePost *.py call Flake8()
augroup END

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" UndoTree
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" https://github.com/mbbill/undotree
nnoremap <leader>u :UndotreeToggle<CR>
set undodir=~/vim/undodir
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

" nnoremap <leader>dd :call vimspector#Launch()<CR>
" nnoremap <leader>de :call vimspector#Reset()<CR>
"
" nmap <leader>dl <Plug>VimspectorStepInto
" nmap <leader>dj <Plug>VimspectorStepOver
" nmap <leader>dk <Plug>VimspectorStepOut
" nmap <leader>d_ <Plug>VimspectorRestart
" nmap <leader>d5 <Plug>VimspectorContinue
" nmap <leader>db <Plug>VimspectorToggleBreakpoint
" nmap <leader>dcb <Plug>VimspectorToggleConditionalBreakpoint

" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" vim-terraform
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" https://github.com/hashivim/vim-terraform
let g:hcl_align=1
let g:terraform_align=1
let g:terraform_fmt_on_save=1
augroup custom_terraform
    autocmd!
    autocmd BufRead,BufNewFile *.hcl set filetype=terraform
augroup END

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
