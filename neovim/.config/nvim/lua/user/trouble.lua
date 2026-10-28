-- https://github.com/folke/trouble.nvim

local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
    return
end

trouble.setup({})

-- trouble.nvim v3 command syntax: :Trouble <mode> <action>
-- (replaces the old v2 :TroubleToggle command, which no longer exists)
vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>",
  { desc = "Trouble: toggle diagnostics" })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>",
  { desc = "Trouble: toggle quickfix list" })
vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references toggle<cr>",
  { desc = "Trouble: LSP references" })
