local M = {}

function M.config()
  local markdown_togglecheck_loaded, markdown_togglecheck = pcall(require, 'markdown')
  if not markdown_togglecheck_loaded then
    return
  end

  markdown_togglecheck.setup { remove = true }

  -- require('cfg.util').nmap('<leader>x', markdown_togglecheck.toggle)
end

return M