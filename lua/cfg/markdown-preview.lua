local M = {}

function M.config()
  require('cfg.util').nmap('<leader>mp', '<cmd>MarkdownPreviewToggle<cr>')
end

return M