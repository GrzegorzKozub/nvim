local M = {}

local group = vim.api.nvim_create_augroup('FileTypes', { clear = true })

local function set_filetype(pattern, filetype)
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = pattern,
    callback = function()
      vim.opt.filetype = filetype
    end,
    group = group,
  })
end

function M.config()
  set_filetype('config', 'confini')
  set_filetype('*.json', 'jsonc')
end

return M
