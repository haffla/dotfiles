local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup({
  -- Seemless navigation between tmux panes and vim splits
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  "jiangmiao/auto-pairs",
  "vim-ruby/vim-ruby",
  {
    "preservim/nerdcommenter",
    config = function()
      -- Add spaces after comment delimiters by default
      vim.g.NERDSpaceDelims = 1
    end
  },
  "tpope/vim-endwise",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "tpope/vim-sleuth",
  {
    "easymotion/vim-easymotion",
    config = function()
      vim.g.EasyMotion_keys = "asdghklqwertyuiopzxcvbnmfj"
    end
  },
  "stephpy/vim-yaml",
  "airblade/vim-gitgutter",
  "AndrewRadev/splitjoin.vim",
  "nelstrom/vim-visual-star-search",
  "HerringtonDarkholme/yats.vim",
  "yuezk/vim-js",
  "maxmellon/vim-jsx-pretty",
  "alvan/vim-closetag",
  "elixir-editors/vim-elixir",
  "wellle/targets.vim",
  "luochen1990/rainbow",
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer",
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      "rafamadriz/friendly-snippets",
    }
  },
  "machakann/vim-highlightedyank",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "hashivim/vim-terraform",
  "LnL7/vim-nix",
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      --  nvim-tree.lua suggests to disable net rw plugin like this
      vim.g.loaded = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TsUpdate"

  },
  -- {
    -- "folke/tokyonight.nvim",
    -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
      -- -- load the colorscheme here
      -- vim.cmd([[colorscheme tokyonight]])
    -- end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd([[colorscheme catppuccin-frappe]])
    end
  },
  "slim-template/vim-slim",
  "ruanyl/vim-gh-line",
  "brooth/far.vim",
  "github/copilot.vim",
  "vim-test/vim-test",
  "voldikss/vim-floaterm",
  "lukas-reineke/lsp-format.nvim",
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  "fvictorio/vim-extract-variable",
  "tpope/vim-obsession",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
  }
})

require('lsp_config')
-- require('ruby_lsp_config')
require('complete')
require('tcope')
require('status_line')

vim.cmd("runtime setup.vim")
vim.cmd("runtime snip.vim")
