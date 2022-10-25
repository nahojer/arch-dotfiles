local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP =
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
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
  local local_use = function(plugin, opts)
    opts = opts or {}

    local plugin_path = "~/Projects/nvim-plugins/" .. plugin
    if vim.fn.isdirectory(vim.fn.expand(plugin_path)) == 1 then
      opts[1] = plugin_path
      use(opts)
    else
      print('Unable to find plugin "' .. plugin .. '"')
    end
  end

  use { "wbthomason/packer.nvim" } -- Have packer manage itself

  -- Dependencies many plugins require
  use { "nvim-lua/plenary.nvim" }
  use { "kyazdani42/nvim-web-devicons" }

  -- Treesitter based plugins
  use { "nvim-treesitter/nvim-treesitter" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" } -- comments based on cursor location
  use { "windwp/nvim-ts-autotag" } -- autoclose/autorename html tags.
  use { "lukas-reineke/indent-blankline.nvim" } -- identation guides
  use { "andymass/vim-matchup" } -- highlight, navigate, and operate on sets of matching text by extending %
  use { "windwp/nvim-autopairs" } -- autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" } -- smart comments

  -- LSP
  use { "neovim/nvim-lspconfig" } -- native
  use { "j-hui/fidget.nvim" } -- LSP progress because I'm very impatient
  use { "onsails/lspkind-nvim" } --  vscode-like pictograms to neovim built-in lsp (used in completion menu)

  -- Completion
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-nvim-lsp-document-symbol" }
  use { "tamago324/cmp-zsh" }
  use { "tzachar/cmp-tabnine", commit = "1a8fd2795e4317fd564da269cc64a2fa17ee854e", run = "./install.sh" }
  -- Snippet
  use { "saadparwaiz1/cmp_luasnip" }
  use { "L3MON4D3/LuaSnip" }
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- Debugging
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
  use { "theHamsta/nvim-dap-virtual-text" }

  -- Telescope and extensions
  use { "nvim-telescope/telescope.nvim" }
  use { "nvim-telescope/telescope-project.nvim" }
  use { "nvim-telescope/telescope-dap.nvim" }

  -- Harpoon
  use { "ThePrimeagen/harpoon" }

  -- Marks
  use { "chentoast/marks.nvim" } -- visal marks in sign column

  -- Dial
  use { "monaqa/dial.nvim" } -- Increment/decrement everything based on various type of rules

  -- Keybindings
  use { "folke/which-key.nvim" }

  -- Surround
  use { "kylechui/nvim-surround" }

  -- Colorschemes
  use { "sainnhe/gruvbox-material" }

  -- Colorizer
  use { "norcalli/nvim-colorizer.lua" } -- highlights colors (hex, rgba, etc.)

  -- Go to last insert when entering buffer.
  use { "ethanholz/nvim-lastplace" }

  -- Delete buffers without closing windows or messing up layout.
  use { "moll/vim-bbye" }

  -- Loading
  use {
    "lewis6991/impatient.nvim",
    config = function()
      require "impatient"
    end,
  }

  -- Terminal
  use { "akinsho/toggleterm.nvim" }

  -- Git
  use { "lewis6991/gitsigns.nvim" }
  use {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
    end,
  }

  -- CSV
  use { "mechatroner/rainbow_csv" }

  -- Distraction free editing
  use { "folke/zen-mode.nvim" }
  use { "folke/twilight.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
