local M = {}

local formatters = {
  css = { 'prettier' },
  go = { 'goimports', 'gofmt' },
  html = { 'prettier' },
  javascript = { 'organize_imports', 'prettier' },
  json = { 'prettier' },
  jsonc = { 'prettier' },
  lua = { 'stylua' },
  python = { 'ruff_format', 'ruff_organize_imports' },
  rust = { 'rustfmt' },
  toml = { 'taplo' },
  typescript = { 'organize_imports', 'prettier' },
  xml = { 'xmlformatter' },
  yaml = { 'prettier' },
  ['_'] = { 'trim_whitespace' },
}

if vim.fn.has 'win32' == 0 then
  formatters.sh = { 'shfmt' }
end

function M.config()
  local conform_loaded, conform = pcall(require, 'conform')
  if not conform_loaded then
    return
  end

  conform.setup {
    default_format_opts = { lsp_format = 'fallback' },
    format_on_save = { timeout_ms = 1000 },
    formatters = {
      organize_imports = {
        format = function(_self, _ctx, lines, callback)
          vim.lsp.buf.code_action {
            apply = true,
            context = { only = { 'source.organizeImports' } },
          }
          callback(nil, lines)
        end,
      },
    },
    formatters_by_ft = formatters,
  }

  -- handled by .prettierrc
  -- require('conform').formatters.prettier = {
  --   prepend_args = function()
  --     return vim.o.filetype == 'jsonc' and { '--trailing-comma', 'none' } or {}
  --   end,
  -- }

  require('cfg.util').nmap('<leader>f', function()
    conform.format { async = true }
  end)
end

return M
