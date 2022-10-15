-- encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.incsearch = true -- make search act like search in modern browsers
vim.opt.hlsearch = false -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns, unless /C or capital in search

vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again

vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window

vim.opt.swapfile = false -- living on the edge
vim.opt.undofile = true -- enable persistent undo
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.hidden = true -- allow unsaved buffers

vim.opt.timeoutlen = 200 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300 -- faster completion (4000ms default)

vim.opt.showmode = false -- we don't need to see things like -- INSERT --

vim.opt.termguicolors = true -- set term gui colors (most terminals support this)

vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

vim.opt.laststatus = 2 -- always show status line
vim.opt.cmdheight = 1
vim.opt.showcmd = true

vim.opt.scrolloff = 8 -- number of context lines above/below cursor
vim.opt.sidescrolloff = 8

vim.opt.showmatch = true -- show matching brackets when text indicator is over them

vim.opt.iskeyword:append "-" -- treat words with hyphens in them as a single word

vim.opt.belloff = "all" -- just turn the dang bell off

vim.opt.shortmess:append "c" -- don't show redundant messages from ins-completion-menu

vim.opt.fillchars.eob = " " -- fillchars for empty lines at the end of buffer

vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.cindent = true -- enables automatic C program indenting

vim.opt.tabstop = 2 -- number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent. Used for 'cindent', >>, <<, etc
vim.opt.softtabstop = 2 -- number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
vim.opt.expandtab = true -- convert tabs to spaces

vim.opt.wrap = false -- don't wrap long lines
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.showbreak = string.rep(" ", 3) -- make it so that long lines wrap smartly
vim.opt.breakindent = true
vim.opt.linebreak = true

vim.opt.foldmethod = "manual" -- folds are created manually
vim.opt.foldlevel = 0 -- close all folds
vim.opt.modelines = 1

-- set joinspaces
vim.opt.joinspaces = false -- two spaces and grade school, we're done

-- ignore patterns when searching
vim.opt.wildignore = "__pycache__"
vim.opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
vim.opt.wildignore:append "Cargo.lock"
vim.opt.wildignore:append "*/node_modules/*"

-- file explorer
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 15
vim.g.netrw_banner = 0

-- ignore compiled files
vim.opt.wildignore = "__pycache__"
vim.opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
vim.opt.wildignore:append "Cargo.lock"

-- cool floating window popup menu for completion on command line
vim.opt.pumblend = 17
vim.opt.wildmode = "longest:full"
vim.opt.wildoptions = "pum"
