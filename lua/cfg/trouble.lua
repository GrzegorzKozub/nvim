local M = {}

function M.config()
  local trouble_loaded, trouble = pcall(require, 'trouble')
  if not trouble_loaded then
    return
  end

  local file_icon = '{hl:TroubleIconFile}{file_icon}{hl}'

  local icons = require('cfg.icons').get()

  local kinds = {
    Array = icons.dev.array,
    Boolean = icons.dev.boolean,
    Class = icons.dev.class,
    Constant = icons.dev.constant,
    Constructor = icons.dev.constructor,
    Enum = icons.dev.enum,
    EnumMember = icons.dev.enum_member,
    Event = icons.dev.event,
    Field = icons.dev.field,
    File = icons.file.file,
    Function = icons.dev.func,
    Interface = icons.dev.interface,
    Key = icons.dev.keyword,
    Method = icons.dev.method,
    Module = icons.dev.module,
    Namespace = icons.dev.namespace,
    Null = icons.dev.null,
    Number = icons.dev.number,
    Object = icons.dev.object,
    Operator = icons.dev.operator,
    Package = icons.dev.package,
    Property = icons.dev.property,
    String = icons.dev.string,
    Struct = icons.dev.struct,
    TypeParameter = icons.dev.type_parameter,
    Variable = icons.dev.variable,
  }

  -- for kind, _ in pairs(kinds) do
  --   kinds[kind] = kinds[kind] .. ' '
  -- end

  local config = {
    modes = {
      diagnostics = {
        groups = {
          { 'directory', format = ' {directory_icon}{directory}{count}' },
          { 'filename', format = file_icon .. '{basename}{count}' },
        },
        format = '{severity_icon} {message:md} {item.source} '
          .. '{hl:TroubleSource}({hl}{code}{hl:TroubleSource}){hl} {pos}',
        win = { size = { height = 16 } },
      },
      lsp_document_symbols = {
        title = ' {hl:TroubleTitle}document symbols{hl}{count}',
        groups = { { 'filename', format = file_icon .. '{filename}{count}' } },
        win = { size = 32 },
      },
      lsp_base = {
        groups = { { 'filename', format = file_icon .. '{filename}{count}' } },
        format = '{text:ts} {hl:TroubleSource}({item.client}){hl} {pos}',
      },
      lsp = { win = { size = { height = 16 } } },
    },
    icons = {
      indent = {
        fold_closed = icons.fold.closed,
        fold_open = icons.fold.open,
        last = icons.fold.guides.last,
      },
      kinds = kinds,
    },
  }

  for _, mode in ipairs {
    'definitions',
    'references',
    'implementations',
    'type_definitions',
    'declarations',
    'incoming_calls',
    'outgoing_calls',
  } do
    config.modes['lsp_' .. mode] = {
      title = ' {hl:TroubleTitle}' .. mode .. '{hl}{count}',
    }
  end

  trouble.setup(config)
end

return M