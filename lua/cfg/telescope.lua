local M = {}

local function picker(title, preview)
  return {
    preview = { hide_on_startup = not preview },
    preview_title = 'preview',
    prompt_title = title,
  }
end

function M.config()
  local telescope_loaded, telescope = pcall(require, 'telescope')
  if not telescope_loaded then
    return
  end

  local icons = require('cfg.icons').get()

  local actions = require 'telescope.actions'
  local actions_layout = require 'telescope.actions.layout'

  telescope.setup {
    defaults = {
      layout_strategy = 'vertical',
      layout_config = { height = 0.8, width = 0.8 },
      prompt_prefix = icons.telescope.prompt,
      selection_caret = icons.telescope.pointer,
      entry_prefix = '   ',
      multi_icon = icons.telescope.marker,
      get_status_text = function()
        return ''
      end,
      results_title = 'results',
      preview = { hide_on_startup = true },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--trim',
        -- reset options set in ripgreprc for telescope compatibility
        '--context=0',
        '--field-match-separator=:',
      },
      color_devicons = false,
      file_ignore_patterns = { 'node_modules' },
      mappings = {
        i = {
          ['<c-l>'] = actions_layout.cycle_layout_next,
          ['<c-p>'] = actions_layout.toggle_preview,
          ['<esc>'] = actions.close,
        },
        n = {
          ['<c-l>'] = actions_layout.cycle_layout_next,
          ['<c-p>'] = actions_layout.toggle_preview,
        },
      },
    },
    pickers = {
      -- frequent
      buffers = picker 'buffers',
      find_files = picker 'files',
      live_grep = picker 'grep',
      oldfiles = picker 'recent',
      -- vim
      command_history = picker 'command history',
      highlights = picker 'highlights',
      quickfix = picker 'qf',
      search_history = picker 'search history',
      vim_options = picker 'options',
      -- doc
      help_tags = picker('help', true),
      man_pages = picker('man', true),
      -- lsp
      diagnostics = picker 'diagnostics',
      lsp_definitions = picker 'definitions',
      lsp_document_symbols = picker 'document symbols',
      lsp_dynamic_workspace_symbols = picker 'dynamic workspace symbols',
      lsp_implementations = picker 'implementations',
      lsp_incoming_calls = picker 'incoming calls',
      lsp_outgoing_calls = picker 'outgoing calls',
      lsp_references = picker 'references',
      lsp_type_definitions = picker 'type definitions',
      lsp_workspace_symbols = picker 'workspace symbols',
      -- git
      git_bcommits = picker('git file log', true),
      git_commits = picker('git log', true),
      git_status = picker('git status', true),
    },
  }

  local nmap = require('cfg.util').nmap
  local builtin = require 'telescope.builtin'

  nmap('<c-b>', builtin.buffers)
  nmap('<c-g>', builtin.live_grep)
  nmap('<c-k>', builtin.oldfiles)
  nmap('<c-p>', builtin.find_files)
end

return M
