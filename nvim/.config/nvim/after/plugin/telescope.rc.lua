local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.90,
      height = 0.95,
    },

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules/", "vendor/", ".cache/", ".vscode/" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default + actions.center,
        ["<c-x>"] = false,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },

  extensions = {
    project = {
      base_dirs = {
        { "~/.dotfiles" },
        { path = "~/Work", max_depth = 1 },
        { path = "~/Projects", max_depth = 4 },
      },
      hidden_files = true, -- default: false
      theme = "dropdown",
    },
  },
}

telescope.load_extension "project"
telescope.load_extension "dap"
telescope.load_extension "harpoon"
