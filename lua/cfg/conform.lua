local M = {}

local formatters = {
  css = { 'prettier' },
  go = { 'goimports', 'gofmt' },
  html = { 'prettier' },
  javascript = { 'prettier' },
  json = { 'prettier' },
  jsonc = { 'prettier' },
  lua = { 'stylua' },
  python = { 'isort', 'black' },
  rust = { 'rustfmt' },
  sh = { 'shfmt' },
  toml = { 'taplo' },
  xml = { 'xmlformatter' },
  yaml = { 'prettier' },
  ['_'] = { 'trim_whitespace' },
}

function M.config()
  local conform_loaded, conform = pcall(require, 'conform')
  if not conform_loaded then
    return
  end

  conform.setup {
    default_format_opts = { lsp_format = 'fallback' },
    format_on_save = { timeout_ms = 1000 },
    formatters_by_ft = formatters,
  }

  require('cfg.util').nmap('<leader>f', function()
    conform.format { async = true }
  end)
end

return M
