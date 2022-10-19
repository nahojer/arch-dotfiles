local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup {}

local keymap = vim.keymap.set
local opts = { silent = true }

keymap("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end, opts)

keymap("n", "<C-e>", function()
  require("harpoon.ui").toggle_quick_menu()
end, opts)

keymap("n", "<leader>hc", function()
  require("harpoon.mark").set_mark_list {}
end, opts)

for i = 1, 5 do
  keymap("n", string.format("<space>%s", i), function()
    require("harpoon.ui").nav_file(i)
  end, opts)
end
