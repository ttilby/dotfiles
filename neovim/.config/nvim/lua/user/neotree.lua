-- https://github.com/nvim-neo-tree/neo-tree.nvim

local neotree_status_ok, neotree = pcall(require, "neo-tree")
if not neotree_status_ok then
    return
end

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
    popup_border_style = "rounded",
    window = {
        position = "right"
    },
    default_component_configs = {
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "✖",-- this can only be used in the git_status source
                renamed   = "󰁕",-- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "󰄱",
                staged    = "",
                conflict  = "",
            }
        },
    },
    filesystem = {
        components = {
            -- Simply flag entries that are symlinks (no target path).
            symlink_marker = function(config, node, state)
                if node.is_link then
                    -- U+F0C1 (nf-fa-link) written as explicit UTF-8 bytes so the
                    -- glyph survives edits that strip PUA codepoints. This lives in
                    -- the FontAwesome range the configured Nerd Font covers.
                    return {
                        text = "\239\131\129 ",
                        highlight = config.highlight or "NeoTreeSymbolicLinkTarget",
                    }
                end
                return {}
            end,
        },
        renderers = {
            directory = {
                { "indent" },
                { "icon" },
                { "current_filter" },
                {
                    "container",
                    content = {
                        { "name", zindex = 10 },
                        { "symlink_marker", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
                        { "clipboard", zindex = 10 },
                        { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
                        { "git_status", zindex = 20, align = "right", hide_when_expanded = true },
                    },
                },
            },
            file = {
                { "indent" },
                { "icon" },
                {
                    "container",
                    content = {
                        { "name", zindex = 10 },
                        { "symlink_marker", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
                        { "clipboard", zindex = 10 },
                        { "bufnr", zindex = 10 },
                        { "modified", zindex = 20, align = "right" },
                        { "diagnostics", zindex = 20, align = "right" },
                        { "git_status", zindex = 20, align = "right" },
                    },
                },
            },
        },
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
        use_libuv_file_watcher = true,
    },
    buffers = {
        show_unloaded = true,
    }
})

-- Make symlink targets visually distinct (option 3)
vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { fg = "#89b4fa", italic = true })

-- mappings
vim.cmd([[nnoremap <leader>p :Neotree toggle reveal_force_cwd<cr>]])
vim.cmd([[nnoremap <leader>o :Neotree float buffers<cr>]])
