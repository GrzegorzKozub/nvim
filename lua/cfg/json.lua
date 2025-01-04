local M = {}

function M.config()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'json*',
    callback = function()
      -- vim.opt_local.conceallevel = 1
      require('cfg.gruvbox-material').json()
    end,
    group = vim.api.nvim_create_augroup('Json', { clear = true }),
  })
end

return M
