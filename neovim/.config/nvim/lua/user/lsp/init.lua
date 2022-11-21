local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

require('user.lsp.lsp-installer')
require('user.lsp.handlers').setup()

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)
