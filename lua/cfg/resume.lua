local M = {}

function M.config()
  vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
      vim.cmd [[
        if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
          exe "normal! g`\""
        endif
      ]]
    end,
    group = vim.api.nvim_create_augroup('Resume', { clear = true }),
  })
end

return M
