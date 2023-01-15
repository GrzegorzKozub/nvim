local M = {}

local function on_attach()
  ---@diagnostic disable-next-line: param-type-mismatch
  local bufnr = vim.fn.bufnr '%'
  require('cfg.util').nmap('<leader>f', function()
    vim.lsp.buf.format { async = true, bufnr = bufnr }
  end, bufnr)
end

local function sources(null_ls)
  local sources = {
    null_ls.builtins.formatting.stylua,
  }
  if vim.fn.has 'win32' == 0 then
    for _, source in ipairs {
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.diagnostics.cfn_lint,
      null_ls.builtins.diagnostics.credo,
      null_ls.builtins.diagnostics.editorconfig_checker,
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.jsonlint,
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.formatting.prettier.with {
        disabled_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        extra_args = { '--single-quote' },
      },
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.diagnostics.vint,
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.formatting.autopep8,
      null_ls.builtins.formatting.xmllint,
    } do
      table.insert(sources, source)
    end
  end
  return sources
end

function M.config()
  local null_ls_loaded, null_ls = pcall(require, 'null-ls')
  if not null_ls_loaded then
    return
  end

  null_ls.setup {
    border = 'rounded',
    on_attach = on_attach,
    sources = sources(null_ls),
  }
end

return M
