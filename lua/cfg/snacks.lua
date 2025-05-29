local M = {}

function M.config()
  local snacks_loaded, snacks = pcall(require, 'snacks')
  if not snacks_loaded then
    return
  end

  snacks.setup {
    image = { doc = { inline = false, max_width = 64, max_height = 32 } },
    input = { icon = '' },
    -- TODO: notifier
    -- TODO: picker
    scroll = { enabled = true },
    -- TODO: words
    styles = {
      snacks_image = { border = 'none', row = 2, col = 2 },
      input = { width = 32, relative = 'cursor', row = 2, col = 2 },
    },
  }
end

return M
