local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup {}

for i = 1, 5 do
  vim.keymap.set("n", string.format("<space>%s", i), function()
    require("harpoon.ui").nav_file(i)
  end, { desc = string.format("⥭ %s", i) })
end
