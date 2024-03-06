local M = {}

function M.config()
  local silicon_loaded, silicon = pcall(require, 'silicon')
  if not silicon_loaded then
    return
  end

  silicon.setup {
    disable_defaults = true,
    language = function()
      return vim.bo.filetype
    end,
    to_clipboard = true,
  }
end

return M
