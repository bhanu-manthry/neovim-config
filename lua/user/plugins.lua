local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- colorschemes
  use "LunarVim/Colorschemes"

  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  }

  use {
    "akinsho/bufferline.nvim",
    requires = "nvim-tree/nvim-web-devicons"
  }

  use "akinsho/toggleterm.nvim"

  use {
    "kylechui/nvim-surround",
    requires = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("nvim-surround").setup()
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }

  use {
    "nvim-treesitter/nvim-treesitter-refactor",
    requires = "nvim-treesitter/nvim-treesitter"
  }

  use "neovim/nvim-lspconfig"
  use "nvim-lualine/lualine.nvim"
  use "numToStr/Comment.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0"
  }
  use "windwp/nvim-autopairs"
  use {
    "windwp/nvim-ts-autotag",
    requires = {
      "nvim-treesitter/nvim-treesitter"
    },
  }
  use {
    'lewis6991/gitsigns.nvim',
  }

  use "hrsh7th/nvim-cmp" -- completion
  use "hrsh7th/cmp-nvim-lsp" -- nvim-cmp source for neovim's built-in lsp
  use "hrsh7th/cmp-buffer" -- nvim-cmp source for buffer words
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"
  use "hrsh7th/cmp-nvim-lua"

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
