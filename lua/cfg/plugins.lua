local M = {}

local function bootstrap()
  local path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', path }
    vim.cmd.packadd 'packer.nvim'
    return true
  end
  return false
end

local function auto_update()
  local group = vim.api.nvim_create_augroup('PluginsAutoUpdate', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = 'plugins.lua',
    callback = function()
      package.loaded['cfg.plugins'] = nil
      require('cfg.plugins').plugins(false)
      vim.cmd.PackerSync()
    end,
    group = group,
  })
end

function M.plugins(first_run)
  return require('packer').startup {
    function(use)
      use 'wbthomason/packer.nvim'

      use 'sainnhe/gruvbox-material'

      use 'nvim-lualine/lualine.nvim'
      use 'lewis6991/gitsigns.nvim'
      use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }

      use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }

      use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jayp0521/mason-null-ls.nvim',
        'RubixDev/mason-update-all',
      }
      use {
        'folke/neodev.nvim',
        'neovim/nvim-lspconfig',
      }
      use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
      }
      use {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
      }
      use { 'jose-elias-alvarez/null-ls.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }

      use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
          require('nvim-treesitter.install').update { with_sync = true }()
        end,
      }

      use 'RRethy/vim-illuminate'

      use 'folke/trouble.nvim'

      use 'tpope/vim-repeat'
      use 'tpope/vim-surround'
      use 'tpope/vim-unimpaired'

      use 'numToStr/Comment.nvim'

      use 'vimwiki/vimwiki'

      use {
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown' },
        run = function()
          vim.fn['mkdp#util#install_sync']()
        end,
      }

      if first_run then
        require('packer').sync()
      end
    end,
    config = {
      display = {
        working_sym = '↺',
        error_sym = '✕',
        done_sym = '✓',
        remved_sym = '✕',
        moved_sym = '→',
        header_sym = '',
        prompt_border = 'rounded',
        open_fn = function()
          return require('packer.util').float { border = 'rounded' }
        end,
      },
    },
  }
end

function M.config()
  local first_run = bootstrap()
  auto_update()
  M.plugins(first_run)
end

return M
