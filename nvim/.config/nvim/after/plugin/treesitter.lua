require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { 'vimdoc', 'javascript', 'typescript', 'c', 'lua', 'rust', 'go', 'gomod', 'gosum', 'gowork' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('nvim-treesitter.configs').setup {
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']k'] = '@class.outer',
        [']c'] = '@comment.outer',
        [']l'] = '@loop.outer',
        [']a'] = '@parameter.outer',
        [']i'] = '@call.outer', -- read "invoke"
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']K'] = '@class.outer',
        [']C'] = '@comment.outer',
        [']L'] = '@loop.outer',
        [']A'] = '@parameter.outer',
        [']I'] = '@call.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[k'] = '@class.outer',
        ['[c'] = '@comment.outer',
        ['[l'] = '@loop.outer',
        ['[a'] = '@parameter.outer',
        ['[i'] = '@call.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[K'] = '@class.outer',
        ['[C'] = '@comment.outer',
        ['[L'] = '@loop.outer',
        ['[A'] = '@parameter.outer',
        ['[I'] = '@call.outer',
      },
    },
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ak'] = '@class.outer',
        ['ik'] = '@class.inner',
        ['ac'] = '@comment.outer',
        ['ic'] = '@comment.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['ai'] = '@call.outer',
        ['ii'] = '@call.inner',
      },
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>za'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>zA'] = '@parameter.inner',
      },
    },
  },
}

local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
