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
  terraform = { 'terraform_fmt' },
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
    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 1000 }
    end,
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

  vim.api.nvim_create_user_command('FormatToggle', function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    vim.notify('format on save ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
  end, {})

  local nmap = require('cfg.util').nmap
  nmap('<leader>f', function()
    conform.format { async = true }
  end)
  nmap('<leader>F', ':FormatToggle<cr>')
end

return M
