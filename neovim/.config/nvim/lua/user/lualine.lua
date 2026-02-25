local function smart_filename()
    local width = vim.fn.winwidth(0)
    local file

    if width < 50 then
        file = vim.fn.expand('%:t')                   -- just filename
    elseif width > 90 then
        file = vim.fn.expand('%')                     -- full path
    else
        file = vim.fn.pathshorten(vim.fn.expand('%')) -- shortened path
    end

    if vim.fn.empty(file) == 1 then return '' end

    -- Add readonly indicator
    if vim.bo.filetype ~= 'help' and vim.bo.readonly then
        file = file .. ' '
    end

    -- Add modified indicator
    if vim.bo.modifiable and vim.bo.modified then
        file = file .. ' '
    end

    return file
end

local function obsession_status()
    if vim.fn.exists('*ObsessionStatus') == 1 then
        local status = vim.fn.ObsessionStatus('📁', '⏸')
        return status ~= '' and status or '○' -- show circle when no session
    else
        return ''
    end
end

require('lualine').setup {
    options = {
        theme = 'onedark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'neo-tree' },
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { smart_filename },
        lualine_x = { obsession_status, 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}
