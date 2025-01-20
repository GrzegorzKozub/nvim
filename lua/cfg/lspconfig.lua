local M = {}

local function cleanup(contents)
  -- in future use https://github.com/neovim/neovim/issues/25718
  local result = {}
  for _, chunk in pairs(contents) do
    if chunk:find '^---' then
      chunk = ''
    end
    vim.list_extend(result, { chunk })
  end
  return result
end

local function floats()
  -- https://github.com/neovim/nvim-lspconfig/wiki/ui-customization#borders
  -- in future use https://github.com/neovim/neovim/pull/31074

  -- https://neovim.io/doc/user/lsp.html#vim.lsp.util.open_floating_preview()
  -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/util.lua
  local lsp = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    opts.max_height = opts.max_height or 20
    opts.max_width = opts.max_width or 80
    return lsp(cleanup(contents), syntax, opts, ...)
  end

  -- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.open_float()
  local diag = vim.diagnostic.open_float
  function vim.diagnostic.open_float(opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    return diag(opts, ...)
  end
end

local function keys(bufnr)
  local nmap = require('cfg.util').nmap

  nmap('gd', vim.lsp.buf.definition, bufnr)
  nmap('gD', vim.lsp.buf.declaration, bufnr)
  nmap('gi', vim.lsp.buf.implementation, bufnr)
  -- nmap('gr', vim.lsp.buf.references, bufnr)
  nmap('gr', '<cmd>Trouble lsp<cr>')
  nmap('gt', vim.lsp.buf.type_definition, bufnr)

  if vim.lsp.inlay_hint then
    nmap('<leader>li', function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr },
        { bufnr = bufnr }
      )
    end, bufnr)
  end

  nmap('<leader>lh', vim.lsp.buf.hover, bufnr)
  nmap('<leader>ls', vim.lsp.buf.signature_help, bufnr)
  nmap('<leader>lr', vim.lsp.buf.rename, bufnr)
  nmap('<leader>la', vim.lsp.buf.code_action, bufnr)

  nmap('<leader>dh', vim.diagnostic.open_float, bufnr)
  nmap('<leader>dl', vim.diagnostic.setloclist, bufnr)
  nmap('<leader>dq', vim.diagnostic.setqflist, bufnr)

  -- defaults since https://neovim.io/doc/user/news-0.10.html
  -- nmap(']d', vim.diagnostic.goto_next, bufnr)
  -- nmap('[d', vim.diagnostic.goto_prev, bufnr)

  nmap('<leader>tl', '<cmd>Trouble lsp toggle<cr>')
  nmap('<leader>ts', '<cmd>Trouble symbols toggle<cr>')
  nmap('<leader>td', '<cmd>Trouble diagnostics toggle<cr>')

  -- nmap('<leader>f', function()
  --   vim.lsp.buf.format { async = true, bufnr = bufnr }
  -- end, bufnr)
end

local function highlight(client, bufnr)
  -- https://github.com/neovim/nvim-lspconfig/wiki/ui-customization#highlight-symbol-under-cursor

  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  vim.api.nvim_create_augroup('LspHighlight', { clear = false })
  vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'LspHighlight' }
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    group = 'LspHighlight',
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })

  -- fix ideas
  --https://neovim.io/doc/user/luvref.html#uv.timer_stop()
  --https://github.com/tamton-aquib/keys.nvim/blob/main/lua/keys.lua
  --https://neovim.io/doc/user/lua.html#vim.defer_fn()
  --https://github.com/RRethy/vim-illuminate/blob/5eeb7951fc630682c322e88a9bbdae5c224ff0aa/lua/illuminate.lua#L56
  -- https://neovim.io/doc/user/lua.html#vim.on_key()
  local timer = vim.loop.new_timer()
  vim.on_key(function()
    timer:start(1000, 0, vim.schedule_wrap(vim.lsp.buf.document_highlight))
  end)
end

local function on_attach(client, bufnr)
  keys(bufnr)
  highlight(client, bufnr)
  vim.bo[bufnr].formatexpr = "v:lua.require'conform'.formatexpr()"
end

function M.config()
  local lspconfig_loaded, lspconfig = pcall(require, 'lspconfig')
  if not lspconfig_loaded then
    return
  end

  floats()

  for _, server in pairs(require 'cfg.servers') do
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
end

return M