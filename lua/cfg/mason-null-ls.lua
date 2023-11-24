local M = {}

function M.config()
  local mason_null_ls_loaded, mason_null_ls = pcall(require, 'mason-null-ls')
  if not mason_null_ls_loaded then
    return
  end

  local sources = { 'stylua' }
  if vim.fn.has 'win32' == 0 then
    for _, source in ipairs {
      -- 'cfn-lint',
      'hadolint',
      'jsonlint',
      'luacheck',
      'prettier',
      'pylint',
      -- 'vint',
      'yamllint',
      'black',
      -- 'taplo',
    } do
      table.insert(sources, source)
    end
  end

  mason_null_ls.setup {
    automatic_installation = { exclude = { 'xmllint' } },
    ensure_installed = sources,
  }
end

return M