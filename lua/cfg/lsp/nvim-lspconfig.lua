local M = {}

local function map(keys, action, bufnr)
  vim.keymap.set('n', keys, action, { noremap = true, silent = true, buffer = bufnr })
end

local function keys(bufnr)
  map('gd', '<cmd>lua vim.lsp.buf.definition()<cr>', bufnr)
  map('<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', bufnr)
end

local function on_attach(_, bufnr)
  keys(bufnr)
end

function M.setup()
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
