local M = {}

function M.config()
  local treesitter_context_loaded, treesitter_context = pcall(require, 'treesitter-context')
  if not treesitter_context_loaded then
    return
  end

  treesitter_context.setup {
    separator = require('cfg.icons').get().treesitter_context.separator,
  }
end

return M
