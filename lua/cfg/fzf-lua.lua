local M = {}

local nmap = require('cfg.util').nmap

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

  local icons = require('cfg.icons').get().dev
  local symbol_icons = {
    Array = icons.array,
    Boolean = icons.boolean,
    Class = icons.class,
    Constant = icons.constant,
    Constructor = icons.constructor,
    Enum = icons.enum,
    EnumMember = icons.enum_member,
    Event = icons.event,
    Field = icons.field,
    File = icons.file,
    Function = icons.func,
    Interface = icons.interface,
    Key = icons.keyword,
    Method = icons.method,
    Module = icons.module,
    Namespace = icons.namespace,
    Null = icons.null,
    Number = icons.number,
    Object = icons.object,
    Operator = icons.operator,
    Package = icons.package,
    Property = icons.property,
    String = icons.string,
    Struct = icons.struct,
    TypeParameter = icons.type_parameter,
    Variable = icons.variable,
  }

  fzf_lua.setup {
    'hide',
    winopts = {
      row = 0.5,
      height = 0.8,
      backdrop = 0,
      border = 'none',
      preview = {
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
    lsp = {
      symbols = {
        symbol_style = 2,
        symbol_icons = symbol_icons,
        symbol_hl = false,
        symbol_fmt = function(s)
          return s
        end,
      },
      code_actions = { prompt = '●• ' },
    },
    diagnostics = { fzf_opts = { ['--pointer'] = '▌' } },
  }

  fzf_lua.register_ui_select() -- required when lazy-loaded

  -- local hide_preview = { winopts = { preview = { hidden = true } } }

  nmap('<c-p>', fzf_lua.files)
  nmap('<c-k>', fzf_lua.oldfiles)
  nmap('<c-b>', fzf_lua.buffers)

  nmap('<c-g>', fzf_lua.live_grep)

  nmap('<leader>m', fzf_lua.marks)

  nmap('<leader>Q', fzf_lua.quickfix)
  nmap('<leader>L', fzf_lua.loclist)

  nmap('<leader>gl', fzf_lua.git_bcommits)
  nmap('<leader>gL', fzf_lua.git_commits)

  nmap('<leader>S', function()
    fzf_lua.spell_suggest { winopts = { height = 0.2, width = 0.4 } }
  end)
end

function M.lsp()
  local fzf_lua = require 'fzf-lua'

  nmap('gd', fzf_lua.lsp_definitions)
  nmap('gD', fzf_lua.lsp_declarations)

  nmap('gri', fzf_lua.lsp_implementations) -- overrides neovim default
  nmap('grr', fzf_lua.lsp_references) -- overrides neovim default
  nmap('grt', fzf_lua.lsp_typedefs)

  nmap('gO', fzf_lua.lsp_document_symbols) -- overrides neovim default
  nmap('<c-t>', fzf_lua.lsp_workspace_symbols)

  nmap('<leader>d', fzf_lua.lsp_document_diagnostics)
  nmap('<leader>D', fzf_lua.lsp_workspace_diagnostics)

  nmap('gra', fzf_lua.lsp_code_actions) -- overrides neovim default
end

return M
