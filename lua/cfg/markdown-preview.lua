local M = {}

function M.config()
  require('cfg.util').nmap('<leader>mp', ':MarkdownPreviewToggle<cr>')
end

return M
