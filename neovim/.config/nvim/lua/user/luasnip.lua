local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
    print("failed to load luasnip")
    return
end

-- local types = require("luasnip.util.types")

luasnip.config.set_config {
    -- This tells luasnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside the selection
    history = true,

    -- This will update dynamic snippets as you type
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    -- enable_autosnippets = true,
}
----------------------------------- Snippet Helpers ---------------------------

-- create snippet
-- snippet(context, nodes, condition, ...)
local snippet = luasnip.s

-- Text Node
-- t {"This will be inserted"}
-- t {"Can use", "multiple lines"}
local t = luasnip.text_node

-- Insert Node
--  Creates a location for the cursor to jump to.
--      Possible options to jump to are 1 - N
--      If you use 0, that's the final place to jump to.
--
--  To create placeholder text, pass it as the second argument
--      i(2, "this is placeholder text")
local i = luasnip.insert_node

-- Function Node
--  Takes a function that returns text
local f = luasnip.function_node

-- Format Node
--  Takes a format string and a list of nodes
--  fmt(<fmt string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- Repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep

----------------------------------- Snippets ----------------------------------
luasnip.add_snippets("all", {
    snippet("simple", t "expanded text!"),
    snippet("req", fmt([[
    local {lib1}_status_ok, {} = pcall(require, "{}")
    if not {}_status_ok then
        print("failed to load {}")
        return
    end
    ]], {
        lib1 = i(1, "<lib>"),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
    }))
})

----------------------------------- Keymaps -----------------------------------
-- Expand snippet
vim.keymap.set({"i", "s"}, "<c-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

-- Jump backwards
-- Moves to previous item within the snippet
vim.keymap.set({"i", "s"}, "<c-j>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

-- shortcut to source luasnips file
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/user/luasnip.lua<CR>")

print("luasnip loaded")
