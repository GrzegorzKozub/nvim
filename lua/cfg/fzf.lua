local M = {}

function M.config()
  vim.cmd.source(vim.fn.stdpath 'config' .. '/lua/cfg/fzf.vim')
end

return M
