local M = {}

function M.config()
  vim.api.nvim_create_autocmd('UIEnter', {
    once = true,
    callback = function()
      if vim.g.GuiLoaded == nil then
        return
      end

      vim.cmd.Guifont 'Cascadia Code:h13'
      -- vim.cmd.Guifont 'Fira Code Retina:h12'

      vim.cmd.GuiRenderLigatures(1)

      local nmap = require('cfg.util').nmap

      nmap('<f10>', function()
        vim.fn.GuiWindowMaximized(vim.g.GuiWindowMaximized == 0)
      end)
      nmap('<f11>', function()
        vim.fn.GuiWindowFullScreen(vim.g.GuiWindowFullScreen == 0)
      end)
    end,
    group = vim.api.nvim_create_augroup('GUI', { clear = true }),
  })
end

return M