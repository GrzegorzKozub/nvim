local M = {}

function M.config()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
      vim.opt_local.conceallevel = 1
      vim.g.markdown_recommended_style = 0
      require('cfg.todo').config()
      require('cfg.gruvbox-material').markdown()
    end,
    group = vim.api.nvim_create_augroup('Markdown', { clear = true }),
  })
end

return M
