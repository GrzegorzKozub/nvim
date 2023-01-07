local M = {}

local function picker(title, preview)
  return {
    preview = { hide_on_startup = not preview },
    preview_title = 'preview',
    prompt_title = title,
    results_title = 'results',
  }
end

local function map(keys, action)
  vim.keymap.set('n', keys, action, { noremap = true, silent = true })
end

function M.setup()
  local loaded, plugin = pcall(require, 'telescope')
  if not loaded then
    return
  end

  plugin.setup {
    defaults = {
      prompt_prefix = ' ●• ',
      selection_caret = ' ● ',
      entry_prefix = '   ',
      multi_icon = '•',
      get_status_text = function()
        return ''
      end,
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--context=0',
      },
      color_devicons = false,
      file_ignore_patterns = { 'node_modules' },
      preview = { hide_on_startup = true },
      mappings = {
        i = { ['<c-p>'] = require('telescope.actions.layout').toggle_preview },
        n = { ['<c-p>'] = require('telescope.actions.layout').toggle_preview },
      },
    },
    pickers = {
      buffers = picker 'buffers',
      find_files = picker 'files',
      oldfiles = picker 'recent',
      live_grep = picker 'grep',
      search_history = picker 'search history',
      command_history = picker 'command history',
      quickfix = picker 'qf',
      help_tags = picker 'help',
      git_status = picker('git status', true),
      git_bcommits = picker('git file log', true),
      git_commits = picker('git log', true),
    },
  }

  local builtin = require 'telescope.builtin'

  map('<leader>fb', builtin.buffers)
  map('<c-b>', builtin.buffers)

  map('<leader>ff', builtin.find_files)
  map('<c-p>', builtin.find_files)

  map('<leader>fr', builtin.oldfiles)
  map('<c-k>', builtin.oldfiles)

  map('<leader>fg', builtin.live_grep)

  map('<leader>fs', builtin.search_history)
  map('<leader>fc', builtin.command_history)

  map('<leader>fq', builtin.quickfix)

  map('<leader>fh', builtin.help_tags)

  map('<leader>gs', builtin.git_status)
  map('<leader>gf', builtin.git_bcommits)
  map('<leader>gl', builtin.git_commits)
end

return M
