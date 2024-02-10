local M = {}

local linters = {
  json = { 'jsonlint' },
  lua = { 'luacheck' },
  python = { 'pylint' },
  yaml = { 'yamllint' },
}

if vim.fn.has 'win32' == 0 then
  for key, value in pairs {
    dockerfile = { 'hadolint' },
    go = { 'golangcilint' },
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
  } do
    linters[key] = value
  end
end

local function pylint(lint)
  local packages = vim.fn.has 'win32' == 0 and '~/.local/lib/python311/site-packages'
    or os.getenv('APPDATA'):gsub('\\', '/') .. '/Python/Python312/site-packages'
  lint.linters.pylint.args = {
    '--init-hook',
    'import sys; sys.path.append("' .. packages .. '")',
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
