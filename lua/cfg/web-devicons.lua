local M = {}

function M.config()
  local web_devicons_loaded, web_devicons = pcall(require, 'nvim-web-devicons')
  if not web_devicons_loaded then
    return
  end

  web_devicons.setup { color_icons = false }

  local color = require('cfg.gruvbox-material').default_icon_color()
  web_devicons.set_default_icon('', color[1], color[2])
end

return M
