--- @diagnostic disable: undefined-field

local M = {}

function M.kinds()
  local icons = require('cfg.icons').get()
  return {
    Text = icons.dev.text,
    Method = icons.dev.method,
    Function = icons.dev.func,
    Constructor = icons.dev.constructor,
    Field = icons.dev.field,
    Variable = icons.dev.variable,
    Class = icons.dev.class,
    Interface = icons.dev.interface,
    Module = icons.dev.module,
    Property = icons.dev.property,
    Unit = icons.dev.unit,
    Value = icons.dev.number,
    Enum = icons.dev.enum,
    Keyword = icons.dev.keyword,
    Snippet = icons.dev.snippet,
    Color = icons.dev.color,
    File = icons.file.file,
    Reference = icons.dev.reference,
    Folder = icons.file.dir,
    EnumMember = icons.dev.enum_member,
    Constant = icons.dev.constant,
    Struct = icons.dev.struct,
    Event = icons.dev.event,
    Operator = icons.dev.operator,
    TypeParameter = icons.dev.type_parameter,
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
