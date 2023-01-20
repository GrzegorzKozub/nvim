local M = {}

local function options()
  vim.g.gruvbox_material_background = 'soft'
  vim.g.gruvbox_material_better_performance = 1
  -- vim.g.gruvbox_material_disable_italic_comment = 1
  vim.g.gruvbox_material_foreground = 'material'
  vim.g.gruvbox_material_show_eob = 0

  if vim.g.gruvbox_material_foreground == 'original' then
    local fg0 = vim.o.background == 'dark' and { '#d5c4a1', '250' } or { '#504945', '239' }
    vim.g.gruvbox_material_colors_override = {
      fg0 = fg0,
    }
  else
    vim.g.gruvbox_material_colors_override = vim.empty_dict()
  end
end

local function get_palette()
  return vim.fn['gruvbox_material#get_palette']('soft', 'material', vim.g.gruvbox_material_colors_override)
end

local function custom_colors()
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'gruvbox-material',
    callback = function()
      local hi = 'gruvbox_material#highlight'
      local palette = get_palette()

      vim.cmd.hi('ErrorFloat', 'guibg=NONE ctermbg=NONE')
      vim.cmd.hi('ErrorMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('HintFloat', 'guibg=NONE ctermbg=NONE')
      vim.cmd.hi('InfoFloat', 'guibg=NONE ctermbg=NONE')
      vim.cmd.hi('ModeMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('MoreMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('Title', 'gui=NONE cterm=NONE')
      vim.cmd.hi('WarningFloat', 'guibg=NONE ctermbg=NONE')
      vim.cmd.hi('WarningMsg', 'gui=NONE cterm=NONE')

      vim.fn[hi]('FloatBorder', palette.bg5, palette.bg0)
      vim.fn[hi]('Folded', palette.bg5, palette.none)
      vim.fn[hi]('IncSearch', palette.bg0, palette.orange)
      vim.fn[hi]('NormalFloat', palette.fg0, palette.bg0)
      vim.fn[hi]('Search', palette.bg0, palette.yellow)
      vim.fn[hi]('StatusLine', palette.grey0, palette.none)
      vim.fn[hi]('StatusLineNC', palette.bg0, palette.none)
      vim.fn[hi]('Tabline', palette.bg5, palette.bg0)
      vim.fn[hi]('TablineFill', palette.bg5, palette.bg0)
      vim.fn[hi]('TablineSel', palette.grey1, palette.bg0)
      vim.fn[hi]('Todo', palette.grey1, palette.none)
      vim.fn[hi]('VirtualTextError', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextHint', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextInfo', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextWarning', palette.bg5, palette.none)
      vim.fn[hi]('WildMenu', palette.fg0, palette.none)

      -- cmp
      vim.fn[hi]('CmpItemAbbr', palette.grey2, palette.none)
      vim.fn[hi]('CmpItemAbbrMatch', palette.yellow, palette.none)
      vim.fn[hi]('CmpItemAbbrMatchFuzzy', palette.yellow, palette.none)
      for kind, _ in pairs(require('cfg.nvim-cmp').kinds()) do
        vim.fn[hi]('CmpItemKind' .. kind, palette.grey0, palette.none)
      end
      vim.fn[hi]('CmpItemMenu', palette.grey2, palette.none)
      vim.fn[hi]('CustomCmpNormal', palette.grey2, palette.none)

      -- illuminate
      vim.fn[hi]('CurrentWord', palette.none, palette.bg3)

      -- null-ls
      vim.fn[hi]('NullLsInfoBorder', palette.bg5, palette.none)

      -- nvim-lspconfig
      vim.fn[hi]('LspInfoBorder', palette.bg5, palette.none)

      -- telescope
      vim.fn[hi]('TelescopeBorder', palette.bg5, palette.none)
      vim.fn[hi]('TelescopeMatching', palette.yellow, palette.none)
      vim.fn[hi]('TelescopeMultiIcon', palette.fg0, palette.none)
      vim.fn[hi]('TelescopeMultiSelection', palette.fg1, palette.none)
      vim.fn[hi]('TelescopePromptPrefix', palette.orange, palette.none)
      vim.fn[hi]('TelescopeResultsDiffAdd', palette.green, palette.none)
      vim.fn[hi]('TelescopeResultsDiffChange', palette.blue, palette.none)
      vim.fn[hi]('TelescopeResultsDiffDelete', palette.red, palette.none)
      vim.fn[hi]('TelescopeResultsNormal', palette.grey1, palette.none)
      vim.fn[hi]('TelescopeSelection', palette.fg1, palette.bg1)

      -- trouble
      vim.fn[hi]('TroubleCount', palette.bg5, palette.none)
      vim.fn[hi]('TroubleFile', palette.bg5, palette.none)
      vim.fn[hi]('TroubleFoldIcon', palette.bg5, palette.none)
      vim.fn[hi]('TroubleText', palette.grey2, palette.none)
    end,
    group = vim.api.nvim_create_augroup('GruvboxMaterialCustomColors', { clear = true }),
  })
end

function M.config()
  local theme = require('cfg.my-theme').get()
  vim.opt.background = theme.background
  options()
  custom_colors()
  pcall(vim.cmd.colorscheme, theme.vim)
end

function M.lualine_theme()
  local theme = require('lualine.themes.' .. require('cfg.my-theme').get().lualine)

  if vim.o.background == 'dark' then
    theme.normal.a.bg = '#7c6f64' -- was #a89984
    theme.normal.b.bg = '#514945' -- was #5b534d
    theme.normal.b.fg = '#32302f' -- was #ddc7a1 in material and #a89984 in original
    theme.normal.c.fg = '#7c6f64' -- was #ddc7a1 in material and #a89984 in original
    theme.inactive.c.fg = '#665c54' -- was #a89984
  else
    theme.normal.a.bg = '#a89984' -- was #7c6f64
    theme.normal.b.bg = '#d5c4a1' -- was #dac9a5
    theme.normal.b.fg = '#f2e5bc' -- was #4f3829 in material and #7c6f64 in original
    theme.normal.c.fg = '#a89984' -- was #4f3829 in material and #7c6f64 in original
    theme.inactive.c.fg = '#d5c4a1' -- was #7c6f64
  end

  local palette = get_palette()

  theme.insert.a.bg = palette.blue[1]
  theme.visual.a.bg = palette.green[1]
  theme.replace.a.bg = palette.orange[1]
  theme.command.a.bg = palette.aqua[1]

  for _, mode in pairs { 'insert', 'visual', 'replace', 'command', 'terminal' } do
    theme[mode].b = theme.normal.b
    theme[mode].c = theme.normal.c
    theme[mode].z = theme.normal.a
  end

  for _, mode in pairs { 'normal', 'insert', 'visual', 'replace', 'command', 'terminal', 'inactive' } do
    theme[mode].a.gui = 'NONE'
    theme[mode].c.bg = 'NONE'
  end

  return theme
end

return M