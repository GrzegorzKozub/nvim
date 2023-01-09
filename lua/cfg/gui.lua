local M = {}

function M.config()
  local options = { noremap = true, silent = true }

  vim.keymap.set('n', '<F10>', function()
    vim.fn.GuiWindowMaximized(vim.g.GuiWindowMaximized == 0)
  end, options)

  vim.keymap.set('n', '<F11>', function()
    vim.fn.GuiWindowFullScreen(vim.g.GuiWindowFullScreen == 0)
  end, options)

  vim.cmd.Guifont 'Fira Code Retina:h12'
  vim.cmd.GuiRenderLigatures(1)
end

return M
