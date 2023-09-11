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
  return require('lazy').setup {
    { 'sainnhe/gruvbox-material', priority = 51 },
    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    'lewis6991/gitsigns.nvim',
    'folke/trouble.nvim',
    { 'nvim-lualine/lualine.nvim', priority = 52 },

    'numToStr/Comment.nvim',
    'kylechui/nvim-surround',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'RRethy/vim-illuminate',
    { 'rrethy/vim-hexokinase', build = 'make hexokinase' },

    'williamboman/mason.nvim',
    'RubixDev/mason-update-all',

    'folke/neodev.nvim',

    'neovim/nvim-lspconfig',

    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
      },
      config = require('cfg.cmp').config
    },

    { 'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    'williamboman/mason-lspconfig.nvim',
    'jay-babu/mason-null-ls.nvim',

    'vimwiki/vimwiki',
    {
      'iamcco/markdown-preview.nvim',
      ft = { 'markdown' },
      build = function()
        vim.fn['mkdp#util#install_sync']()
      end,
    },
  }

  --       working_sym = '▷',
  --       error_sym = '!',
  --       done_sym = '✓',
  --       removed_sym = '×',
  --       moved_sym = '→',
  --       header_sym = '',
  --       prompt_border = 'rounded',
  --       open_fn = function()
  --         return require('packer.util').float { border = 'rounded' }
  --       end,
end

function M.config()
  bootstrap()
  M.plugins()
end

return M