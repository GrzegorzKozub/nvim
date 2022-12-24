local M = {}

function M.init()
  vim.cmd.source(vim.fn.stdpath("config") .. "/lua/cfg/fzf.vim")
end

return M
