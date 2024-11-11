local M = {}

function M.config()
  local copilot_loaded, copilot = pcall(require, 'copilot')
  if not copilot_loaded then
    return
  end

  copilot.setup {
    filetypes = {
      cucumber = true,
      cs = true,
      dockerfile = true,
      elixir = true,
      go = true,
      gomod = true,
      html = true,
      javascript = true,
      json = true,
      lua = true,
      nu = true,
      ps1 = true,
      python = true,
      rust = true,
      sh = true,
      sql = true,
      toml = true,
      typescript = true,
      xml = true,
      yaml = true,
      zsh = true,
      ['*'] = false,
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
