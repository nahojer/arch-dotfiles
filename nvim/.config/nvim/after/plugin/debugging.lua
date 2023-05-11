local ok, dap = pcall(require, 'dap')
if not ok then
  return
end

local map = function(lhs, rhs, desc)
  if desc then
    desc = '[DAP] ' .. desc
  end

  vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
end

map('<F1>', require('dap').step_back, 'step_back')
map('<F2>', require('dap').step_into, 'step_into')
map('<F3>', require('dap').step_over, 'step_over')
map('<F4>', require('dap').step_out, 'step_out')
map('<F5>', require('dap').continue, 'continue')
map('<leader>Tb', require('dap').toggle_breakpoint)
map('<leader>TB', function()
  require('dap').set_breakpoint(vim.fn.input '[DAP] Condition > ')
end)

require('dapui').setup()

local dapui = require 'dapui'
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

require('dap-go').setup()
map('<leader>td', require('dap-go').debug_test, 'debug test')

require('nvim-dap-virtual-text').setup()
