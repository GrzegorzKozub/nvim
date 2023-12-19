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
      yaml = { 'prettier' },
    }
  or {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
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
end

return M
