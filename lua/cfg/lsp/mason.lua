local M = {}

function M.config()
  local mason_loaded, mason = pcall(require, 'mason')
  if not mason_loaded then
    return
  end

  mason.setup {
    ui = {
      border = 'rounded',
      icons = {
        package_installed = '✓',
        package_pending = '→',
        package_uninstalled = '✕',
      },
    },
  }

  local servers = {
    'bash-language-server',
    'lua-language-server',
  }

  vim.api.nvim_create_user_command('MasonUpdate', 'MasonInstall ' .. table.concat(servers, ' '), {})
end

return M
