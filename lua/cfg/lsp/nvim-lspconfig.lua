local M = {}

local function map(keys, action, bufnr)
  vim.keymap.set('n', keys, action, { noremap = true, silent = true, buffer = bufnr })
end

local function keys(bufnr)
  map('gd', vim.lsp.buf.definition, bufnr)
  map('gD', vim.lsp.buf.declaration, bufnr)
  map('gi', vim.lsp.buf.implementation, bufnr)
  map('gr', vim.lsp.buf.references, bufnr)
  map('K', vim.lsp.buf.hover, bufnr)

  -- continue:
  map('gl', vim.diagnostic.open_float, bufnr)
  map('<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', bufnr)
  map('<leader>li', '<cmd>LspInfo<cr>', bufnr)
  map('<leader>lI', '<cmd>Mason<cr>', bufnr)
  map('<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', bufnr)
  map('<leader>lj', '<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>', bufnr)
  map('<leader>lk', '<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>', bufnr)
  map('<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', bufnr)
  map('<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', bufnr)
  map('<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<cr>', bufnr)
end

local function on_attach(_, bufnr)
  keys(bufnr)
end

function M.config()
  local loaded, plugin = pcall(require, 'lspconfig')
  if not loaded then
    return
  end

  for _, server in pairs(require('cfg.lsp.servers').get()) do
    local options = {
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
    }
    local server_options_exist, server_options = pcall(require, 'cfg.lsp.' .. server)
    if server_options_exist then
      options = vim.tbl_deep_extend('force', server_options, options)
    end
    plugin[server].setup(options)
  end

  require('lspconfig.ui.windows').default_options.border = 'rounded'
end

return M
