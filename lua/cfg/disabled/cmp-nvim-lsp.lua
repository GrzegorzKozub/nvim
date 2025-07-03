local M = {}

function M.capabilities()
  local cmp_nvim_lsp_loaded, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  local capabilities = cmp_nvim_lsp_loaded and cmp_nvim_lsp.default_capabilities()
    or vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

return M
