local M = {}

function M.config()
  local blink_loaded, blink = pcall(require, 'blink.cmp')
  if not blink_loaded then
    return
  end

  -- todo: enter & tab to accept, mini.icons cleanup, defaults removal
  -- c-e cancels the preview - want escape do do that as well
  blink.setup {
    keymap = {
      preset = 'default',
      ['<Esc>'] = { 'cancel', 'fallback' }
    },
    completion = {
      menu = {
        border = 'rounded',
        draw = {
          -- columns = {
          --   { 'source_name', 'label', 'label_description', gap = 1 },
          --   { 'kind_icon', 'kind', gap = 1 },
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
      -- ghost_text = { enabled = true },
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
