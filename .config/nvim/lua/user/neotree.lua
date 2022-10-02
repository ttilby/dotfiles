-- https://github.com/nvim-neo-tree/neo-tree.nvim

local neotree_status_ok, neotree = pcall(require, "neo-tree")
if not neotree_status_ok then
    return
end

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError",
{text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",
{text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",
{text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",
{text = "", texthl = "DiagnosticSignHint"})
-- NOTE: this is changed from v1.x, which used the old style of highlight groups
-- in the form "LspDiagnosticsSignWarning"


neotree.setup({
    close_if_last_window = true,
    window = {
        position = "right"
    },
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
        use_libuv_file_watcher = true,
    }
})

-- mappings
vim.cmd([[nnoremap <leader>p :Neotree toggle reveal_force_cwd<cr>]])
vim.cmd([[nnoremap <leader>b :Neotree float buffers<cr>]])
