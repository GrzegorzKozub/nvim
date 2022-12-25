local M = {}

local function bootstrap()
  local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", path })
    vim.cmd.packadd("packer.nvim")
    return true
  end
  return false
end

local function auto_commands()
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    callback = function()
      package.loaded["cfg.plugins"] = nil
      require("cfg.plugins").plugins(false)
      vim.cmd.PackerSync()
    end,
  })
end

function M.plugins(first_run)
  return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("lifepillar/vim-gruvbox8")
    use("lifepillar/vim-solarized8")

    use("itchyny/lightline.vim")
    use({ "rrethy/vim-hexokinase", run = "make hexokinase" })

    use("junegunn/fzf")
    use("junegunn/fzf.vim")

    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")

    use("jiangmiao/auto-pairs")

    use("scrooloose/nerdcommenter")
    use("editorconfig/editorconfig-vim")
    use({ "sbdchd/neoformat", cmd = "Neoformat" })

    use("w0rp/ale")

    use("vimwiki/vimwiki")

    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install_sync"]()
      end,
    })

    use("tpope/vim-git")

    use({ "elzr/vim-json", ft = { "json" } })
    use({ "stephpy/vim-yaml", ft = { "yaml", "yaml.docker-compose" } })
    use({ "ekalinin/Dockerfile.vim", ft = "Dockerfile" })
    use({ "chr4/nginx.vim", ft = { "nginx" } })

    use("moll/vim-node")

    use({ "pangloss/vim-javascript", ft = { "javascript", "javascript.jsx", "typescript" } })
    use({ "leafgarland/typescript-vim", ft = { "typescript" } })
    use({ "MaxMEllon/vim-jsx-pretty", ft = { "javascript", "javascript.jsx", "typescript" } })

    use({ "hail2u/vim-css3-syntax", ft = { "css", "less", "scss" } })

    use("fatih/vim-go")

    use({ "vim-ruby/vim-ruby", ft = "ruby" })
    use({ "tpope/vim-rails", ft = "ruby" })
    use({ "tpope/vim-endwise", ft = { "elixir", "eelixir", "ruby" } })

    use({ "elixir-editors/vim-elixir", ft = { "elixir", "eelixir" } })
    use({ "GrzegorzKozub/vim-elixirls", run = ":ElixirLsCompileSync" })

    use({ "octol/vim-cpp-enhanced-highlight", ft = { "cpp" } })

    use({ "PProvost/vim-ps1", ft = { "ps1" } })

    if first_run then
      require("packer").sync()
    end
  end)
end

function M.init()
  local first_run = bootstrap()
  auto_commands()
  M.plugins(first_run)
end

return M
