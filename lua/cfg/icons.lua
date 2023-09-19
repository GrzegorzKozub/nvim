local M = {}

function M.get()
  return {
    diag = {
      error = '󰅙 ', -- ●
      hint = '󰋼 ', -- ◆
      info = '󰋼 ', -- ◆
      warning = ' ', -- ▲
    },
    diff = {
      added = '󰐕 ', -- +
      modified = '󰜥 ', -- ~
      removed = '󰍴 ', -- -
    },
    file = {
      modified = '●',
      readonly = '', -- ■
    },
    fold = {
      closed = '', -- ▶
      open = '', -- ▼
    },
    lazy = { cmd = ' ', config = ' ', vim = ' ' },
    listchars = {
      eol = '󰌑', -- ¬
      tab = '󰌒 ', -- →
      trail = '󰧟', -- ·
    },
    package = { disabled = '○', enabled = '●', pending = '▶' },
    telescope = { marker = '•', pointer = ' ● ', prompt = ' ●• ' },
  }
end

return M