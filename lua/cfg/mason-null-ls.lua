local M = {}

function M.config()
  local mason_null_ls_loaded, mason_null_ls = pcall(require, 'mason-null-ls')
  if not mason_null_ls_loaded then
    return
  end

  mason_null_ls.setup {
    automatic_installation = { exclude = { 'xmllint' } },
    ensure_installed = { -- todo: base on null-ls.lua
      'stylua',
      'hadolint',
      'jsonlint',
      'luacheck',
      'prettier',
      'pylint',
      'yamllint',
      'autopep8',
    },
  }
end

return M