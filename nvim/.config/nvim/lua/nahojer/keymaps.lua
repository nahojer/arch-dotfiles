vim.g.mapleader = ' '

vim.keymap.set({ 'n', 'v' }, 'ge', 'G')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', 'R', [["_dP]])
vim.keymap.set('x', '<leader>R', [["+p]])
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<A-d>', [["_d]])
vim.keymap.set({ 'n', 'v' }, '<A-c>', [["_c]])

-- This is going to get me cancelled.
vim.keymap.set({ 'n', 'v', 'i' }, '<C-c>', '<Esc>')
vim.keymap.set({ 'n', 'v' }, '<C-s>', ':w<CR>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set({ 'v', 'i' }, '<Up>', '<nop>')
vim.keymap.set({ 'v', 'i' }, '<Down>', '<nop>')
vim.keymap.set({ 'v', 'i' }, '<Left>', '<nop>')
vim.keymap.set({ 'v', 'i' }, '<Right>', '<nop>')

vim.keymap.set('n', '<Up>', ':resize -2<CR>')
vim.keymap.set('n', '<Down>', ':resize +2<CR>')
vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>')

vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lprev<CR>zz')

vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', '!', '!<C-g>u')
vim.keymap.set('i', '?', '?<C-g>u')
vim.keymap.set('i', ' ', ' <C-g>u')

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', 'U', '<C-R>')

vim.keymap.set('n', '<leader><leader>', function()
  vim.cmd 'so'
end)

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]
vim.keymap.set('n', '<C-q>', ':call QuickFixToggle()<CR>')

vim.keymap.set('n', '<leader>e', '<cmd>:Lexplore<CR>')
vim.keymap.set('n', '<leader>E', '<cmd>:Lexplore %:p:h<CR>')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.cmd [[
	" Saner behavior of n and N.
	" The direction of n and N depends on whether / or ? was used for searching
	" forward or backward respectively. The following makes n to always search
	" forward and N backward.
	nnoremap <expr> n  'Nn'[v:searchforward]
	xnoremap <expr> n  'Nn'[v:searchforward]
	onoremap <expr> n  'Nn'[v:searchforward]
	nnoremap <expr> N  'nN'[v:searchforward]
	xnoremap <expr> N  'nN'[v:searchforward]
	onoremap <expr> N  'nN'[v:searchforward]

	" Saner command-line history.
	" <Up> and <Down> are smarter than <C-n> and <C-p>. They recall the
	" command-line whose beginning matches the current command-line. E.g.
	" :echo <Up> may change to :echo "Vim rocks!".
  cnoremap <expr> <c-p> wildmenumode() ? "\<C-p>" : "\<Up>"
	cnoremap <expr> <c-n> wildmenumode() ? "\<C-n>" : "\<Down>"

	" Redraw window.
	" By default, <C-l> clears and redraws the screen (like :redraw!).
	" The following mapping does the same, plus de-highlighting the matches
	" found via /, ? etc., plus fixing syntax highlighting (sometimes Vim
	" loses highlighting due to complex highlighting rules), plus force
	" updating the syntax highlighting in diff mode:
	nnoremap <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>

	" Quickly edit macros.
	" Takes a register (or * by default) and opens it in the cmdline-window.
	" Hit <cr> when you're done editing for setting the register
	nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
]]
