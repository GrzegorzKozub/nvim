local M = {}

local function floats()
  -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
  -- in future use https://github.com/neovim/neovim/pull/31074

  -- https://neovim.io/doc/user/lsp.html#vim.lsp.util.open_floating_preview()
  local lsp = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    return lsp(contents, syntax, opts, ...)
  end

  -- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.open_float()
  local diag = vim.diagnostic.open_float
  function vim.diagnostic.open_float(opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    return diag(opts, ...)
  end
end

local function on_attach(_, bufnr)
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

  vim.bo[bufnr].formatexpr = "v:lua.require'conform'.formatexpr()"





-- vim.o.updatetime = 1000
--https://neovim.io/doc/user/lua.html#lua-loop
local TIMEOUT = 500
local n = 0
local timer = vim.loop.new_timer()
vim.on_key(function()
  timer:start(TIMEOUT, 0, vim.schedule_wrap(function()
    n = n + 1
     vim.lsp.buf.document_highlight()
    print(n)
  end))
end)


-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
if _.server_capabilities.documentHighlightProvider then
  vim.cmd [[
    hi! LspReferenceRead cterm=bold ctermbg=red guibg=Red
    hi! LspReferenceText cterm=bold ctermbg=red guibg=Red
    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=Red
  ]]
  vim.api.nvim_create_augroup('lsp_document_highlight', {
    clear = false
  })
  vim.api.nvim_clear_autocmds({
    buffer = bufnr,
    group = 'lsp_document_highlight',
  })
  -- vim.api.nvim_create_autocmd({ 'XXX' }, {
  --   group = 'lsp_document_highlight',
  --   buffer = bufnr,
  --   callback = vim.lsp.buf.document_highlight,
  -- })
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    group = 'lsp_document_highlight',
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end


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