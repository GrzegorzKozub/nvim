local M = {}

local function options()
  vim.g.gruvbox_material_background = 'soft'
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_disable_italic_comment = 1
  vim.g.gruvbox_material_foreground = 'original' -- switch to 'material' soon (remove this option)
  vim.g.gruvbox_material_show_eob = 0
  vim.g.gruvbox_material_statusline_style = 'original' -- switch to 'default' soon (remove this option)

  if vim.g.gruvbox_material_foreground == 'original' then
    local fg0 = vim.o.background == 'dark' and { '#d5c4a1', '250' } or { '#504945', '239' }
    vim.g.gruvbox_material_colors_override = {
      fg0 = fg0,
      bg_statusline3 = { '#514945', '239' }, -- continue and introduce versions for light background
    }
  else
    vim.g.gruvbox_material_colors_override = vim.empty_dict()
  end
end

local function custom_colors()
  local group = vim.api.nvim_create_augroup('GruvboxMaterialCustomColors', { clear = true })
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'gruvbox-material',
    callback = function(args)
      local prefix = args.match:gsub('-', '_')

      -- switch 'original' to 'default' soon
      local palette = vim.fn[prefix .. '#get_palette']('soft', 'original', vim.g.gruvbox_material_colors_override)

      local hi = prefix .. '#highlight'

      vim.fn[hi]('Folded', palette.bg5, palette.none)
      vim.fn[hi]('IncSearch', palette.bg0, palette.orange)
      vim.fn[hi]('Search', palette.bg0, palette.yellow)
      vim.fn[hi]('StatusLine', palette.grey0, palette.none)
      vim.fn[hi]('StatusLineNC', palette.bg0, palette.none)
      vim.fn[hi]('Todo', palette.grey1, palette.none)
      vim.fn[hi]('VirtualTextError', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextHint', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextInfo', palette.bg5, palette.none)
      vim.fn[hi]('VirtualTextWarning', palette.bg5, palette.none)
      vim.fn[hi]('WildMenu', palette.fg0, palette.none)

      vim.cmd.hi('ErrorMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('ModeMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('MoreMsg', 'gui=NONE cterm=NONE')
      vim.cmd.hi('Title', 'gui=NONE cterm=NONE')
      vim.cmd.hi('Underlined', 'gui=NONE cterm=NONE')
      vim.cmd.hi('WarningMsg', 'gui=NONE cterm=NONE')
    end,
    group = group,
  })
end

function M.setup()
  local theme = require('cfg.my-theme').get()
  vim.opt.background = theme.background
  options()
  custom_colors()
  vim.cmd.colorscheme(theme.vim)
end

function M.lualine_theme()
  local theme = require('lualine.themes.' .. require('cfg.my-theme').get().lualine)
  for _, mode in pairs { 'normal', 'insert', 'visual', 'replace', 'command', 'terminal', 'inactive' } do
    theme[mode].c.bg = 'NONE'
  end

  -- get these from palette or use the global override variable
  theme.normal.a.bg = '#7c6f64'
  -- theme.normal.b.bg = '#514945'

  return theme
end

return M
