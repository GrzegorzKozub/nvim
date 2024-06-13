local M = {}

function M.config()
  local trouble_loaded, trouble = pcall(require, 'trouble')
  if not trouble_loaded then
    return
  end

  local icons = require('cfg.icons').get()

  trouble.setup {
    indent_guides = false,
    icons = {
      indent = {
        fold_closed = icons.fold.closed,
        fold_open = icons.fold.open,
      },
    },
  }

  -- todo: icons, dir/file colors
end

return M