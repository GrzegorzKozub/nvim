local M = {}

function M.config()
  local mini_icons_loaded, mini_icons = pcall(require, 'mini.icons')
  if not mini_icons_loaded then
    return
  end

  local icon = require('cfg.icons').get().file.file
  mini_icons.setup {
    default = {
      file = { glyph = icon, hl = 'MiniIconsFile' },
    },
  }
end

return M
