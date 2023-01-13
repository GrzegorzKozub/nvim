local M = {}

local function map(keys, action, bufnr)
  vim.keymap.set('n', keys, action, { noremap = true, silent = true, buffer = bufnr })
end

local function keys()
  local bufnr = vim.fn.bufnr '%'
  map('<leader>f', function()
    vim.lsp.buf.format {
      async = true,
      bufnr = bufnr,
      filter = function(client)
        return client.name == 'null-ls'
      end,
    }
  end, bufnr)
end

local function on_attach()
  keys()
end

function M.config()
  local null_ls_loaded, null_ls = pcall(require, 'null-ls')
  if not null_ls_loaded then
    return
  end

  null_ls.setup {
    border = 'rounded',
    on_attach = on_attach,
    sources = {
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.tsc,
      null_ls.builtins.formatting.prettier.with {
        extra_args = { '--single-quote' },
      },
      null_ls.builtins.formatting.stylua,
    },
  }
end

return M
