local M = {}

local function options()
  vim.g.gruvbox_material_background = 'soft'
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_disable_italic_comment = 1
  vim.g.gruvbox_material_foreground = 'original' -- switch to material soon
  vim.g.gruvbox_material_lightline_disable_bold = 1
  vim.g.gruvbox_material_show_eob = 0

  if vim.g.gruvbox_material_foreground == 'original' then
    local fg0 = vim.o.background == 'dark' and { '#d5c4a1', '250' } or { '#504945', '239' }
    vim.g.gruvbox_material_colors_override = { fg0 = fg0 }
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

local function apply()
  local theme = require('cfg.theme').get()
  vim.opt.background = theme.background
  vim.cmd.colorscheme(theme.vim)
end

function M.setup()
  options()
  custom_colors()
  apply()
end

return M
