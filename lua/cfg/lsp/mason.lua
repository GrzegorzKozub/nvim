local M = {}

function M.config()
  local loaded, plugin = pcall(require, 'mason')
  if not loaded then
    return
  end

  plugin.setup {
    ui = {
      border = 'rounded',
      icons = {
        package_installed = '✓',
        package_pending = '→',
        package_uninstalled = '✕',
      },
    },
  }
end

return M
