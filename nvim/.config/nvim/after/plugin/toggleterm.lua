require('toggleterm').setup {
  open_mapping = [[<C-w>t]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  close_on_exit = true,
  direction = 'float',
  float_opts = {
    -- border = 'curved',
    winblend = 0,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
  size = 20,
  shell = vim.o.shell,
}

vim.keymap.set('t', '<esc>', '<C-\\><esc>')
vim.keymap.set({ 'n', 't' }, '<C-w>g', '<cmd>lua ToggleLazyGit()<CR>')
