local M = {}

function M.config()
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = 'config',
    callback = function()
      vim.opt.filetype = 'confini'
    end,
    group = vim.api.nvim_create_augroup('FileTypes', { clear = true }),
  })
end

return M
