local M = {}

local function on_attach(client, bufnr)
  if client.name == 'null-ls' and vim.o.filetype == 'xml' then
    require('cfg.util').nmap('<leader>f', function()
      vim.lsp.buf.format { async = true, bufnr = bufnr }
    end, bufnr)
  end
end

local function sources(null_ls)
  local sources = {
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
  }
  if vim.fn.has 'win32' == 0 then
    for _, source in ipairs {
      -- null_ls.builtins.diagnostics.cfn_lint,
      -- null_ls.builtins.diagnostics.credo,
      -- null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.jsonlint,
      null_ls.builtins.formatting.prettier.with {
        disabled_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        extra_args = { '--single-quote' },
      },
      -- null_ls.builtins.diagnostics.vint,
      null_ls.builtins.diagnostics.yamllint,
      -- null_ls.builtins.formatting.taplo,
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