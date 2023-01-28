local M = {}

function M.config()
  local mason_loaded, mason = pcall(require, 'mason')
  if not mason_loaded then
    return
  end
  local mason_update_all_loaded, mason_update_all = pcall(require, 'mason-update-all')
  if not mason_update_all_loaded then
    return
  end

  mason.setup {
    ui = {
      border = 'rounded',
      icons = {
        package_installed = '✓',
        package_pending = '▶',
        package_uninstalled = '×',
      },
    },
  }

  mason_update_all.setup()
end

return M