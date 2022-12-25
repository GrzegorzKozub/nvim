local M = {}

function M.setup()
  vim.g.vimwiki_global_ext = 0
  vim.g.vimwiki_hl_cb_checked = 2
  vim.g.vimwiki_list = { { path = '~/code/apsis/', path_html = '~/Downloads/apsis_html/', ext = '.wiki' } }
  vim.g.vimwiki_listsym_rejected = '✗'
  vim.g.vimwiki_listsyms = ' ✓'

  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.wiki',
    callback = function()
      vim.cmd.syntax { 'sync', 'fromstart' }
    end,
  })
end

return M
