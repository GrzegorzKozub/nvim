local M = {}

function M.setup()
  vim.cmd.source(vim.fn.stdpath 'config' .. '/lua/cfg/lightline.vim')
end

return M
