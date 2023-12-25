local M = {}

function M.config()
  local noice_loaded, noice = pcall(require, 'noice')
  if not noice_loaded then
    return
  end

  noice.setup {
    cmdline = {
      enabled = true,
      format = {
        cmdline = { icon = '●•', title = ' command ' },
        help = { icon = '●•', title = ' help ' },
      },
    },
    messages = { enabled = true },
    popupmenu = { enabled = true },
    notify = { enabled = false },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
      message = { enabled = false },
    },
  }

  require('notify').setup {
    background_colour = '#514945',
  }

  vim.cmd [[hi NoiceCmdlinePopupBorder guifg=#514945 guibg=NONE]]
  vim.cmd [[hi NoiceCmdlineIcon guifg=#514945 guibg=NONE]]
  vim.cmd [[hi NoiceCmdlinePopupTitle guifg=#514945 guibg=NONE]]
  vim.cmd [[hi NoiceCursor guifg=#514945 gui=reverse]]
end

return M