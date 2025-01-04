local M = {}

local function options()
  vim.g.gruvbox_material_background = 'soft'
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_lightline_disable_bold = 1
  vim.g.gruvbox_material_show_eob = 0
  vim.g.gruvbox_material_transparent_background = 1

  vim.g.gruvbox_material_colors_override = {
    bg_diff_green = { '#494B38', '22' },
    bg_diff_green_light = { '#636942', '22' },
    bg_diff_blue = { '#3F4946', '17' },
    bg_diff_blue_light = { '#546962', '17' },
    bg_diff_red = { '#533A37', '52' },
    bg_diff_red_light = { '#7A4541', '52' },
  }
end

local function get_palette()
  return vim.fn['gruvbox_material#get_palette'](
    'soft',
    'material',
    vim.g.gruvbox_material_colors_override
  )
end

local function custom_colors()
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'gruvbox-material',
    callback = function()
      local hi, palette = 'gruvbox_material#highlight', get_palette()

      vim.cmd.hi('ErrorFloat', 'guibg=NONE ctermbg=NONE')
      vim.cmd.hi('ErrorMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('HintFloat', 'guibg=NONE ctermbg=NONE')
      vim.cmd.hi('InfoFloat', 'guibg=NONE ctermbg=NONE')
      vim.cmd.hi('ModeMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('MoreMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('Title', 'gui=NONE cterm=NONE')
      vim.cmd.hi('TSURI', 'gui=NONE cterm=NONE')
      vim.cmd.hi('WarningFloat', 'guibg=NONE ctermbg=NONE')
      vim.cmd.hi('WarningMsg', 'gui=NONE cterm=NONE')

      vim.fn[hi]('Comment', palette.grey0, palette.none, 'italic')

      vim.fn[hi]('CursorLineNr', palette.bg5, palette.none)
      vim.fn[hi]('LineNr', palette.bg3, palette.none)

      vim.fn[hi]('FloatBorder', palette.bg5, palette.none)
      vim.fn[hi]('NormalFloat', palette.fg0, palette.none)

      vim.fn[hi]('Folded', palette.bg5, palette.none)

      vim.fn[hi]('IncSearch', palette.bg0, palette.orange)
      vim.fn[hi]('Search', palette.bg0, palette.yellow)

      vim.fn[hi]('StatusLine', palette.grey0, palette.none)
      vim.fn[hi]('StatusLineNC', palette.bg0, palette.none)

      vim.fn[hi]('Tabline', palette.bg5, palette.bg0)
      vim.fn[hi]('TablineFill', palette.bg5, palette.bg0)
      vim.fn[hi]('TablineSel', palette.grey1, palette.bg0)

      vim.fn[hi]('Todo', palette.grey1, palette.none)

      vim.fn[hi]('WildMenu', palette.fg0, palette.none)

      -- diff
      vim.fn[hi]('DiffText', palette.none, palette.bg_diff_blue_light)

      -- lsp

      vim.fn[hi]('CurrentWord', palette.none, palette.bg3)
      -- vim.fn[hi]('LspReferenceRead', palette.none, palette.bg3)
      -- vim.fn[hi]('LspReferenceTarget', palette.none, palette.bg3)
      -- vim.fn[hi]('LspReferenceText', palette.none, palette.bg3)

      vim.fn[hi]('LspReferenceWrite', palette.none, palette.bg5)

      vim.fn[hi]('LspInlayHint', palette.bg5, palette.none)

      vim.fn[hi]('VirtualTextError', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextHint', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextInfo', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextWarning', palette.bg5, palette.none)

      -- punctuation

      vim.fn[hi]('Delimiter', palette.grey2, palette.none)

      vim.fn[hi]('TSPunctBracket', palette.grey2, palette.none)
      vim.fn[hi]('TSPunctDelimiter', palette.grey2, palette.none)
      vim.fn[hi]('TSPunctSpecial', palette.grey2, palette.none)
      vim.fn[hi]('TSTagDelimiter', palette.grey2, palette.none)

      -- cmp

      vim.fn[hi]('CmpItemAbbr', palette.grey2, palette.none)
      vim.fn[hi]('CmpItemAbbrMatch', palette.yellow, palette.none)
      vim.fn[hi]('CmpItemAbbrMatchFuzzy', palette.yellow, palette.none)
      vim.fn[hi]('CmpItemMenu', palette.grey2, palette.none)

      for kind, _ in pairs(require('cfg.cmp').kinds()) do
        vim.fn[hi]('CmpItemKind' .. kind, palette.grey0, palette.none)
      end

      -- gitsigns

      vim.fn[hi]('GitSignsCurrentLineBlame', palette.bg5, palette.none)

      vim.fn[hi]('GitSignsAddInline', palette.none, palette.bg_diff_green_light)
      vim.fn[hi]('GitSignsChangeInline', palette.none, palette.bg_diff_blue_light)
      vim.fn[hi]('GitSignsDeleteInline', palette.none, palette.bg_diff_red_light)

      -- html
      vim.cmd.hi('link', '@string.special.url', 'TSURI')

      -- markdown

      vim.fn[hi]('@markup.link', palette.grey2, palette.none) -- punctuation

      vim.cmd.hi('link', '@markup.link.label', 'Purple')
      vim.cmd.hi('link', '@markup.link.text', 'Blue')

      -- nvim-lspconfig
      vim.fn[hi]('LspInfoBorder', palette.fg0, palette.none)

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

      -- trouble.nvim
      vim.fn[hi]('TroubleCount', palette.bg5, palette.none)
      vim.fn[hi]('TroubleDirectory', palette.grey0, palette.none)
      vim.fn[hi]('TroubleFileName', palette.grey0, palette.none)
      vim.fn[hi]('TroubleIconDirectory', palette.grey0, palette.none)
      vim.fn[hi]('TroubleIconFile', palette.grey0, palette.none)
      vim.fn[hi]('TroubleIndent', palette.bg5, palette.none)
      vim.fn[hi]('TroubleIndentFoldClosed', palette.bg5, palette.none)
      vim.fn[hi]('TroubleIndentFoldOpen', palette.bg5, palette.none)
      vim.fn[hi]('TroubleTitle', palette.bg5, palette.none)

      -- zsh
      vim.cmd.hi('link', 'zshOperator', 'Operator')
      vim.cmd.hi('link', 'zshVariable', 'Blue')
    end,
    group = vim.api.nvim_create_augroup('GruvboxMaterialCustomColors', { clear = true }),
  })
end

function M.config()
  local theme = require('cfg.theme').get()
  vim.opt.background = theme.background
  options()
  custom_colors()
  pcall(vim.cmd.colorscheme, theme.vim)
end

function M.lualine_theme()
  local theme = require('lualine.utils.loader').load_theme 'gruvbox-material'

  if vim.o.background == 'dark' then
    theme.normal.a.bg = '#7c6f64' -- was #a89984
    theme.normal.b.bg = '#514945' -- was #5b534d
    theme.normal.b.fg = '#32302f' -- was #ddc7a1 in material
    theme.normal.c.fg = '#7c6f64' -- was #ddc7a1 in material
    theme.inactive.c.fg = '#665c54' -- was #a89984
  else
    theme.normal.a.bg = '#a89984' -- was #7c6f64
    theme.normal.b.bg = '#d5c4a1' -- was #dac9a5
    theme.normal.b.fg = '#f2e5bc' -- was #4f3829 in material
    theme.normal.c.fg = '#a89984' -- was #4f3829 in material
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

  for _, mode in pairs {
    'normal',
    'insert',
    'visual',
    'replace',
    'command',
    'terminal',
    'inactive',
  } do
    theme[mode].c.bg = 'NONE'
    theme[mode].a.gui = 'NONE'
  end

  return theme
end

function M.default_icon_color()
  -- nvim-web-devicons
  return get_palette().fg0
end

-- override colors set by themes via $VIMRUNTIME/after/syntax

function M.json()
  local hi, palette = 'gruvbox_material#highlight', get_palette()

  -- punctuation (quotes)
  vim.fn[hi]('@conceal', palette.grey2, palette.none)
end

function M.markdown()
  local hi, palette = 'gruvbox_material#highlight', get_palette()

  -- punctuation (code block languages)
  vim.fn[hi]('TSLabel', palette.grey2, palette.none)
end

return M
