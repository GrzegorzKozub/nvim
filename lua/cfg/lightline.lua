local M = {}

function M.init()
  vim.cmd.source(vim.fn.stdpath("config") .. "/lua/cfg/lightline.vim")
end

return M
