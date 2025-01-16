local M = {}

function M.config()
  local barbar_loaded, barbar = pcall(require, 'barbar')
  if not barbar_loaded then
    return
  end

  barbar.setup {
    animation = false,
    auto_hide = 1,
    icons = {
      button = false,
      diagnostics = { -- disabled by default
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = true },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      -- gitsigns = { -- defaults
      --   added = { enabled = true, icon = '+' },
      --   changed = { enabled = true, icon = '~' },
      --   deleted = { enabled = true, icon = '-' },
      -- },
      separator = { left = '', right = '' },
      separator_at_end = false,
      modified = { button = '●' }, -- default
      pinned = { -- to refine
        button = '',
        filename = true,
        separator = { right = '    ' },
      },
    },
    maximum_padding = 1,
    maximum_length = 16,
    no_name_title = 'untitled',
    tabpages = false,
  }
end

return M
