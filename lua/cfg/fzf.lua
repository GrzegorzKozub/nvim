local M = {}

function M.setup()
  vim.cmd.source(vim.fn.stdpath 'config' .. '/lua/cfg/fzf.vim')
end

return M
