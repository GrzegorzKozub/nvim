local M = {}

function M.config()
  local mason_null_ls_loaded, mason_null_ls = pcall(require, 'mason-null-ls')
  if not mason_null_ls_loaded then
    return
  end

  local sources = {
    'stylua',
    'isort',
    'black',
    'pylint',
  }
  if vim.fn.has 'win32' == 0 then
    for _, source in ipairs {
      -- 'cfn-lint',
      'hadolint',
      'jsonlint',
      'luacheck',
      'prettier',
      -- 'vint',
      'yamllint',
      -- 'taplo',
    } do
      table.insert(sources, source)
    end
  end

  local exclude = { 'xmllint' }
  if vim.fn.has 'win32' == 1 then
    table.insert(exclude, 'luacheck')
  end

  mason_null_ls.setup {
    automatic_installation = { exclude = exclude },
    ensure_installed = sources,
  }
end

return M