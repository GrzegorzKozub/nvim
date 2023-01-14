local M = {}

function M.config()
  for _, sign in ipairs {
    { name = 'DiagnosticSignError', text = '●' },
    { name = 'DiagnosticSignWarn', text = '▲' },
    { name = 'DiagnosticSignHint', text = '◆' },
    { name = 'DiagnosticSignInfo', text = '◆' },
  } do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = '' })
  end

  vim.diagnostic.config {
    float = { header = '', prefix = '', border = 'rounded' },
    severity_sort = true,
    underline = false,
    virtual_text = {
      spacing = 0,
      prefix = '',
      format = function(diagnostic)
        local sign = diagnostic.severity == vim.diagnostic.severity.ERROR and '●'
          or diagnostic.severity == vim.diagnostic.severity.WARN and '▲'
          or '◆'
        return string.format('%s %s', sign, diagnostic.message)
      end,
    },
  }

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
end

return M
