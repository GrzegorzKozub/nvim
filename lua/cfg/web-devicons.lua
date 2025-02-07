local M = {}

function M.config()
  local web_devicons_loaded, web_devicons = pcall(require, 'nvim-web-devicons')
  if not web_devicons_loaded then
    return
  end

  web_devicons.setup { color_icons = false }

  local icon = require('cfg.icons').get().file.file
  local color = require('cfg.gruvbox-material').default_icon_color()
  web_devicons.set_default_icon(icon, color[1], color[2])
end

function M.icon(bufnr, filetype)
  local web_devicons = require 'nvim-web-devicons'
  local buftype = vim.fn.getbufvar(bufnr, '&buftype')
  if buftype == 'terminal' then
    return web_devicons.get_icon_by_filetype 'zsh'
  end
  local buff = vim.api.nvim_buf_get_name(bufnr)
  local name = vim.fn.fnamemodify(buff, ':t')
  local ext = vim.fn.fnamemodify(buff, ':e')
  local icon = web_devicons.get_icon(name, ext, { default = false })
  if icon == nil then
    icon = web_devicons.get_icon_by_filetype(filetype)
  end
  return icon
end

return M
