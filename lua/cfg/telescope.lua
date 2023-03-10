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

  telescope.setup {
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

  local nmap = require('cfg.util').nmap
  local builtin = require 'telescope.builtin'

  nmap('<leader>fb', builtin.buffers)
  nmap('<c-b>', builtin.buffers)

  nmap('<leader>ff', builtin.find_files)
  nmap('<c-p>', builtin.find_files)

  nmap('<leader>fr', builtin.oldfiles)
  nmap('<c-k>', builtin.oldfiles)

  nmap('<leader>fg', builtin.live_grep)

  nmap('<leader>fs', builtin.search_history)
  nmap('<leader>fc', builtin.command_history)

  nmap('<leader>fq', builtin.quickfix)

  nmap('<leader>fh', builtin.help_tags)

  nmap('<leader>gs', builtin.git_status)
  nmap('<leader>gf', builtin.git_bcommits)
  nmap('<leader>gl', builtin.git_commits)
end

return M
