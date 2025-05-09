local M = {}

local function rgb(hex)
  hex = hex:gsub('#', '')
  return string.format(
    '%i,%i,%i',
    tonumber(hex:sub(1, 2), 16),
    tonumber(hex:sub(3, 4), 16),
    tonumber(hex:sub(5, 6), 16)
  )
end

function M.config()
  local fzf_lua_loaded, fzf_lua = pcall(require, 'fzf-lua')
  if not fzf_lua_loaded then
    return
  end

  local rg_colors = require('cfg.gruvbox-material').ripgrep()
  local rg_opts = string.format(
    '\z
--color=always \z
--colors=column:fg:%s --colors=line:fg:%s --colors=match:fg:%s --colors=path:fg:%s \z
--colors=match:style:nobold \z
--column --line-number --no-heading --trim \z
--glob=!**/.git/* --glob=!**/node_modules/* \z
--smart-case',
    rgb(rg_colors.column),
    rgb(rg_colors.line),
    rgb(rg_colors.match),
    rgb(rg_colors.path)
  )

  local git_log = "git log --color \z
--format=format:'%C(yellow)%h %C(auto)%s %C(cyan)%an %C(brightblack)%ar %C(auto)%D%C(reset)'"

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
      fzf = { ['alt-p'] = 'toggle-preview', ['alt-w'] = 'toggle-preview-wrap' },
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
      ['info'] = { 'fg', 'FzfLuaFzfInfo' },
    },
    defaults = { color_icons = false },
    files = { cwd_prompt = false },
    oldfiles = { include_current_session = true },
    grep = { hidden = true, rg_opts = rg_opts },
    git = {
      commits = { cmd = git_log },
      bcommits = { cmd = git_log .. ' {file}' },
    },
  }

  local nmap = require('cfg.util').nmap

  nmap('<c-p>', fzf_lua.files)
  nmap('<c-k>', fzf_lua.oldfiles)
  nmap('<c-b>', fzf_lua.buffers)

  nmap('<c-g>', fzf_lua.live_grep_resume)

  local show_preview = { winopts = { preview = { hidden = false } } }
  nmap('<leader>gl', function()
    fzf_lua.git_bcommits(show_preview)
  end)
  nmap('<leader>gL', function()
    fzf_lua.git_commits(show_preview)
  end)

  nmap('<leader>S', function()
    fzf_lua.spell_suggest { winopts = { height = 0.2, width = 0.4 } }
  end)

  -- todo: quickfix, loclist, lsp_live_workspace_symbols, lsp_document_symbols, lsp...
end

return M
