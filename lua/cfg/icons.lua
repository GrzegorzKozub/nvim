local M = {}

function M.get()
  return {
    dev = {
      array = '󰅪',
      boolean = '󰨙',
      class = '󰠱',
      color = '',
      constant = '󰏿',
      constructor = '󰙴',
      enum = '󱍶',
      enum_member = '󱍶',
      event = '󰛕',
      field = '󰌖',
      func = '󰊕',
      interface = '',
      keyword = '󰌆',
      method = '󰅲',
      module = '󰅴',
      namespace = '󰦮',
      null = '',
      number = '󰎠',
      object = '󰅩',
      operator = '󰆕',
      package = '',
      property = '󰓼',
      reference = '󰌷',
      snippet = '󰑷',
      string = '',
      struct = '󰙅',
      text = '󰦨',
      type_parameter = '󰅴',
      unit = '󰑭',
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
      dir = '󰉖',
      file = '󰈤',
      modified = '●',
      readonly = '', -- ■
    },
    fold = {
      closed = '', -- ▶
      guides = { last = '╰╴' },
      open = '', -- ▼
    },
    gitsigns = { changed = '│', git = '󰊢', staged = '┃' },
    lazy = { cmd = '', config = '', vim = '' },
    listchars = {
      eol = '󰌑', -- ¬
      tab = '󰌒 ', -- →
      trail = '•', -- ·
    },
    qf = { list = '󱖫' },
    package = { disabled = '○', enabled = '●', pending = '▶' },
    telescope = { marker = '•', pointer = ' ● ', prompt = ' ●• ', search = '' },
    trouble = { list = '󱖫' },
  }
end

return M
