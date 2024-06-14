local M = {}

function M.config()
  local trouble_loaded, trouble = pcall(require, 'trouble')
  if not trouble_loaded then
    return
  end

  local icons = require('cfg.icons').get()

  trouble.setup {
    indent_guides = true,
    modes = {
      diagnostics = {
        groups = {
          { 'directory', format = ' {directory_icon}{directory} {count}' },
          {
            'filename',
            format = '{hl:TroubleIconFile}{file_icon}{hl}{hl:TroubleFileName}{basename}{hl} {count}',
          },
        },
        format = '{severity_icon} {message:md} {item.source} '
          .. '{hl:TroubleSource}({hl}{code}{hl:TroubleSource}){hl} {pos}',
      },
      lsp_document_symbols = {
        title = " {hl:Title}Symbols{hl} {count}",
        groups = {
          { 'filename', format = '{hl:TroubleIconFile}{file_icon}{hl}{filename} {count}' },
        },
        format = "{kind_icon}{symbol.name} {text:Comment} {pos}",
        win = { size = 33 },
      },
    },
    icons = {
      indent = {
        fold_closed = icons.fold.closed,
        fold_open = icons.fold.open,
        last = icons.fold.guides.last,
      },
    },
  }
end

return M
