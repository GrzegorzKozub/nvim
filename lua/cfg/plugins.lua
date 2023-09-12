local M = {}

local function bootstrap()
  local path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(path) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      -- '--branch=stable',
      'https://github.com/folke/lazy.nvim.git',
      path,
    }
  end
  vim.opt.runtimepath:prepend(path)
end

function M.plugins()
  return require('lazy').setup({
    { 'sainnhe/gruvbox-material', priority = 51 },

    {
      'nvim-telescope/telescope.nvim',
      config = require('cfg.telescope').config,
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = { '<c-b>', '<c-k>', '<c-p>' },
    },

    {
      'lewis6991/gitsigns.nvim',
      config = require('cfg.gitsigns').config,
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'folke/trouble.nvim',
      config = require('cfg.trouble').config,
      keys = '<leader>t',
    },

    { 'nvim-lualine/lualine.nvim', priority = 52 },

    {
      'numToStr/Comment.nvim',
      config = require('cfg.comment').config,
      keys = { { 'gbc' }, { 'gcc' }, { 'gb', mode = 'v' }, { 'gc', mode = 'v' } },
    },

    {
      'kylechui/nvim-surround',
      config = require('cfg.surround').config,
      keys = { 'cs', 'ds', 'ys' },
    },

    { 'tpope/vim-repeat', keys = '.' },
    { 'tpope/vim-unimpaired', keys = { '[', ']' } },

    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      cmd = 'TSUpdateSync',
      config = require('cfg.treesitter').config,
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'RRethy/vim-illuminate',
      config = require('cfg.illuminate').config,
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'rrethy/vim-hexokinase',
      build = 'make hexokinase',
      config = require('cfg.hexokinase').config,
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'williamboman/mason.nvim',
      cmd = 'Mason',
      config = require('cfg.mason').config,
    },

    {
      'RubixDev/mason-update-all',
      cmd = 'MasonUpdateAll',
      config = require('cfg.mason-update-all').config,
    },

    {
      'folke/neodev.nvim',
      config = require('cfg.neodev').config,
      ft = 'lua',
    },

    {
      'neovim/nvim-lspconfig',
      config = require('cfg.nvim-lspconfig').config,
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'hrsh7th/nvim-cmp',
      event = { 'CmdlineEnter', 'InsertEnter' },
      dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
      },
      config = require('cfg.cmp').config,
    },

    {
      'jose-elias-alvarez/null-ls.nvim',
      config = require('cfg.null-ls').config,
      dependencies = { 'nvim-lua/plenary.nvim' },
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'williamboman/mason-lspconfig.nvim',
      config = require('cfg.mason-lspconfig').config,
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'jay-babu/mason-null-ls.nvim',
      config = require('cfg.mason-null-ls').config,
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'vimwiki/vimwiki',
      config = require('cfg.vimwiki').config,
      event = { 'BufNewFile', 'BufReadPre' },
    },

    {
      'iamcco/markdown-preview.nvim',
      build = function()
        vim.fn['mkdp#util#install_sync']()
      end,
      config = require('cfg.markdown-preview').config,
      ft = 'markdown',
    },
  }, {
    ui = {
      border = 'rounded',
      icons = {
        cmd = ' ',
        config = ' ',
        event = '',
        ft = ' ',
        init = ' ',
        import = ' ',
        keys = ' ',
        lazy = '󰒲 ',
        loaded = '●',
        not_loaded = '○',
        plugin = ' ',
        runtime = ' ',
        source = ' ',
        start = '',
        task = ' ',
        list = { '● ', '➜ ', '★ ', '- ' },
      },
    },
  })
end

function M.config()
  bootstrap()
  M.plugins()
end

return M