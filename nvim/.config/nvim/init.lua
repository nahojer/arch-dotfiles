require "options"
require "commands"
require "plugin"
require "keymaps"
require "autocmds"
require "colorscheme"
require "plugin.settings.colorizer"
require "plugin.settings.marks"
require "plugin.settings.cmp"
require "plugin.settings.telescope"
require "plugin.settings.treesitter"
require "plugin.settings.autopairs"
require "plugin.settings.comment"
require "plugin.settings.lualine"
require "plugin.settings.nvim-tree"
require "plugin.settings.bufferline"
require "plugin.settings.toggleterm"
require "plugin.settings.project"
require "plugin.settings.impatient"
require "plugin.settings.illuminate"
require "plugin.settings.lsp"
require "plugin.settings.alpha"
require "plugin.settings.numb"
require "plugin.settings.matchup"
require "plugin.settings.surround"
require "plugin.settings.aerial"
require "plugin.settings.lastplace"
require "plugin.settings.whichkey"

-- Inspo:
-- https://github.com/nvim-telescope/telescope-dap.nvim and dap plugin
-- https://github.com/nvim-neo-tree/neo-tree.nvim (see https://github.com/Allaman/nvim/blob/main/lua/plugins.lua)

-- https://github.com/Allaman/nvim/blob/main/lua/plugins.lua
-- f-person/git-blame.nvim
-- https://github.com/tpope/vim-fugitive
-- folke/todo-comments.nvim
-- https://github.com/EdenEast/nightfox.nvim
-- https://github.com/mfussenegger/nvim-dap check what dap is used in lunarvim
-- for above, check out https://github.com/Allaman/nvim/blob/main/lua/plugins.lua
-- https://github.com/lukas-reineke/headlines.nvim
-- https://github.com/kevinhwang91/nvim-bqf

-- TODO:
-- * make config unbreakable with commit hash in packer use statement.
-- * tab vs spaces in Go? after/ftdetect file with config specific for go.lua?
-- * colorscheme. Backticks in markdown files in nord theme?
-- * dap debugger
-- * learn lazygit properly
-- * get typescript/react prettier/eslintd setup working
