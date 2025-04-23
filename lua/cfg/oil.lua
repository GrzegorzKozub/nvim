local M = {}

function M.config()
  local oil_loaded, oil = pcall(require, 'oil')
  if not oil_loaded then
    return
  end

  -- todo: icons, lualine, highlights, keys, trash test

  ---@module 'oil'
  ---@type oil.SetupOpts
  oil.setup {
    columns = {
      { 'icon', directory = '󰝰', default_file = '󰈤' },
      { 'permissions', highlight = 'Grey' },
    },
    delete_to_trash = true,
    keymaps = {
      -- cd (changes vim cwd), copy, paste, preview scroll, toggle trash (shows deleted in cwd)
      ['<CR>'] = 'actions.select',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = { 'actions.close', mode = 'n' },
      ['<C-l>'] = 'actions.refresh',
      ['-'] = { 'actions.parent', mode = 'n' },
      ['_'] = { 'actions.open_cwd', mode = 'n' },
      ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
    },
    use_default_keymaps = false,
    view_options = { show_hidden = true },
    float = {
      max_width = 0.8,
      max_height = 0.8,
      get_win_title = function()
        return ''
      end,
      preview_split = 'above',
    },

    -- continue from confirmation
  }

  local nmap = require('cfg.util').nmap
  nmap('<c-e>', oil.open)
  nmap('<c-s-e>', oil.toggle_float)
end

return M
