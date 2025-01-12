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

-- local function site_packages()
--   if vim.fn.has 'win32' == 0 then
--     return {
--       '/usr/lib/python3.13/site-packages',
--       os.getenv 'HOME' .. '/.local/lib/python3.13/site-packages',
--     }
--   else
--     return {
--       os.getenv('APPDATA'):gsub('\\', '/') .. '/Python/Python312/site-packages',
--     }
--   end
-- end

-- local function pylint(lint)
--   lint.linters.pylint.args = {
--     '--init-hook',
--     'import sys; sys.path += ["' .. table.concat(site_packages(), '","') .. '"]',
--     '--output-format',
--     'json',
--   }
-- end

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

  -- pylint(lint)
end

return M