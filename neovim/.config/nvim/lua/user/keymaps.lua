vim.g.mapleader = " "

-- Stop highlight after searching
vim.keymap.set("n", "<leader>,", ":noh<cr>", { silent = true })

-- Buffer management (bufexplorer)
vim.keymap.set("n", "<F5>", ":ToggleBufExplorer<CR>")

-- UndoTree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- F10: show highlight group under cursor
vim.keymap.set("", "<F10>", ':echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . \'> trans<\' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>')

-- Set registers
vim.fn.setreg("x", "        breakpoint()", "l")
