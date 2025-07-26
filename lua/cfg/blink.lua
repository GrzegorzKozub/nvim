local M = {}

function M.config()
  local blink_loaded, blink = pcall(require, 'blink.cmp')
  if not blink_loaded then
    return
  end

  -- todo: cleanup mini.icons, go through reference

  -- https://cmp.saghen.dev/configuration/reference.html
  blink.setup {
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
      ['<c-s>'] = { 'show_signature', 'hide_signature', 'fallback' }, -- overrides neovim default
      ['<c-k>'] = false,
    },
    completion = {
      list = { max_items = 256 },
      menu = {
        max_height = 16,
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = { auto_show = true, window = { max_width = 64, max_height = 16 } },
    },
    -- continue
    signature = { enabled = true, window = {} },
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
    cmdline = {
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
      completion = {
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ':'
          end,
        },
      },
    },
  }
end

return M
