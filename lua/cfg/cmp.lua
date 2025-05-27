--- @diagnostic disable: undefined-field

local M = {}

function M.kinds()
  local icons = require('cfg.icons').get().lsp
  return {
    Class = icons.class,
    Color = icons.color,
    Constant = icons.constant,
    Constructor = icons.constructor,
    Enum = icons.enum,
    EnumMember = icons.enum_member,
    Event = icons.event,
    Field = icons.field,
    File = icons.file,
    Folder = icons.file.dir,
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

  local window = cmp.config.window.bordered { scrollbar = false }

  cmp.setup {
    formatting = {
      expandable_indicator = true,
      format = function(_, vim_item)
        vim_item.kind = M.kinds()[vim_item.kind]
        return vim_item
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<c-space>'] = cmp.mapping.complete(),
      ['<cr>'] = cmp.mapping.confirm(),
      ['<c-e>'] = cmp.mapping.abort(),
      ['<s-up>'] = cmp.mapping.scroll_docs(-4),
      ['<s-down>'] = cmp.mapping.scroll_docs(4),
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
      -- { name = 'lazydev' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }, {
      { name = 'zsh' }, -- not on windows
    }, {
      { name = 'path' },
    }),
    window = { completion = window, documentation = window },
  }

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'cmdline_history' },
      { name = 'cmdline' },
    }, {
      { name = 'path' },
    }),
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources {
      { name = 'cmdline_history' },
      { name = 'buffer' },
    },
  })
end

return M
