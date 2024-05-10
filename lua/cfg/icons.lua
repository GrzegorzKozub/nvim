local M = {}

function M.get()
  return {
    cmp = {
      class = '󰠱',
      color = '',
      constant = '󰏿',
      constructor = '󰙴',
      enum = '󱍶',
      enum_member = '󱍶',
      event = '󰛕',
      field = '󰌖',
      file = '󰈤',
      folder = '󰉖',
      func = '󰊕',
      interface = '',
      keyword = '󰌆',
      method = '󰅲',
      module = '󰅩',
      operator = '󰆕',
      property = '󰓼',
      reference = '󰌷',
      snippet = '󰑷',
      struct = '󰙅',
      text = '󰦨',
      type_parameter = '󰅴',
      unit = '󰑭',
      value = '󰎠',
      variable = '󰀫',
    },
    diag = {
      error = '󰅙', -- ●
      hint = '󰋼', -- ◆
      info = '󰋼', -- ◆
      warning = '', -- ▲
    },
    diff = { added = '+', modified = '~', removed = '-' },
    file = {
      modified = '●',
      readonly = '', -- ■
    },
    fold = {
      closed = '', -- ▶
      open = '', -- ▼
    },
    lazy = { cmd = '', config = '', vim = '' },
    listchars = {
      eol = '󰌑', -- ¬
      tab = '󰌒 ', -- →
      trail = '•', -- ·
    },
    package = { disabled = '○', enabled = '●', pending = '▶' },
    telescope = { marker = '•', pointer = ' ● ', prompt = ' ●• ' },
  }
end

return M