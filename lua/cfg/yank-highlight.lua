local M = {}

function M.config()
  vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
      local cl = vim.o.cursorline
      vim.o.cursorline = false
      vim.hl.hl_op { higroup = 'IncSearch' }
      vim.defer_fn(function()
        vim.o.cursorline = cl
      end, 150)
    end,
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  })
end

return M
