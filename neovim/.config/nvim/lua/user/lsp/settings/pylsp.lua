-- Plugins
-- https://github.com/williamboman/nvim-lsp-installer/blob/main/lua/nvim-lsp-installer/servers/pylsp/README.md

-- Configuration options
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md

return {
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
}
