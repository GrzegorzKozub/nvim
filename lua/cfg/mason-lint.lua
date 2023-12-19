local M = {}

local linters = vim.fn.has 'win32' == 0 and {
  'hadolint',
  -- 'eslint_d',
  -- 'golangcilint',
  'jsonlint',
  'luacheck',
  -- 'markdownlint',
  'pylint',
  -- 'vint',
  'yamllint',
} or {
  'luacheck',
  'pylint',
}

function M.config()
  local mason_lint_loaded, mason_lint = pcall(require, 'mason-nvim-lint')
  if not mason_lint_loaded then
    return
  end

  mason_lint.setup {
    automatic_installation = true,
    ensure_installed = linters,
  }
end

return M