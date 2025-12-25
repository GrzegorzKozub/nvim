local M = {}

function M.get()
  return {
    lsp = {
      array = '󰅪',
      boolean = '󰨙',
      class = '󰠱', -- 
      color = '',
      constant = '󰏿', -- 
      constructor = '󰙴', -- 
      enum = '󱍶', --  
      enum_member = '󱍶', --  
      event = '󰛕',
      field = '󰌖', -- 
      file = '󰈤',
      folder = '󰉖',
      ['function'] = '󰊕',
      interface = '', -- 
      key = '󰌆',
      keyword = '',
      method = '󰅲', -- 
      module = '󰅴', -- 
      namespace = '󰦮', -- 
      null = '', -- 
      number = '󰎠',
      object = '󰅩',
      operator = '󰆕',
      package = '', -- 
      property = '󰓼', -- 
      reference = '󰌷', -- 
      snippet = '󰑷',
      string = '',
      struct = '󰙅', -- 
      text = '󰦨', -- 
      type_parameter = '󰅴', --  󰗴
      unit = '', -- 󰑭
      value = '󱉏', -- 
      variable = '󰀫', -- 
    },
    diag = {
      error = '', -- 󰅙 ●
      hint = '󰋼', -- ◆
      info = '󰋼', -- ◆
      warning = '', --  ▲
    },
    diff = { added = '+', modified = '~', removed = '-' },
    file = {
      dir = '󰉖',
      file = '󰈤',
      modified = '', -- ●
      readonly = '', -- ■
    },
    fold = {
      closed = '', -- ▶
      open = '', -- ▼
    },
    gitsigns = { changed = '│', git = '󰊢', staged = '┃' },
    lazy = { cmd = '', config = '', vim = '' },
    listchars = {
      eol = '󰌑', -- ¬
      tab = '󰌒 ', -- →
      trail = '•', -- ·
    },
    lualine = { separator = { left = '', right = '' } },
    qf = '󱖫',
    package = { disabled = '', enabled = '', pending = '▶' }, -- ○ 
    terminal = '',
    treesitter_context = { separator = '─' },
    truncated = '󰇘',
  }
end

return M
