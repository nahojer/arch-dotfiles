local vo = vim.opt_local
vo.tabstop = 4 -- spaces per tab
vo.shiftwidth = 4 -- spaces when indenting
vo.softtabstop = 4
vo.expandtab = false -- whether to convert tabs to spaces.

local status_wk_ok, wk = pcall(require, "which-key")
if not status_wk_ok then
  return
end

wk.register({
  ["c"] = {
    name = "Code",
    p = { ":lua require('dap-go').debug_test()<CR>", "Debug test" },
  },
}, {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps})
})
