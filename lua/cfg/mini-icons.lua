local M = {}

function M.config()
  local mini_icons_loaded, mini_icons = pcall(require, 'mini.icons')
  if not mini_icons_loaded then
    return
  end

  mini_icons.setup()
end

return M
