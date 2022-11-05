local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local toggle = require "nahojer.toggle"

wk.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
    spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local nmappings = {
  ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
  [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
  ["e"] = { "<cmd>:Lexplore<CR>", "Explorer (cwd)" },
  ["E"] = { "<cmd>:Lexplore %:p:h<CR>", "Explorer" },
  ["y"] = { '"+y', "Yank motion" },
  ["Y"] = { '"+yg$', "Yank" },
  ["q"] = {
    name = "+Quit",
    q = { "<cmd>:qa<CR>", "Quit" },
    ["!"] = { "<cmd>:qa!<CR>", "Quit without saving" },
  },
  ["H"] = {
    name = "+Help",
    t = { "<cmd>:Telescope builtin<CR>", "Telescope" },
    c = { "<cmd>:Telescope commands<CR>", "Commands" },
    h = { "<cmd>:Telescope help_tags<CR>", "Help Pages" },
    m = { "<cmd>:Telescope man_pages<CR>", "Man Pages" },
    k = { "<cmd>:Telescope keymaps<CR>", "Key Maps" },
    s = { "<cmd>:Telescope highlights<CR>", "Search Highlight Groups" },
    f = { "<cmd>:Telescope filetypes<CR>", "File Types" },
    o = { "<cmd>:Telescope vim_options<CR>", "Options" },
    a = { "<cmd>:Telescope autocommands<CR>", "Auto Commands" },
  },
  ["s"] = {
    name = "+Search",
    p = { ":lua require('telescope').extensions.project.project{}<CR>", "Projects" },
    f = {
      "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--fixed-strings<CR>",
      "Files",
    },
    g = { "<cmd>Telescope git_files<CR>", "Git files" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current buffer" },
    B = { "<cmd>Telescope buffers<CR>", "Buffers" },
    t = {
      "<cmd>Telescope live_grep vimgrep_arguments=rg,--color=never,--no-heading,--hidden,--with-filename,--line-number,--column,--smart-case,--fixed-strings,--multiline<CR>",
      "Text",
    },
    c = { "<cmd>Telescope command_history<CR>", "Command history" },
    C = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    m = { "<cmd>Telescope marks<CR>", "Marks" },
    h = { "<cmd>Telescope harpoon marks<cr>", "Harpooned files" },
    H = { "<cmd>Telescope help_tags<CR>", "Help" },
    M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
    r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
    R = { "<cmd>Telescope registers<CR>", "Registers" },
    j = { "<cmd>Telescope jumplist<CR>", "Jumplist" },
  },
  ["g"] = {
    name = "+Git",
    o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
    B = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
  },
  ["t"] = {
    name = "+Toggle",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<CR>", "Lazydocker" },
    b = { "<cmd>:GitBlameToggle<CR>", "Git blame" },
    s = {
      toggle.spelling,
      "Spelling",
    },
    w = {
      toggle.WordWrap,
      "Word wrap",
    },
    n = {
      toggle.RelativeLineNumbers,
      "Relative line Numbers",
    },
    z = { "<cmd>:ZenMode<CR>", "Zen mode" },
  },
  ["l"] = {
    name = "+LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Rename" },
    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    b = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    H = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    I = { "<cmd>lua require('nahojer.lsp.handlers').implementation()<CR>", "Implementation" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Previous diagnostic",
    },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    i = { "<cmd>LspInfo<CR>", "LSP info" },
  },
  ["d"] = {
    name = "+Debugging",
    c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
    j = { "<cmd>lua require('dap').step_over()<CR>", "Step over" },
    i = { "<cmd>lua require('dap').step_into()<CR>", "Step into" },
    o = { "<cmd>lua require('dap').step_out()<CR>", "Step out" },
    b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Breakpoint" },
    r = { "<cmd>lua require('dap').repl.open()<CR>", "Open repl" },
  },
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
  ["y"] = { '"+y', "Yank" },
  ["d"] = { '"_d', "Delete" },
}

local xopts = {
  mode = "x", -- VISUAL block mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local xmappings = {
  ["p"] = { '"_dP', "Paste" },
}

wk.register(nmappings, opts)
wk.register(vmappings, vopts)
wk.register(xmappings, xopts)
