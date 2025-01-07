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

-- vim.cmd([[nnoremap <leader>G :FzfLua files<CR>]])
-- vim.cmd([[nnoremap <leader>g :FzfLua live_grep_glob<CR>]])
-- vim.cmd([[nnoremap <leader>b :FzfLua buffers<CR>]])

local map_fzf = function(mode, key, f, options, buffer)
    local desc = nil
    if type(options) == "table" then
        desc = options.desc
        options.desc = nil
    elseif type(options) == "function" then
        desc = options().desc
    end

    local rhs = function()
        fzf_lua[f](options and vim.deepcopy(options) or {})
    end

    local map_options = {
        silent = true,
        buffer = buffer,
        desc = desc or string.format("FzfLua %s", f),
    }

    vim.keymap.set(mode, key, rhs, map_options)
end

map_fzf("n", "<leader>b", "buffers", { desc = "Fzf buffers" })
map_fzf("n", "<F1>", "help_tags", { desc = "help tags" })
map_fzf("n", "<leader>ff", "files", { desc = "find files" })
map_fzf("n", "<leader>fg", "live_grep", { desc = "live grep (project)" })
map_fzf("n", "<leader>fG", "live_grep", { desc = "live grep resume", resume = true })
map_fzf("n", "<leader>fw", "grep_cword", { desc = "grep <word> (project)" })
map_fzf("n", "<leader>fW", "grep_cWORD", { desc = "grep <WORD> (project)" })

map_fzf("n", "<leader>fm", "marks", { desc = "marks" })
map_fzf("n", [[<leader>f"]], "registers", { desc = "registers" })

map_fzf("n", "<leader>f?", "builtin", { desc = "builtin commands" })
map_fzf("n", "<leader>fx", "commands", { desc = "commands" })
map_fzf("n", "<leader>fF", "resume", { desc = "resume" })
