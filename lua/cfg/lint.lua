local M = {}

local linters = {
  go = { 'golangcilint' },
  javascript = { 'eslint_d' },
  json = { 'jsonlint' },
  lua = { 'luacheck' },
  python = { 'ruff' },
  -- rust = { 'clippy' }, -- handled by rust-analyzer
  -- sh = { 'shellcheck' }, -- handled by bashls
  typescript = { 'eslint_d' },
  yaml = { 'yamllint' },
}

if vim.fn.has 'win32' == 0 then
  linters.dockerfile = { 'hadolint' }
  linters.terraform = { 'tflint' }
  linters['yaml.ansible'] = { 'ansible_lint' }
  linters.zsh = { 'zsh-lint' }
end

local function zsh_lint(lint)
  if vim.fn.has 'win32' == 1 then
    return
  end
  local severity = {
    error = vim.diagnostic.severity.ERROR,
    warning = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    hint = vim.diagnostic.severity.HINT,
  }
  local function find_config()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == '' then
      return nil
    end
    local found = vim.fs.find('zsh-lint.json', {
      path = vim.fs.dirname(bufname),
      stop = vim.uv.os_homedir(),
      upward = true,
    })[1]
    return found
  end
  -- find_config & linters['zsh-lint'] as function instead of table are needed while
  -- https://github.com/z-shell/zsh-lint/issues/198 is fixed
  lint.linters['zsh-lint'] = function()
    local args = { '--format=json' }
    local config = find_config()
    if config then
      vim.list_extend(args, { '--config', config })
    end
    return {
      cmd = 'zsh-lint',
      args = args,
      stdin = false,
      ignore_exitcode = true,
      parser = function(output)
        local diagnostics = {}
        local ok, decoded = pcall(vim.json.decode, output)
        if not ok or not decoded.diagnostics then
          return diagnostics
        end
        for _, d in ipairs(decoded.diagnostics) do
          table.insert(diagnostics, {
            severity = severity[d.severity],
            source = 'zsh-lint',
            lnum = d.range.start.line - 1,
            col = d.range.start.column - 1,
            end_lnum = d.range['end'].line - 1,
            end_col = d.range['end'].column - 1,
            message = d.message,
            code = d.rule,
          })
        end
        return diagnostics
      end,
    }
  end
end

function M.config()
  local lint_loaded, lint = pcall(require, 'lint')
  if not lint_loaded then
    return
  end

  zsh_lint(lint)

  lint.linters_by_ft = linters

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
    pattern = '*',
    callback = function()
      lint.try_lint()
    end,
    group = vim.api.nvim_create_augroup('Lint', { clear = true }),
  })
end

return M
