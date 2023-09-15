local M = {}

function M.config()
  vim.g.vimwiki_list = {
    {
      name = 'work',
      path = '~/code/apsis/',
      index = 'wiki',
      ext = '.md',
      syntax = 'markdown',
    },
  }

  vim.g.vimwiki_global_ext = 0

  vim.g.vimwiki_listsyms = ' ✓'
  vim.g.vimwiki_listsym_rejected = '✗'

  vim.g.vimwiki_hl_cb_checked = 2
end

return M