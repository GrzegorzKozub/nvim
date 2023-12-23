local M = {}

function M.config()
  local cmp_zsh_loaded, cmp_zsh = pcall(require, 'cmp_zsh')
  if not cmp_zsh_loaded then
    return
  end

  cmp_zsh.setup { filetypes = { 'sh', 'zsh' } }
end

return M
