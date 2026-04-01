-- Mason setup (package manager for LSP servers)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "dockerls",
        "pylsp",
        "jsonls",
        "marksman",
        "lua_ls",
        "terraformls",
        "yamlls",
        "helm_ls",
    },
})

-- Diagnostics config
vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})

-- Diagnostic keymaps (global)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { silent = true })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { silent = true })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { silent = true })

-- Capabilities (cmp integration)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- on_attach: keymaps + document highlight
local function on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format() end, opts)

    if client.server_capabilities.document_highlight then
        local hl_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
        vim.api.nvim_clear_autocmds({ group = hl_group, buffer = bufnr })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = hl_group, buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = hl_group, buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- Hover/signature with rounded borders (0.12 native)
vim.lsp.buf.hover = (function(original)
    return function(opts)
        opts = vim.tbl_deep_extend("force", { border = "rounded" }, opts or {})
        return original(opts)
    end
end)(vim.lsp.buf.hover)

vim.lsp.buf.signature_help = (function(original)
    return function(opts)
        opts = vim.tbl_deep_extend("force", { border = "rounded" }, opts or {})
        return original(opts)
    end
end)(vim.lsp.buf.signature_help)

-- Server configs using native vim.lsp.config
local servers = {
    bashls = {},
    dockerls = {},
    jsonls = {},
    marksman = {},
    helm_ls = {},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                },
            },
        },
    },
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = { enabled = true, maxLineLength = 88 },
                    pylsp_mypy = {
                        enabled = true, live_mode = false,
                        dmypy = false, strict = false, overrides = true,
                    },
                },
            },
        },
    },
    yamlls = {
        settings = {
            yaml = {
                schemas = {
                    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yaml",
                },
            },
        },
    },
    terraformls = {
        filetypes = { "terraform", "tf", "terraform-vars" },
    },
}

for name, config in pairs(servers) do
    config.on_attach = on_attach
    config.capabilities = capabilities
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end
