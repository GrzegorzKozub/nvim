local M = {}

function M.config()
  local blink_loaded, blink = pcall(require, 'blink.cmp')
  if not blink_loaded then
    return
  end

  local icons = require('cfg.icons').get().lsp
  local kind_icons = {
    Class = icons.class,
    Color = icons.color,
    Constant = icons.constant,
    Constructor = icons.constructor,
    Enum = icons.enum,
    EnumMember = icons.enum_member,
    Event = icons.event,
    Field = icons.field,
    File = icons.file,
    Folder = icons.folder,
    Function = icons['function'],
    Interface = icons.interface,
    Keyword = icons.keyword,
    Method = icons.method,
    Module = icons.module,
    Operator = icons.operator,
    Property = icons.property,
    Reference = icons.reference,
    Snippet = icons.snippet,
    Struct = icons.struct,
    Text = icons.text,
    TypeParameter = icons.type_parameter,
    Unit = icons.unit,
    Value = icons.number,
    Variable = icons.variable,
  }

  -- https://cmp.saghen.dev/configuration/reference.html
  blink.setup {
    appearance = { kind_icons = kind_icons },
    cmdline = {
      completion = {
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ':'
          end,
        },
      },
      keymap = {
        preset = 'cmdline',
        ['<esc>'] = {
          'cancel',
          function()
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes('<c-c>', true, false, true),
              'c',
              false
            )
          end,
        },
        ['<tab>'] = { 'show', 'accept' },
        ['<s-tab>'] = false,
        ['<up>'] = { 'select_prev', 'fallback' },
        ['<down>'] = { 'select_next', 'fallback' },
      },
    },
    completion = {
      documentation = { auto_show = true, window = { max_height = 16, max_width = 64 } },
      list = { max_items = 256 },
      menu = {
        draw = {
          components = {
            kind_icon = {
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
              -- text = function(ctx)
              --   local icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              --   return icon
              -- end,
            },
          },
        },
        max_height = 16,
      },
    },
    keymap = {
      preset = 'default', -- https://cmp.saghen.dev/configuration/keymap#presets
      ['<esc>'] = { 'cancel', 'fallback' },
      ['<cr>'] = { 'select_and_accept', 'fallback' },
      ['<tab>'] = { 'select_and_accept', 'fallback' },
      ['<s-tab>'] = false,
      ['<s-up>'] = { 'scroll_documentation_up', 'fallback' },
      ['<s-down>'] = { 'scroll_documentation_down', 'fallback' },
      ['<c-b>'] = false,
      ['<c-f>'] = false,
      ['<c-i>'] = { 'show_signature', 'hide_signature', 'fallback' }, -- same as zed
      ['<c-s>'] = { 'show_signature', 'hide_signature', 'fallback' }, -- overrides neovim default
      ['<c-k>'] = false,
    },
    signature = { enabled = true, window = { max_height = 8, max_width = 64 } },
    sources = {
      providers = {
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },
  }
end

return M
