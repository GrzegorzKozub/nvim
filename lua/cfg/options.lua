local M = {}

local function file_types()
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.config",
    callback = function()
      vim.cmd.set("filetype=xml")
    end,
  })
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.cshtml",
    callback = function()
      vim.cmd.set("filetype=html")
    end,
  })
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.csx",
    callback = function()
      vim.cmd.set("filetype=cs")
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "vim",
    callback = function()
      vim.cmd.setlocal("textwidth=0")
    end,
  })
end

local function scroll_to_last_seen_location()
  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
      vim.cmd([[
        if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
          exe "normal! g`\""
        endif
      ]])
    end,
  })
end

local function neovim()
  local options = {
    backup = true,
    cursorline = true, -- can break per https://github.com/neovim/neovim/issues/9019
    expandtab = true,
    foldlevelstart = 99,
    foldmethod = "syntax",
    ignorecase = true,
    infercase = true,
    lazyredraw = true,
    listchars = { tab = "→ ", eol = "¬", trail = "·" },
    mouse = "a",
    number = true,
    scrolloff = 3,
    shiftwidth = 2,
    showmatch = true,
    showmode = false,
    sidescrolloff = 15,
    smartcase = true,
    smartindent = true,
    softtabstop = 2,
    spelllang = { "en_gb", "pl" },
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 2,
    termguicolors = true,
    undofile = true,
    wildmode = { "longest:full", "full" },
    wildoptions = "tagfile",
    wrap = false,
  }

  for k, v in pairs(options) do
    vim.opt[k] = v
  end

  vim.opt.backupdir:remove(".")
  vim.opt.diffopt:append({ "algorithm:histogram", "indent-heuristic", "context:3" })
  vim.opt.fillchars:append({ vert = " " })
  vim.opt.shortmess:append("I")
  vim.opt.whichwrap:append("<,>,[,]")

  vim.cmd.language(vim.fn.has("win32") == 1 and "English_US" or "en_US.utf8")
end

local function plugins()
  -- netrw
  vim.g.netrw_banner = 0
  vim.g.netrw_home = vim.fn.stdpath("data") .. "/state/netrw"
  vim.g.netrw_localcopycmd = "copy"

  -- vim-hexokinase
  vim.g.Hexokinase_optInPatterns = "full_hex,tripple_hex,rgb,rgba,hsl,hsla"

  -- vimwiki

  vim.g.vimwiki_hl_cb_checked = 2
  vim.g.vimwiki_list = { { path = "~/code/apsis/", path_html = "~/Downloads/apsis_html/" } }
  vim.g.vimwiki_listsym_rejected = "✗"
  vim.g.vimwiki_listsyms = " ✓"

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.wiki",
    callback = function()
      vim.cmd.syntax({ "sync", "fromstart" })
    end,
  })

  -- vim-json
  vim.g.vim_json_syntax_conceal = 0

  -- vim-javascript
  vim.g.javascript_plugin_jsdoc = 1
  vim.g.javascript_plugin_ngdoc = 1
end

function M.init()
  neovim()
  plugins()
  file_types()
  scroll_to_last_seen_location()
end

return M
