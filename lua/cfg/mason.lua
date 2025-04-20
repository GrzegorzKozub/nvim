local M = {}

function M.config()
  local mason_loaded, mason = pcall(require, 'mason')
  if not mason_loaded then
    return
  end

  local icons = require('cfg.icons').get()

  mason.setup {
    ui = {
      border = 'rounded',
      width = 0.8,
      height = 0.8,
      icons = {
        package_installed = icons.package.enabled,
        package_pending = icons.package.pending,
        package_uninstalled = icons.package.disabled,
      },
    },
  }
end

return M

