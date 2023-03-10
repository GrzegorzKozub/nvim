local M = {}

function M.config()
  vim.g.vimwiki_global_ext = 0
  vim.g.vimwiki_hl_cb_checked = 2
  vim.g.vimwiki_list = { { path = '~/code/apsis/', path_html = '~/Downloads/apsis_html/', ext = '.wiki' } }
  vim.g.vimwiki_listsym_rejected = '✗'
  vim.g.vimwiki_listsyms = ' ✓'

  local group = vim.api.nvim_create_augroup('VimWikiSyntaxFix', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.wiki',
    callback = function()
      vim.cmd.syntax { 'sync', 'fromstart' }
    end,
    group = group,
  })
end

return M
