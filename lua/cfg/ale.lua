local M = {}

local function auto_commands()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "elixir,eelixir",
    callback = function()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<Leader>f", ":ALEFix<CR>", opts)
      vim.api.nvim_set_keymap("n", "<C-]>", ":ALEGoToDefinition<CR>", opts)
      vim.api.nvim_set_keymap("n", "<C-\\>", ":ALEFindReferences<CR>", opts)
    end,
  })
end

local function options()
  vim.g.ale_completion_enabled = 0
  vim.g.ale_lint_on_enter = 0

  vim.g.ale_sign_error = "●"
  vim.g.ale_sign_warning = "▲"

  vim.g.ale_fixers = vim.empty_dict()
  vim.g.ale_linters = vim.empty_dict()

  vim.g.ale_linters.json = { "jq" }
  vim.g.ale_linters.yaml = { "yamllint" }

  -- elixir
  vim.g.ale_elixir_elixir_ls_config = { elixirLS = { dialyzerEnabled = false } }
  vim.g.ale_elixir_elixir_ls_release = vim.fn.stdpath("data") .. "/plugins/vim-elixirls/elixir-ls/release"
  vim.g.ale_fixers.elixir = { "mix_format" }
  vim.g.ale_linters.elixir = { "elixir-ls" }
end

function M.init()
  auto_commands()
  options()
end

return M
