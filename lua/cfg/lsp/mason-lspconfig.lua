local M = {}

function M.setup()
  local loaded, plugin = pcall(require, 'mason-lspconfig')
  if not loaded then
    return
  end

  plugin.setup {
    ensure_installed = require('cfg.lsp.servers').get(),
    automatic_installation = true,
  }
end

return M
