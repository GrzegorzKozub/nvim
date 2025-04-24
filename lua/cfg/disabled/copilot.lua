local M = {}

function M.config()
  local copilot_loaded, copilot = pcall(require, 'copilot')
  if not copilot_loaded then
    return
  end

  copilot.setup {
    filetypes = {
      ini = false,
      pem = false,
      sh = function()
        return string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '.env') and false
          or true
      end,
      text = false,
      yaml = false,
    },
    panel = { enabled = false },
    suggestion = {
      keymap = {
        accept = '<tab>',
        dismiss = '<esc>',
        next = '<M-]>',
        prev = '<M-[>',
      },
    },
  }

  local nmap = require('cfg.util').nmap

  nmap('<leader>ce', ':Copilot enable<cr>')
  nmap('<leader>cd', ':Copilot disable<cr>')
end

return M
