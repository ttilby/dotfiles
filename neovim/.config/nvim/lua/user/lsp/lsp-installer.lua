local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require('user.lsp.handlers').on_attach,
        capabilities = require('user.lsp.handlers').capabilities,
    }

    if server.name == "sumneko_lua" then
        local sumneko_opts = require('user.lsp.settings.sumneko_lua')
        opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
    end

    if server.name == "yamlls" then
        -- Check if "yaml" file is in a helm directory, and if so,
        -- disable the language server since helm yaml is not really yaml.
        local default_on_attach = opts.on_attach
        opts.on_attach = function(client, bufnr)
            default_on_attach(client, bufnr)
            if string.find(vim.api.nvim_buf_get_name(bufnr), "helm") then
                vim.diagnostic.disable()
            end
        end
        local yamlls_opts = require('user.lsp.settings.yamlls')
        opts = vim.tbl_deep_extend('force', yamlls_opts, opts)
    end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)