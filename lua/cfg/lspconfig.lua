local M = {}

local function on_attach(_, bufnr)
  local nmap = require('cfg.util').nmap

  nmap('gd', vim.lsp.buf.definition, bufnr)
  nmap('gD', vim.lsp.buf.declaration, bufnr)
  nmap('gi', vim.lsp.buf.implementation, bufnr)
  -- nmap('gr', vim.lsp.buf.references, bufnr)
  nmap('gr', '<cmd>Trouble lsp_references<cr>')
  nmap('gt', vim.lsp.buf.type_definition, bufnr)

  if vim.lsp.inlay_hint then
    nmap('<leader>li', function()
      vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
    end, bufnr)
  end

  nmap('<leader>lh', vim.lsp.buf.hover, bufnr)
  nmap('<leader>ls', vim.lsp.buf.signature_help, bufnr)
  nmap('<leader>lr', vim.lsp.buf.rename, bufnr)
  nmap('<leader>la', vim.lsp.buf.code_action, bufnr)

  nmap('<leader>dh', vim.diagnostic.open_float, bufnr)
  nmap('<leader>dl', vim.diagnostic.setloclist, bufnr)
  nmap('<leader>dq', vim.diagnostic.setqflist, bufnr)
  nmap('<leader>dt', '<cmd>Trouble workspace_diagnostics<cr>')

  nmap(']d', vim.diagnostic.goto_next, bufnr)
  nmap('[d', vim.diagnostic.goto_prev, bufnr)

  nmap('<leader>f', function()
    vim.lsp.buf.format { async = true, bufnr = bufnr }
  end, bufnr)
end

function M.config()
  local lspconfig_loaded, lspconfig = pcall(require, 'lspconfig')
  if not lspconfig_loaded then
    return
  end

  for _, server in pairs(require('cfg.servers').get()) do
    local options = {
      capabilities = require('cfg.cmp-nvim-lsp').capabilities(),
      on_attach = on_attach,
    }
    local server_options_loaded, server_options = pcall(require, 'cfg.' .. server)
    if server_options_loaded then
      options = vim.tbl_deep_extend('force', server_options, options)
    end
    lspconfig[server].setup(options)
  end

  require('lspconfig.ui.windows').default_options.border = 'rounded'
end

return M