local M = {}

function M.config()
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '.env',
    callback = function(args)
      vim.diagnostic.enable(false, { bufnr = args.buf })
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        function(err, result, ctx, config)
          if result.uri:sub(-4) == '.env' then
            return
          end
          vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
        {}
      )
    end,
    group = vim.api.nvim_create_augroup('Env', { clear = true }),
  })
end

return M