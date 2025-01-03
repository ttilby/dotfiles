local fzf_lua_ok, fzf_lua = pcall(require, "fzf-lua")
if not fzf_lua_ok then
    return
end

fzf_lua.setup {
    winopts = {
        preview = {
            layout = "vertical"
        }
    }
}

vim.cmd([[nnoremap <leader>G :FzfLua files<CR>]])
vim.cmd([[nnoremap <leader>g :FzfLua live_grep_glob<CR>]])
vim.cmd([[nnoremap <leader>b :FzfLua buffers<CR>]])
