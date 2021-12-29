" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" FZF
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" Useful Commands
" :command Rg - will show the current code for the given command

" Custom Functions

" The default implementation (see :command Rg) will use fzf to fuzzy-find the
" output of the ripgrep command.
" This function will turn fzf into a simple selector and delegate all the
" searching to the ripgrep process. This avoids the issue of searching for a
" specific number (e.g. 252) and getting all files with a line number of 252.
" Update - this also prevents the use of fzf features to filter the results
" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


" Search for files
nnoremap <leader>f :FZF<CR>
" search for content (:Rg will use the built in command, :RG will use the custom function)
nnoremap <leader>g :Rg <CR>
" search for content using word under cursor
" nnoremap <leader>d :Rg <C-R><C-W><CR>
let g:fzf_layout = { 'down': '40%' }
