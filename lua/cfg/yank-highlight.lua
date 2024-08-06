local M = {}

function M.config()
  vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
      vim.highlight.on_yank()
    end,
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  })
end

return M
