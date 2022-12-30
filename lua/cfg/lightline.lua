local M = {}

function M.setup()
  vim.g.lightline_color_scheme = require('cfg.theme').get().lightline
  vim.cmd.source(vim.fn.stdpath 'config' .. '/lua/cfg/lightline.vim')
end

return M
