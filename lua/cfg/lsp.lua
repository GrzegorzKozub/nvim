local M = {}

local function floats()
  -- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.hover%28%29
  -- https://neovim.io/doc/user/lsp.html#vim.lsp.util.open_floating_preview%28%29
  -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/util.lua
  local lsp = vim.lsp.util.open_floating_preview
  ---@diagnostic disable-next-line: duplicate-set-field
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.max_height = opts.max_height or 20
    opts.max_width = opts.max_width or 80
    local bufnr, winnr = lsp(contents, syntax, opts, ...)
    local current = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(winnr)
    vim.api.nvim_command [[ syntax match markdownLspHorizontalLine '─' conceal ]]
    vim.api.nvim_set_current_win(current)
    return bufnr, winnr
  end
end

local function keys(bufnr)
  local nmap = require('cfg.util').nmap

  -- grn - rename symbol

  -- c-s - show signature help in insert mode
  -- K - show hover

  nmap('H', vim.diagnostic.open_float, bufnr)

  -- [d ]d - navigate through diagnostics

  if vim.lsp.inlay_hint then
    nmap('gi', function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr },
        { bufnr = bufnr }
      )
    end, bufnr)
  end

  require('cfg.fzf-lua').lsp()
end

local highlight_timers = {}
local highlight_on_key = false

local function highlight_timer_start(bufnr)
  return vim.defer_fn(function()
    if bufnr ~= vim.api.nvim_get_current_buf() then
      return
    end
    vim.lsp.buf.document_highlight()
  end, 1000)
end

local function highlight_on_key_start()
  if highlight_on_key then
    return
  end
  vim.on_key(function()
    local bufnr = vim.api.nvim_get_current_buf()
    if highlight_timers[bufnr] then
      vim.loop.timer_stop(highlight_timers[bufnr])
      highlight_timers[bufnr] = highlight_timer_start(bufnr)
    end
  end)
  highlight_on_key = true
end

local function highlight(client, bufnr)
  -- https://github.com/neovim/nvim-lspconfig/wiki/ui-customization#highlight-symbol-under-cursor

  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  vim.api.nvim_create_augroup('LspHighlight', { clear = false })
  vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'LspHighlight' }

  -- CursorHold waits until updatetime passes
  -- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  --   group = 'LspHighlight',
  --   buffer = bufnr,
  --   callback = vim.lsp.buf.document_highlight,
  -- })

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
    group = 'LspHighlight',
  })

  highlight_timers[bufnr] = highlight_timer_start(bufnr)
  highlight_on_key_start()
end

function M.config()
  floats()

  vim.lsp.enable(require 'cfg.servers')

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end

      vim.bo[args.buf].formatexpr = "v:lua.require'conform'.formatexpr()"

      if client:supports_method 'textDocument/foldingRange' then
        local win = vim.api.nvim_get_current_win()
        vim.opt.foldmethod = 'expr'
        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        vim.wo[win][0].foldtext = 'v:lua.vim.lsp.foldtext()'
      end

      keys(args.buf)
      highlight(client, args.buf)
    end,
    group = vim.api.nvim_create_augroup('Lsp', { clear = true }),
  })
end

return M
