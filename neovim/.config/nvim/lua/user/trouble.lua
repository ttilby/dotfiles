-- https://github.com/folke/trouble.nvim

local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
    return
end

trouble.setup({})

vim.cmd([[nnoremap <leader>tt :TroubleToggle<cr>]])
vim.cmd([[nnoremap <leader>tq :TroubleToggle quickfix<cr>]])
vim.cmd([[nnoremap gr :Trouble lsp_references<cr>]])
