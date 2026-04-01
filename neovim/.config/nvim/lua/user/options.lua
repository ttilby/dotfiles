-- Options from both the old init.vim and the original options.lua
local options = {
    clipboard = "unnamedplus",
    hlsearch = true,
    hidden = true,
    incsearch = true,
    ignorecase = true,
    showmode = false,
    shiftwidth = 4,
    shiftround = true,
    smartcase = true,
    softtabstop = 4,
    tabstop = 4,
    expandtab = true,
    swapfile = false,
    backup = false,
    mouse = "a",
    mousemodel = "popup",
    wildmenu = true,
    wildmode = "list:longest,full",
    termguicolors = true,
    signcolumn = "yes",
    -- from init.vim
    number = true,
    relativenumber = true,
    foldlevelstart = 20,
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    textwidth = 79,
    wrap = false,
    colorcolumn = "88",
    scrolloff = 8,
    undodir = vim.fn.expand("~/vim/undodir"),
    undofile = true,
    background = "dark",
    guifont = "Hack Regular Nerd Font Complete 13",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.formatoptions:remove("t")

-- Python indent settings
vim.g.python_indent = {
    disable_parentheses_indenting = false,
    closed_paren_align_last_line = false,
    searchpair_timeout = 150,
    continue = "shiftwidth() * 2",
    open_paren = "shiftwidth()",
    nested_paren = "shiftwidth()",
}

-- vim-terraform
vim.g.hcl_align = 1
vim.g.terraform_align = 1
vim.g.terraform_fmt_on_save = 1
