local M = {}

function M.config()
  local trouble_loaded, trouble = pcall(require, 'trouble')
  if not trouble_loaded then
    return
  end

  trouble.setup {
    action_keys = { hover = 'H' },
    fold_closed = '▶',
    fold_open = '▼',
    icons = false,
    indent_lines = false,
    padding = false,
    use_diagnostic_signs = true,
  }
end

return M
