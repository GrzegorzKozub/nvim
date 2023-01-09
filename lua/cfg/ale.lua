local M = {}

-- local function map(keys, action)
--   vim.keymap.set('n', keys, action, { noremap = true, silent = true })
-- end

function M.config()
  vim.g.ale_completion_enabled = 0
  vim.g.ale_lint_on_enter = 0

  vim.g.ale_set_loclist = 0
  vim.g.ale_set_quickfix = 1
  vim.g.ale_virtualtext_prefix = '' -- '%comment% '

  vim.g.ale_sign_error = '●'
  vim.g.ale_sign_warning = '▲'
  vim.g.ale_sign_info = '◆'

  vim.g.ale_fixers = vim.empty_dict()
  vim.g.ale_linters = vim.empty_dict()

  vim.g.ale_linters.json = { 'jq' }
  vim.g.ale_linters.yaml = { 'yamllint' }

  vim.g.ale_elixir_elixir_ls_config = { elixirLS = { dialyzerEnabled = false } }
  vim.g.ale_elixir_elixir_ls_release = vim.fn.stdpath 'data' .. '/plugins/vim-elixirls/elixir-ls/release'
  vim.g.ale_fixers.elixir = { 'mix_format' }
  vim.g.ale_linters.elixir = { 'elixir-ls' }

  -- map(']d', ':ALENext<cr>')
  -- map('[d', ':ALEPrevious<cr>')
end

return M
