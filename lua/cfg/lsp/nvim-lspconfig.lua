local M = {}

local function map(keys, action, bufnr)
  vim.keymap.set('n', keys, action, { noremap = true, silent = true, buffer = bufnr })
end

local lsp_formatting = function(bufnr) end

local function keys(bufnr)
  map('gd', vim.lsp.buf.definition, bufnr)
  map('gD', vim.lsp.buf.declaration, bufnr)
  map('gi', vim.lsp.buf.implementation, bufnr)
  map('gr', vim.lsp.buf.references, bufnr)

  map('<leader>lh', vim.lsp.buf.hover, bufnr)
  map('<leader>ls', vim.lsp.buf.signature_help, bufnr)
  map('<leader>lr', vim.lsp.buf.rename, bufnr)
  map('<leader>la', vim.lsp.buf.code_action, bufnr)

  map('<leader>dh', vim.diagnostic.open_float, bufnr)
  map('<leader>dl', vim.diagnostic.setloclist, bufnr)
  map('<leader>dq', vim.diagnostic.setqflist, bufnr)

  map(']d', vim.diagnostic.goto_next, bufnr)
  map('[d', vim.diagnostic.goto_prev, bufnr)

  map('<leader>f', function()
    vim.lsp.buf.format {
      async = true,
      bufnr = bufnr,
      filter = function(client)
        return client.name == 'null-ls'
      end,
    }
  end, bufnr)
end

local function on_attach(_, bufnr)
  keys(bufnr)
end

function M.config()
  local lspconfig_loaded, lspconfig = pcall(require, 'lspconfig')
  if not lspconfig_loaded then
    return
  end

  for _, server in pairs(require('cfg.lsp.servers').get()) do
    local options = {
      capabilities = require('cfg.lsp.cmp-nvim-lsp').capabilities(),
      on_attach = on_attach,
    }
    local server_options_loaded, server_options = pcall(require, 'cfg.lsp.' .. server)
    if server_options_loaded then
      options = vim.tbl_deep_extend('force', server_options, options)
    end
    lspconfig[server].setup(options)
  end

  require('lspconfig.ui.windows').default_options.border = 'rounded'
end

return M
