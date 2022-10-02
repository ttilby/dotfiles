-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Python

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

-- Requires that debugpy be installed to a dedicated virtualenv
--   pyenv virtualenv 3.7.8 debugpy
--   pyenv activate debugpy
--   $(pyenv which python) -m pip install debugpy
--   pyenv which python
dap.adapters.python = {
    type = 'executable';
    command = '/home/todd/.pyenv/versions/debugpy/bin/python';
    args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
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
        return '/usr/bin/python'
      end
    end;
  },
}
