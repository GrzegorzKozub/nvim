local M = {}

function M.config()
  local fzf_lua_loaded, fzf_lua = pcall(require, 'fzf-lua')
  if not fzf_lua_loaded then
    return
  end

  fzf_lua.setup {
    'hide', -- keeps fzf in background to enable resume
    winopts = {
      row = 0.5,
      height = 0.8,
      backdrop = 0,
      preview = {
        hidden = true,
        flip_columns = 80,
        horizontal = 'right:50%',
        vertical = 'down:50%',
        title = true, -- maybe we can show them?
        scrollbar = false,
      },
      title_flags = false,
      on_create = function()
        -- todo
      end,
    },
    keymap = {
      -- todo
    },
    fzf_opts = { ['--info'] = false },
    fzf_colors = {
      ['fg'] = { 'fg', 'FzfLuaFzfNormal' },
      ['bg'] = { 'bg', 'FzfLuaFzfNormal' },
    },
    files = { color_icons = false, cwd_prompt = false },
  }

  local nmap = require('cfg.util').nmap

  nmap('<c-f>', fzf_lua.files)
  nmap('<c-s-r>', fzf_lua.resume)
end

return M
