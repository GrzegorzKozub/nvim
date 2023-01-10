local M = {}

function M.capabilities()
  local loaded, plugin = pcall(require, 'cmp_nvim_lsp')
  if not loaded then
    return vim.lsp.protocol.make_client_capabilities()
  end
  return plugin.default_capabilities()
end

return M
