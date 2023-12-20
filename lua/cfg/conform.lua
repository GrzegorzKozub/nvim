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

  require('cfg.util').nmap('<leader>f', function()
    conform.format { async = true, lsp_fallback = true }
  end)

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      vim.bo[args.buf].formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    group = vim.api.nvim_create_augroup('Conform', { clear = true }),
  })
end

return M
