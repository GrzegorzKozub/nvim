local M = {}

function M.config()
  local trouble_loaded, trouble = pcall(require, 'trouble')
  if not trouble_loaded then
    return
  end

  local icons = require('cfg.icons').get()

  trouble.setup {
    fold_closed = icons.fold.closed,
    fold_open = icons.fold.open,
    icons = false,
    indent_lines = false,
    padding = false,
    signs = {
      error = icons.diag.error,
      warning = icons.diag.warning,
      hint = icons.diag.hint,
      information = icons.diag.info,
      other = icons.diag.info,
    },
    win_config = { border = 'rounded' },
  }
end

return M
