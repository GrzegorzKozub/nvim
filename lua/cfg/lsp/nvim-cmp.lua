local M = {}

function M.config()
  local cmp_loaded, cmp = pcall(require, 'cmp')
  if not cmp_loaded then
    return
  end
  local luasnip_loaded, luasnip = pcall(require, 'luasnip')
  if not luasnip_loaded then
    return
  end

  local function window_config()
    return cmp.config.window.bordered {
      scrollbar = false,
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    }
  end

  cmp.setup {
    formatting = { expandable_indicator = false },
    mapping = cmp.mapping.preset.insert {
      ['<c-space>'] = cmp.mapping.complete(),
      ['<cr>'] = cmp.mapping.confirm { select = true },
      ['<c-e>'] = cmp.mapping.abort(),
      ['<c-b>'] = cmp.mapping.scroll_docs(-3),
      ['<c-f>'] = cmp.mapping.scroll_docs(3),
      ['<tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<s-tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    window = {
      completion = window_config(),
      documentation = window_config(),
      -- documentation = cmp.config.disable,
    },
  }

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } },
  })
end

return M
