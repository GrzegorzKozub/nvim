local M = {}

function M.config()
  require('cfg.util').nmap('<leader>mp', '<cmd>Vivify<cr>')
end

return M