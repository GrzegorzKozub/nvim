local M = {}

function M.config()
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.env',
    callback = function(args)
      vim.diagnostic.enable(false, { bufnr = args.buf })
      vim.lsp.handlers['textDocument/publishDiagnostics'] = function(err, result, ...)
        if result.uri:sub(-4) == '.env' then
          return nil
        end
        return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ...)
      end
    end,
    group = vim.api.nvim_create_augroup('Env', { clear = true }),
  })
end

return M
