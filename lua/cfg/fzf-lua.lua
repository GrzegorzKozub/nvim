local M = {}

function M.config()
  local fzf_lua_loaded, fzf_lua = pcall(require, 'fzf-lua')
  if not fzf_lua_loaded then
    return
  end

  fzf_lua.setup {
    'hide',
    winopts = {
      row = 0.5,
      height = 0.8,
      backdrop = 0,
      border = 'none',
      preview = {
        hidden = true,
        flip_columns = 80,
        horizontal = 'right:50%',
        vertical = 'down:50%',
        scrollbar = false,
      },
      title_flags = false,
    },
    keymap = {
      builtin = {
        true,
        ['<m-p>'] = 'toggle-preview',
        ['<m-w>'] = 'toggle-preview-wrap',
        ['<m-f>'] = 'toggle-fullscreen',
        ['<m-/>'] = 'toggle-help',
      },
      fzf = {},
    },
    fzf_opts = {
      ['--info'] = false,
      ['--input-border'] = 'rounded',
      ['--list-border'] = 'rounded',
    },
    fzf_colors = {
      ['border'] = { 'fg', 'FzfLuaFzfBorder' },
      ['fg'] = { 'fg', 'FzfLuaFzfNormal' },
      ['fg+'] = { 'fg', 'FzfLuaFzfCursorLine' },
      ['bg+'] = { 'bg', 'FzfLuaFzfCursorLine' },
      ['hl'] = { 'fg', 'FzfLuaFzfMatch' },
      ['hl+'] = { 'fg', 'FzfLuaFzfMatch' },
      ['selected-hl'] = { 'fg', 'FzfLuaFzfMatch' },
      ['prompt'] = { 'fg', 'FzfLuaFzfPrompt' },
      ['pointer'] = { 'fg', 'FzfLuaFzfPrompt' },
      ['marker'] = { 'fg', 'FzfLuaFzfPrompt' },
    },
    files = { color_icons = false, cwd_prompt = false },
  }

  local nmap = require('cfg.util').nmap

  nmap('<c-k>', fzf_lua.oldfiles)
  nmap('<c-p>', fzf_lua.files)
  nmap('<c-b>', fzf_lua.buffers)
  nmap('<c-t>', fzf_lua.lsp_live_workspace_symbols)
  nmap('<leader><c-q>', fzf_lua.quickfix)
  nmap('<leader><c-l>', fzf_lua.loclist)
  nmap('<c-g>', fzf_lua.live_grep_resume) -- live_grep live_grep_native

  -- git_status git_commits
  -- lsp_...
  -- spell_suggest
  --
  -- builtin
  --
  --command_history search_history

  -- nmap('<c-s-r>', fzf_lua.resume)
end

return M
