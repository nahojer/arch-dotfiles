local M = {}

local function log_warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name or "init.lua" })
end

local function log_info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name or "init.lua" })
end

local function toggle(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      log_info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      log_warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

function M.spelling()
  toggle "spell"
end

function M.WordWrap()
  toggle "wrap"
end

function M.RelativeLineNumbers()
  toggle("relativenumber", true)
end

return M
