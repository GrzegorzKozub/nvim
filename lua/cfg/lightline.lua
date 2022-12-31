local M = {}

function M.setup()
  vim.g.lightline_color_scheme = 'gruvbox_custom'
  vim.cmd.source(vim.fn.stdpath 'config' .. '/lua/cfg/lightline.vim')
end

return M
