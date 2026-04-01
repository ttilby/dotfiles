-- Python virtual env for neovim
vim.g.python3_host_prog = '/home/todd/.virtualenvs/nvimvenv/bin/python'

-- ============================================================================
-- vim.pack — plugin declarations
-- Update all:    :lua vim.pack.update()
-- Update one:    :lua vim.pack.update("nvim-treesitter")
-- ============================================================================
vim.pack.add({
    "https://github.com/jlanzarotta/bufexplorer",
    "https://github.com/navarasu/onedark.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/nvim-lua/plenary.nvim",
    -- Icons
    "https://github.com/kyazdani42/nvim-web-devicons",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/junegunn/fzf",
    "https://github.com/junegunn/fzf.vim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/tpope/vim-obsession",
    "https://github.com/echasnovski/mini.cursorword",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/APZelos/blamer.nvim",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/RyanMillerC/better-vim-tmux-resizer",
    "https://github.com/towolf/vim-helm",
    "https://github.com/mbbill/undotree",
    "https://github.com/hashivim/vim-terraform",
    "https://github.com/jvirtanen/vim-hcl",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/whiteinge/diffconflicts",
    "https://github.com/sindrets/diffview.nvim",
})

-- ============================================================================
-- Core config
-- ============================================================================
require('user.keymaps')
require('user.options')
require('user.autocmds')

-- ============================================================================
-- Colorscheme (must be before plugin configs that depend on highlights)
-- ============================================================================
vim.cmd('colorscheme onedark')
local comment_hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
comment_hl.italic = true
vim.api.nvim_set_hl(0, 'Comment', comment_hl)
local colorcolumn_hl = vim.api.nvim_get_hl(0, { name = 'ColorColumn' })
colorcolumn_hl.ctermbg = 233
vim.api.nvim_set_hl(0, 'ColorColumn', colorcolumn_hl)
vim.api.nvim_set_hl(0, 'MiniCursorword', { bg = '#3e4451' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#21252b' })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#5c6370', bg = '#21252b' })

-- ============================================================================
-- Plugin configs
-- ============================================================================
require('user.lsp')
require('user.cmp')
require('user.luasnip')
require('user.lualine')
require('user.gitsigns')
require('user.autopairs')
require('user.neotree')
require('user.trouble')
require('user.which-key')
require('user.dap')
require('mini.cursorword').setup()
require('user.blamer')
require('user.fzf')

-- Treesitter
require('nvim-treesitter.config').setup({})
vim.opt.rtp:append(vim.fn.stdpath('data') .. '/site/pack/core/opt/nvim-treesitter/runtime')
require('treesitter-context')
require('render-markdown').setup({})
vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})


