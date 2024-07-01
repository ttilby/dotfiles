local options = {
    clipboard = "unnamedplus",            -- allows neovim to use system clipboard
    hlsearch = true,                      -- highlight searches
    hidden = true,                        -- keeps modified buffers in the background
    incsearch = true,                     -- highlight dynamically
    ignorecase = true,                    -- case insensitive search (unless specified)
    showmode = false,                     -- hide mode
    shiftwidth = 4,
    shiftround = true,                    -- rounds indentation to multiples of shiftwidth (applies to < and >)
    smartcase = true,                     -- override ignorecase if search string has capitals
    softtabstop = 4,                      --
    tabstop = 4,                          -- insert x spaces for tabs
    expandtab = true,                     -- uses the approprate number of spaces to insert a <Tab>
    swapfile = false,
    backup = false,
    mouse = "a",
    mousemodel = "popup",
    wildmenu = true,
    wildmode = "list:longest,full",
    termguicolors = true,
    signcolumn = "yes",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

local python_indent = {
  disable_parentheses_indenting = false,
  closed_paren_align_last_line = false,    -- default: true
  searchpair_timeout = 150,
  continue = 'shiftwidth() * 2',
  open_paren = 'shiftwidth()',             -- default: 'shiftwidth() * 2'
  nested_paren = 'shiftwidth()'
}
vim.g.python_indent = python_indent
