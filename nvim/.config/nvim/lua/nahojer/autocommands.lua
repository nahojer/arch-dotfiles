-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "filetype" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- Fix format options
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    --[[
      - "a" -- Auto formatting is BAD.
      - "t" -- Don't auto format my code. I got linters for that.
      + "c" -- In general, I like it when comments respect textwidth
      + "q" -- Allow formatting comments w/ gq
      - "o" -- O and o, don't continue comments
      + "r" -- But do continue when pressing enter.
      + "n" -- Indent past the formatlistpat, not underneath it.
      + "j" -- Auto-remove comments if possible.
      - "2" -- I'm not in gradeschool anymore
    --]]
    vim.opt.formatoptions = vim.opt.formatoptions - { "a", "t", "o", "2" }
  end,
})

-- Add keymappings in netrw
vim.api.nvim_create_autocmd({ "filetype" }, {
  pattern = { "netrw" },
  desc = "Cosier mappings for netrw",
  callback = function()
    local bind = function(lhs, rhs)
      vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
    end

    bind("H", "u") -- "go back" in history
    bind("h", "-^") -- "go up" a directory
    bind("l", "<CR>") -- open direcorty or file
    bind(".", "gh") -- toggle dotfiles
    bind("P", "<C-w>z") -- close preview window
    bind("L", "<CR>:Lexplore<CR>") -- Open file and close Netrw
    bind("r", "R") -- Rename file
  end,
})
