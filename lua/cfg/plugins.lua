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

      use 'junegunn/fzf'
      use 'junegunn/fzf.vim'

      use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }

      use 'tpope/vim-repeat'
      use 'tpope/vim-surround'
      use 'tpope/vim-unimpaired'

      use 'numToStr/Comment.nvim'

      use 'editorconfig/editorconfig-vim'
      use 'sbdchd/neoformat'

      use 'w0rp/ale'

      use 'vimwiki/vimwiki'

      use {
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown' },
        run = function()
          vim.fn['mkdp#util#install_sync']()
        end,
      }

      use 'tpope/vim-git'

      use { 'elzr/vim-json', ft = { 'json' } }
      use { 'stephpy/vim-yaml', ft = { 'yaml', 'yaml.docker-compose' } }
      use { 'ekalinin/Dockerfile.vim', ft = 'Dockerfile' }
      use { 'chr4/nginx.vim', ft = { 'nginx' } }

      use { 'moll/vim-node', ft = { 'javascript', 'typescript' } }

      use { 'pangloss/vim-javascript', ft = { 'javascript', 'javascript.jsx', 'typescript' } }
      use { 'leafgarland/typescript-vim', ft = { 'typescript' } }
      use { 'MaxMEllon/vim-jsx-pretty', ft = { 'javascript', 'javascript.jsx', 'typescript' } }

      use { 'hail2u/vim-css3-syntax', ft = { 'css', 'less', 'scss' } }

      use {
        'fatih/vim-go',
        cmd = { 'GoInstallBinaries', 'GoUpdateBinaries' },
        ft = { 'go' },
      }

      use { 'vim-ruby/vim-ruby', ft = 'ruby' }
      use { 'tpope/vim-rails', ft = 'ruby' }
      use { 'tpope/vim-endwise', ft = { 'elixir', 'eelixir', 'ruby' } }

      use { 'elixir-editors/vim-elixir', ft = { 'elixir', 'eelixir' } }
      use {
        'GrzegorzKozub/vim-elixirls',
        ft = { 'elixir', 'eelixir' },
        run = ':ElixirLsCompileSync',
      }

      use { 'octol/vim-cpp-enhanced-highlight', ft = { 'cpp' } }

      use { 'PProvost/vim-ps1', ft = { 'ps1' } }

      use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
          require('nvim-treesitter.install').update { with_sync = true }()
        end,
      }

      if first_run then
        require('packer').sync()
      end
    end,
    config = {
      display = {
        header_sym = '',
        prompt_border = 'rounded',
        open_fn = function()
          return require('packer.util').float { border = 'rounded' }
        end,
      },
    },
  }
end

function M.setup()
  local first_run = bootstrap()
  auto_update()
  M.plugins(first_run)
end

return M
