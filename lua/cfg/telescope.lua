local M = {}

local function picker(title, preview)
  return {
    preview = { hide_on_startup = not preview },
    preview_title = 'preview',
    prompt_title = title,
    results_title = 'results',
  }
end

function M.config()
  local telescope_loaded, telescope = pcall(require, 'telescope')
  if not telescope_loaded then
    return
  end

  local icons = require('cfg.icons').get()

  telescope.setup {
    defaults = {
      layout_config = { height = 0.8, width = 0.8 },
      prompt_prefix = icons.telescope.prompt,
      selection_caret = icons.telescope.pointer,
      entry_prefix = '   ',
      multi_icon = icons.telescope.marker,
      get_status_text = function()
        return ''
      end,
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--column',
        '--context=0',
        '--glob=!.git/*',
        '--glob=!node_modules/*',
        '--hidden',
        '--line-number',
        '--no-heading',
        '--smart-case',
        '--with-filename',
      },
      color_devicons = false,
      file_ignore_patterns = { 'node_modules' },
      preview = { hide_on_startup = true },
      mappings = {
        i = {
          ['<c-p>'] = require('telescope.actions.layout').toggle_preview,
          ['<esc>'] = require('telescope.actions').close,
        },
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

  local nmap = require('cfg.util').nmap
  local builtin = require 'telescope.builtin'

  nmap('<c-b>', builtin.buffers)
  nmap('<c-p>', builtin.find_files)
  nmap('<c-k>', builtin.oldfiles)
  nmap('<c-g>', builtin.live_grep)
end

return M