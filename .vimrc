" ./vimrc

" AutoLoad
" vim-pathogen-git - https://github.com/tpope/vim-pathogen



" ===== General Config ======
syntax on            " syntax highlighting   
set number           " line numbers
set showmode         " Show current mode at the bottom
set t_Co=256         " support for 256 colors
set hlsearch         " highlight searches
set incsearch        " highlight dynamically as pattern is typed
set clipboard=unnamed" Use the OS clipboard by default
set showmode         " Show the current mode

" ===== Document Width =====
set tw=79           " width of document (used by gd)
set nowrap          " Don't automatically wrap on load
set fo-=t           " Don't automatically wrap text when typing
set colorcolumn=80  " Set right bar
highlight ColorColumn ctermbg=233

" ===== Plugins       ======
" Pathogen
execute pathogen#infect()

" Install Notes
" vim-gitgutter

" ===== NERD Tree =====
autocmd vimenter * NERDTree
