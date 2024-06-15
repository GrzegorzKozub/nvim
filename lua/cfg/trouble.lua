local M = {}

function M.config()
  local trouble_loaded, trouble = pcall(require, 'trouble')
  if not trouble_loaded then
    return
  end

  local icons = require('cfg.icons').get()

  trouble.setup {
    modes = {
      diagnostics = {
        groups = {
          { 'directory', format = ' {directory_icon}{directory} {count}' },
          { 'filename', format = '{hl:TroubleIconFile}{file_icon}{hl}{basename} {count}' },
        },
        format = '{severity_icon} {message:md} {item.source} '
          .. '{hl:TroubleSource}({hl}{code}{hl:TroubleSource}){hl} {pos}',
        win = { size = { height = 16 } },
      },
      lsp_document_symbols = {
        title = ' {hl:TroubleTitle}symbols{hl} {count}',
        groups = { { 'filename', format = '{hl:TroubleIconFile}{file_icon}{hl}{filename} {count}' } },
        format = '{kind_icon}{symbol.name} {text:Comment} {pos}',
        win = { size = 32 },
      },
      lsp_base = {
        groups = { { 'filename', format = '{hl:TroubleIconFile}{file_icon}{hl}{filename} {count}' } },
        format = '{text:ts} {hl:TroubleSource}({item.client}){hl} {pos}',
      },
      lsp_definitions = { title = ' {hl:TroubleTitle}definitions{hl} {count}' },
      lsp_references = { title = ' {hl:TroubleTitle}references{hl} {count}' },
      lsp_implementations = { title = ' {hl:TroubleTitle}implementations{hl} {count}' },
      lsp_type_definitions = { title = ' {hl:TroubleTitle}type definitions{hl} {count}' },
      lsp_declarations = { title = ' {hl:TroubleTitle}declarations{hl} {count}' },
      lsp_incoming_calls = { title = ' {hl:TroubleTitle}incoming calls{hl} {count}' },
      lsp_outgoing_calls = { title = ' {hl:TroubleTitle}outgoing calls{hl} {count}' },
      lsp = { win = { size = { height = 16 } } },
    },
    icons = {
      indent = {
        fold_closed = icons.fold.closed,
        fold_open = icons.fold.open,
        last = icons.fold.guides.last,
      },
      kinds = {
        Array = icons.dev.array .. ' ',
        Boolean = icons.dev.boolean .. ' ',
        Class = icons.dev.class .. ' ',
        Constant = icons.dev.constant .. ' ',
        Constructor = icons.dev.constructor .. ' ',
        Enum = icons.dev.enum .. ' ',
        EnumMember = icons.dev.enum_member .. ' ',
        Event = icons.dev.event .. ' ',
        Field = icons.dev.field .. ' ',
        File = icons.file.file .. ' ',
        Function = icons.dev.func .. ' ',
        Interface = icons.dev.interface .. ' ',
        Key = icons.dev.keyword .. ' ',
        Method = icons.dev.method .. ' ',
        Module = icons.dev.module .. ' ',
        Namespace = icons.dev.namespace .. ' ',
        Null = icons.dev.null .. ' ',
        Number = icons.dev.number .. ' ',
        Object = icons.dev.object .. ' ',
        Operator = icons.dev.operator .. ' ',
        Package = icons.dev.package .. ' ',
        Property = icons.dev.property .. ' ',
        String = icons.dev.string .. ' ',
        Struct = icons.dev.struct .. ' ',
        TypeParameter = icons.dev.type_parameter .. ' ',
        Variable = icons.dev.variable .. ' ',
      },
    },
  }
end

return M
