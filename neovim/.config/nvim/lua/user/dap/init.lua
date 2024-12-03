-- https://github.com/mfussenegger/nvim-dap
local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    -- print("failed to import dap")
    return
end

-- https://github.com/jay-babu/mason-nvim-dap.nvim
-- local mason_nvim_dap_status_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
-- if not mason_nvim_dap_status_ok then
--     print("failed to import mason-nvim-dap")
--     return
-- end

-- https://github.com/mfussenegger/nvim-dap-python
local dap_python_status_ok, dap_python = pcall(require, "dap-python")
if not dap_python_status_ok then
    print("failed to import dap-python")
    return
end

-- mason_nvim_dap.setup({
--     ensure_installed = { "python" },
--     automatic_setup = true,
-- })
-- mason_nvim_dap.setup_handlers()


-- Requires that debugpy be installed to a dedicated virtualenv
--   mkdir ~/.virtualenvs
--   cd ~/.virtualenvs
--   python3 -m venv debugpy
--   debugpy/bin/python -m pip install debugpy
dap_python.setup('~/.virtualenvs/debugpy/bin/python')
-- dap.adapters.python = {
--     type = 'executable';
--     command = '/home/todd/.virtualenvs/debugpy/bin/python';
--     args = { '-m', 'debugpy.adapter' };
-- }

-- A base python configuration is provided by dap-python
-- but I needed to add a new configuration to look for `packages_venv`
table.insert(dap.configurations.python, {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      elseif vim.fn.executable(cwd .. '/packages_venv/bin/python') == 1 then
        return cwd .. '/packages_venv/bin/python'
      else
        return '/usr/bin/python3'
      end
    end;
  },
})

table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Django',
    program = vim.fn.getcwd() .. '/manage.py',
    args = {'runserver', '--noreload'}
})

-- https://github.com/rcarriga/nvim-dap-ui
local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    print("failed to import dap-ui")
    return
end

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- Want to close the UI manually so I can see results
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- https://github.com/rcarriga/nvim-dap-ui
local dap_virtual_text_status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not dap_virtual_text_status_ok then
    print("failed to import nvim-dap-virtual-text")
    return
end


-- nvim-dap
vim.cmd([[nnoremap <leader>db :DapToggleBreakpoint<CR>]])
vim.cmd([[nnoremap <leader>dc :lua require('dap').continue()<CR>]])
vim.cmd([[nnoremap <leader>dn :lua require('dap').step_over()<CR>]])
vim.cmd([[nnoremap <leader>ds :lua require('dap').step_into()<CR>]])
vim.cmd([[nnoremap <leader>dr :lua require('dap').step_out()<CR>]])

-- dap-python
vim.cmd([[nnoremap <leader>dt :lua require('dap-python').test_method()<CR>]])
vim.cmd([[nnoremap <leader>dT :lua require('dap-python').test_class()<CR>]])

-- dapui
vim.cmd([[vnoremap <leader>de :lua require('dapui').eval()<CR>]])
vim.cmd([[nnoremap <leader>dd :lua require('dapui').toggle()<CR>]])

