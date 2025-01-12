local M = {}

function M.config()
  local colorizer_loaded, colorizer = pcall(require, 'colorizer')
  if not colorizer_loaded then
    return
  end

  colorizer.setup {
    lazy_load = true,
    user_default_options = { mode = 'virtualtext', names = false },
  }
end

return M
