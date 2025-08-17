-- https://github.com/williamboman/mason.nvim

local status_ok, mason = pcall(require, "mason")
if not status_ok then
    print("failed to import mason")
    return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    print("failed to import lspconfig")
    return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    print("failed to import mason-lspconfig")
    return
end

vim.lsp.config('lua_ls', {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- Configuration options
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
vim.lsp.config('pylsp', {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 88,
                    -- ignore = {}
                },
                -- https://github.com/python-lsp/pylsp-mypy#configuration
                -- :PylspInstall pyls-mypy
                pylsp_mypy = {
                    enabled = true,
                    live_mode = false,
                    dmypy = false,
                    strict = false,
                    overrides = true
                }
            }
        }
    }
})

vim.lsp.config('yamlls', {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
    settings = {
        yaml = {
            schemas = {
                -- "": ["*/helm/**/*.yaml"],
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yaml",
            }
        }
    }
})

vim.lsp.config('terraformls', {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
    settings = {
        filetypes = {"*.tf", "*.tfvars"}
    }
})

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "bashls",     -- bash
        "dockerls",
        -- "jedi_language_server", -- python
        "pylsp",
        "jsonls",
        "marksman", -- markdown
        "lua_ls",
        "terraformls",
        "yamlls",
        "helm_ls"
    }
})

require('user.lsp.handlers').setup()


-- local lsp_defaults = lspconfig.util.default_config
--
-- lsp_defaults.capabilities = vim.tbl_deep_extend(
--     'force',
--     lsp_defaults.capabilities,
--     require('cmp_nvim_lsp').default_capabilities()
-- )
--
-- local opts = {
--     on_attach = require('user.lsp.handlers').on_attach,
--     capabilities = require('user.lsp.handlers').capabilities,
-- }
--
-- mason_lspconfig.setup_handlers({
--     -- default handler, called for each installed server that doesn't have a
--     -- dedicated handler.
--     function (server_name)
--         -- print("setting up " .. server_name .. " using default opts")
--         lspconfig[server_name].setup(opts)
--     end,
--     -- targeted overrides for specific servers
--     ["pylsp"] = function()
--         local pylsp_opts = require('user.lsp.settings.pylsp')
--         opts = vim.tbl_deep_extend('force', pylsp_opts, opts)
--         lspconfig.pylsp.setup(opts)
--     end,
--     ["lua_ls"] = function()
--         local lua_opts = require('user.lsp.settings.lua_ls')
--         opts = vim.tbl_deep_extend('force', lua_opts, opts)
--         lspconfig.lua_ls.setup(opts)
--     end,
--     ['yamlls'] = function()
--         -- Check if "yaml" file is in a helm directory, and if so,
--         -- disable the language server since helm yaml is not really yaml.
--         local default_on_attach = opts.on_attach
--         opts.on_attach = function(client, bufnr)
--             default_on_attach(client, bufnr)
--             if string.find(vim.api.nvim_buf_get_name(bufnr), "helm") then
--                 vim.diagnostic.enable(false)
--             end
--             -- if string.find(vim.api.nvim_buf_get_name(bufnr), "service-framework") then
--             --     vim.diagnostic.disable()
--             -- end
--         end
--         local yamlls_opts = require('user.lsp.settings.yamlls')
--         opts = vim.tbl_deep_extend('force', yamlls_opts, opts)
--         lspconfig.yamlls.setup(opts)
--     end,
-- })

