local M = {}

function M.config()
  if vim.fn.has 'win32' == 0 or not os.getenv 'WT_SESSION' then
    return
  end
  vim.api.nvim_create_autocmd('VimLeave', {
    pattern = '*',
    callback = function()
      -- https://github.com/neovim/neovim/issues/4396
      vim.opt.guicursor = ''
      vim.fn.chansend(vim.v.stderr, '\x1b[ q')
    end,
    group = vim.api.nvim_create_augroup('WindowsTerminal', { clear = true }),
  })
end

return M
