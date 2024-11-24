local M = {}

function M.config()
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '.env',
    callback = function(args)
      vim.diagnostic.enable(false, { bufnr = args.buf })
    end,
    group = vim.api.nvim_create_augroup('Env', { clear = true }),
  })
end

return M