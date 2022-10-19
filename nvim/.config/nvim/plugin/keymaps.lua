local keymap = vim.keymap.set
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Disable key mapping to Ex mode.
keymap("n", "Q", "<NOP>", opts)

-- Increment/decrement.
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- Save with CTRL+s.
keymap("n", "<C-s>", ":w<CR>", opts)

-- Use CTRL+c as an alternative to <ESC>.
keymap("n", "<C-c>", "<ESC>", opts)

-- Better window navigation.
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows.
keymap("n", "<Up>", ":resize -2<CR>", opts)
keymap("n", "<Down>", ":resize +2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers.
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Don't yank new-line character.
keymap("n", "Y", "yg$", opts)

-- Move current line up and down.
keymap("n", "<M-j>", ":m .+1<CR>==", opts)
keymap("n", "<M-k>", ":m .-2<CR>==", opts)

-- Always center.
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

-- Quick fix list.
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cnext<CR>", opts)
keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", opts)

-- Insert --

-- Disable arrows.
keymap("i", "<Up>", "<NOP>", opts)
keymap("i", "<Down>", "<NOP>", opts)
keymap("i", "<Left>", "<NOP>", opts)
keymap("i", "<Right>", "<NOP>", opts)

-- Undo break points.
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", "!", "!<c-g>u", opts)
keymap("i", "?", "?<c-g>u", opts)
keymap("i", " ", " <c-g>u", opts)

-- Move current line up and down.
keymap("i", "<M-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<M-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Visual --

-- Stay in indent mode.
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move selected lines up and down.
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Command --

keymap("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', opts)
keymap("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', opts)

-- All --

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })
