local M = {}

function M.kinds()
  return {
    Class = 'class',
    Color = 'color',
    Constant = 'constant',
    Constructor = '󰙴',
    Enum = 'enum',
    EnumMember = 'enum member',
    Event = 'event',
    Field = '󰌖',
    File = '󰈤',
    Folder = '󰉖',
    Function = '󰊕',
    Interface = 'interface',
    Keyword = '󰌆',
    Method = '󰊕',
    Module = 'module',
    Operator = 'operator',
    Property = 'property',
    Reference = 'reference',
    Snippet = '󰑷',
    Struct = 'struct',
    Text = '󰦨',
    TypeParameter = 'type parameter',
    Unit = 'unit',
    Value = 'value',
    Variable = '󰫧',
  }
end

function M.config()
  local cmp_loaded, cmp = pcall(require, 'cmp')
  if not cmp_loaded then
    return
  end
  local luasnip_loaded, luasnip = pcall(require, 'luasnip')
  if not luasnip_loaded then
    return
  end

  cmp.setup {
    formatting = {
      expandable_indicator = true,
      format = function(_, vim_item)
        vim_item.kind = M.kinds()[vim_item.kind]
        return vim_item
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<c-space>'] = cmp.mapping.complete {},
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
      { name = 'luasnip' },
    }, {
      { name = 'nvim_lua' },
      { name = 'zsh' },
    }, {
      { name = 'buffer' },
    }, {
      { name = 'path' },
    }, {
      { name = 'emoji' },
      { name = 'nerdfont' },
    }),
    window = {
      completion = cmp.config.window.bordered {
        scrollbar = false,
        winhighlight = 'Normal:Normal,FloatBorder:CustomCmpFloatBorder,CursorLine:Visual,Search:None',
      },
      documentation = cmp.config.window.bordered { scrollbar = false },
    },
  }

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'cmdline_history' },
    }, {
      { name = 'cmdline' },
    }, {
      { name = 'path' },
    }),
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'cmdline_history' },
    }, {
      { name = 'buffer' },
    }),
  })
end

return M
