-- Hybrid line numbers
local nu_blacklist = { "NvimTree", "nerdtree", "neo-tree", "Trouble" }
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = numbertoggle,
    callback = function()
        if not vim.tbl_contains(nu_blacklist, vim.bo.filetype) then
            vim.opt.relativenumber = true
        end
    end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = numbertoggle,
    callback = function()
        if not vim.tbl_contains(nu_blacklist, vim.bo.filetype) then
            vim.opt.relativenumber = false
        end
    end,
})

-- Save whenever switching windows or leaving vim
vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave", "BufLeave" }, {
    command = "silent! wa",
})

-- Remove trailing whitespace on save
local custom_group = vim.api.nvim_create_augroup("CUSTOM", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = custom_group,
    callback = function()
        local save = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(save)
    end,
})

-- Terraform filetype for .hcl files
local terraform_group = vim.api.nvim_create_augroup("custom_terraform", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = terraform_group,
    pattern = "*.hcl",
    command = "set filetype=terraform",
})
