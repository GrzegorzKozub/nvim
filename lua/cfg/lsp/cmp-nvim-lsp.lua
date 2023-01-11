local M = {}

function M.capabilities()
  local cmp_nvim_lsp_loaded, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if not cmp_nvim_lsp_loaded then
    return vim.lsp.protocol.make_client_capabilities()
  end
  return cmp_nvim_lsp.default_capabilities()
end

return M
