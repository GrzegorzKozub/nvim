local M = {}

local formatters = vim.fn.has 'win32' == 0
    and {
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      toml = { 'taplo' },
      xml = { 'xmlformat' },
      yaml = { 'prettier' },
    }
  or {
    css = { 'prettier' },
    html = { 'prettier' },
    json = { 'prettier' },
    jsonc = { 'prettier' },
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    toml = { 'taplo' },
    xml = { 'xmlformat' },
    yaml = { 'prettier' },
  }

function M.config()
  local conform_loaded, conform = pcall(require, 'conform')
  if not conform_loaded then
    return
  end

  conform.setup {
    formatters_by_ft = formatters,
    formatters = { prettier = { prepend_args = { '--single-quote' } } },
  }

  local group = vim.api.nvim_create_augroup('Conform', { clear = true })
  local nmap = require('cfg.util').nmap

  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    callback = function()
      nmap('<leader>f', function()
        conform.format { async = true, bufnr = 0, lsp_fallback = true }
      end, 0)
    end,
    group = group,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      nmap('<leader>f', function()
        conform.format { async = true, bufnr = args.buf, lsp_fallback = true }
      end, args.buf)
      vim.bo[args.buf].formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    group = group,
  })
end

return M