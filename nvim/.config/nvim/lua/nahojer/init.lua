local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'nahojer.options'
require 'nahojer.keymaps'
require 'nahojer.plugins'

function R(name)
  require('plenary.reload').reload_module(name)
end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local NahojerGroup = augroup('nahojer', {})
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

autocmd({ 'BufWritePre' }, {
  group = NahojerGroup,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

vim.g.netrw_keepdir = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

autocmd({ 'filetype' }, {
  group = NahojerGroup,
  pattern = { 'netrw' },
  desc = 'Cosier mappings for netrw',
  callback = function()
    local bind = function(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
    end

    bind('H', 'u') -- "go back" in history
    bind('h', '-^') -- "go up" a directory
    bind('l', '<CR>') -- open direcorty or file
    bind('L', '<CR>:Lexplore<CR>') -- Open file and close Netrw
    bind('.', 'gh') -- toggle dotfiles
    bind('P', '<C-w>z') -- close preview window (opened with "p")
    bind('r', 'R') -- Rename file

    -- Useful key maps we didn't bind to anything else.
    -- % Let's you create a new a file in cwd.
    -- d Creates a directory.
    -- D Deletes file or empty directory
    -- mt Assign the "target directory" used by the move and copy commands.
    -- mf Marks a file or directory.
    -- mc Copy the marked files in the target directory.
    -- mm Move the marked files to the target directory.
    -- mx Runs an external command on the marked files.
    -- I to toggle banner
    -- s to change sort mode
  end,
})

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

function ToggleLazyGit()
  lazygit:toggle()
end
