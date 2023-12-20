local M = {}

local linters = vim.fn.has 'win32' == 0 and {
  dockerfile = { 'hadolint' },
  -- go = { 'golangcilint' },
  -- javascript = { 'eslint_d' },
  json = { 'jsonlint' },
  lua = { 'luacheck' },
  -- markdown = { 'markdownlint' },
  python = { 'pylint' },
  -- typescript = { 'eslint_d' },
  -- vim = { 'vint' },
  yaml = { 'yamllint' },
} or {
  json = { 'jsonlint' },
  lua = { 'luacheck' },
  python = { 'pylint' },
  yaml = { 'yamllint' },
}

function M.config()
  local lint_loaded, lint = pcall(require, 'lint')
  if not lint_loaded then
    return
  end

  lint.linters_by_ft = linters

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
    pattern = '*',
    callback = function() lint.try_lint() end,
    group = vim.api.nvim_create_augroup('Lint', { clear = true }),
  })
end

return M