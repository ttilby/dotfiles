-- https://github.com/folke/trouble.nvim

local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
    return
end

trouble.setup({})

vim.cmd([[nnoremap <leader>xx :TroubleToggle<cr>]])
vim.cmd([[nnoremap <leader>xq :TroubleToggle quickfix<cr>]])
vim.cmd([[nnoremap gr :TroubleToggle lsp_references<cr>]])
