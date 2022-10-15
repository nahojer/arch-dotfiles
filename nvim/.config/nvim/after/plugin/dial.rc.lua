local status_ok, _ = pcall(require, "dial.config")
if not status_ok then
  return
end

local augend = require "dial.augend"
require("dial.config").augends:register_group {
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%m/%d/%Y"],
    augend.date.alias["%d/%m/%Y"],
    augend.date.alias["%m/%d/%y"],
    augend.date.alias["%d/%m/%y"],
    augend.date.alias["%m/%d"],
    augend.date.alias["%-m/%-d"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%d.%m.%Y"],
    augend.date.alias["%d.%m.%y"],
    augend.date.alias["%d.%m."],
    augend.date.alias["%-d.%-m."],
    augend.semver.alias.semver,
    augend.constant.new {
      elements = { "and", "or" },
      word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
      cyclic = true, -- "or" is incremented into "and".
    },
    augend.constant.new {
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    },
  },
}

vim.api.nvim_set_keymap("n", "+", require("dial.map").inc_normal(), { noremap = true })
vim.api.nvim_set_keymap("n", "-", require("dial.map").dec_normal(), { noremap = true })
vim.api.nvim_set_keymap("v", "+", require("dial.map").inc_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "-", require("dial.map").dec_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g+", require("dial.map").inc_gvisual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g-", require("dial.map").dec_gvisual(), { noremap = true })
