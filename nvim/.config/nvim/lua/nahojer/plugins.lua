local plugins = {
  { 'lewis6991/gitsigns.nvim' },
  { 'akinsho/toggleterm.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    -- or, branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
  },
  { 'Shatur/neovim-ayu' },
  {
    'mcchrish/zenbones.nvim',
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = { 'rktjmp/lush.nvim' },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      local ts_update = require('nvim-treesitter.install').update { with_sync = true }
      ts_update()
    end,
  },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'nvim-treesitter/playground' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'theprimeagen/harpoon' },
  { 'mbbill/undotree' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'jay-babu/mason-null-ls.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  },
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'leoluz/nvim-dap-go' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'numToStr/Comment.nvim' },
  { 'github/copilot.vim' },
}

local opts = {}

require('lazy').setup(plugins, opts)
