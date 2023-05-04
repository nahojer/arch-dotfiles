local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>F', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.git_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>/', function()
  builtin.grep_string { search = vim.fn.input 'Grep > ' }
end)
vim.keymap.set('n', '<leader>?', builtin.help_tags, {})

require('telescope').setup = {
  file_ignore_patterns = { '.git/', 'node_modules/', 'vendor/', '.cache/', '.vscode/', '*/tmp/*', 'Cargo.lock', '*pycache', '*.o' },
}
