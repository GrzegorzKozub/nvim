local M = {}

function M.config()
  local mason_lspconfig_loaded, mason_lspconfig = pcall(require, 'mason-lspconfig')
  if not mason_lspconfig_loaded then
    return
  end

  mason_lspconfig.setup { automatic_installation = true }
end

return M
