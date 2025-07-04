local M = {}

function M.config()
  local blink_loaded, blink = pcall(require, 'blink.cmp')
  if not blink_loaded then
    return
  end

  -- resume from https://main.cmp.saghen.dev/configuration/appearance.html
  -- todo: enter & tab to accept, mini.icons cleanup, defaults removal
  blink.setup {
    -- keymap = { preset = 'default' },
    completion = {
      menu = {
        border = 'rounded',
        draw = {
          -- columns = {
          -- { 'label', 'label_description', gap = 1 },
          -- { 'kind_icon', 'kind' },
          -- },
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
            kind = {
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'rounded' },
      },
      ghost_text = { enabled = true },
    },
    -- signature = { window = { border = 'single' } },
    signature = { enabled = true },
    -- sources = {
    --       default = { 'lsp', 'path', 'snippets', 'buffer' },
    --     },
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
