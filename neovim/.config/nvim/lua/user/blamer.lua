-- https://github.com/APZelos/blamer.nvim

vim.g.blamer_enabled = true
vim.g.blamer_date_format = '%Y/%m/%d'

-- Configure blamer to resolve symlinks
vim.g.blamer_relative_time = 1
-- This tells blamer to resolve the actual file path
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local file = vim.fn.expand("%:p")
    if vim.fn.getftype(file) == "link" then
      local real_path = vim.fn.resolve(file)
      vim.cmd("edit " .. real_path)
    end
  end
})
