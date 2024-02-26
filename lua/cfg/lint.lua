local M = {}

local linters = {
  dockerfile = { 'hadolint' },
  go = { 'golangcilint' },
  javascript = { 'eslint_d' },
  json = { 'jsonlint' },
  lua = { 'luacheck' },
  python = { 'pylint' },
  typescript = { 'eslint_d' },
  yaml = { 'yamllint' },
}

local function packages()
  if vim.fn.has 'win32' == 1 then
    return os.getenv('APPDATA'):gsub('\\', '/') .. '/Python/Python312/site-packages'
  end
  return os.getenv 'HOME' .. '/.local/lib/python3.11/site-packages'
  -- add /usr/lib/python3.11/site-packages and only do this when the ft=python
end

local function pylint(lint)
  lint.linters.pylint.args = {
    '--init-hook',
    'import sys; sys.path.append("' .. packages() .. '")',
    '--output-format',
    'json',
  }
end

function M.config()
  local lint_loaded, lint = pcall(require, 'lint')
  if not lint_loaded then
    return
  end

  lint.linters_by_ft = linters

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
    pattern = '*',
    callback = function()
      lint.try_lint()
    end,
    group = vim.api.nvim_create_augroup('Lint', { clear = true }),
  })

  pylint(lint)
end

return M
