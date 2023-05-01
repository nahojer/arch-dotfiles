local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- OpenGL for GPU acceleration, Software for CPU
config.front_end = "OpenGL"

------------------------------------
-- Events
------------------------------------

function scandir(directory)
    local pfile = assert(io.popen(("find '%s' -mindepth 1 -maxdepth 1 -type d -printf '%%f\\0'"):format(directory), 'r'))
    local list = pfile:read('*a')
    pfile:close()

    local folders = {}
    for filename in string.gmatch(list, '[^%z]+') do
        table.insert(folders, filename)
    end

    return folders
end

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window
  local args = {}
  if cmd then
    args = cmd.args
  end

  local project_dir = wezterm.home_dir .. '/Projects'
  for _, name in pairs(scandir(project_dir)) do
    mux.spawn_window { workspace = '~/Projects/' .. name, cwd = project_dir .. '/' .. name, args = args }
  end

  local work_dir = wezterm.home_dir .. '/Work'
  for _, name in pairs(scandir(work_dir)) do
    mux.spawn_window { workspace = '~/Work/' .. name, cwd = work_dir .. '/' .. name, args = args }
  end

  mux.spawn_window { workspace = 'dotfiles', cwd = wezterm.home_dir .. '/.dotfiles', args = args }
  mux.set_active_workspace 'dotfiles'
end)

------------------------------------
-- Appearance
------------------------------------

-- Colors
config.color_scheme = 'GitHub Dark'
config.color_schemes = {
	['plain_white'] = require('color_schemes.plain_white'),
	['plain_black'] = require('color_schemes.plain_black'),
	['boring'] = require('color_schemes.boring'),
}

-- Transparency
config.window_background_opacity = 1
config.font_size = 10
config.line_height = 1.0
config.dpi = 96.0

-- Padding
local horizontalPadding = 5;
local verticalPadding = 5;
config.window_padding = {
	left = horizontalPadding,
	right = horizontalPadding,
	top = verticalPadding,
	bottom = verticalPadding,
}

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 0
config.default_cursor_style = 'BlinkingBlock'

------------------------------------
-- Key bindings
------------------------------------
config.skip_close_confirmation_for_processes_named = {}
config.disable_default_key_bindings = true
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
	-- Leader fix: Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A.
	{ key = 'a', mods = 'LEADER|CTRL',  action = act.SendString '\x01' },
	-- Move between panes.
	{ key = 'h', mods = 'LEADER',       action = act.ActivatePaneDirection 'Left' },
	{ key = 'l', mods = 'LEADER',       action = act.ActivatePaneDirection 'Right' },
	{ key = 'k', mods = 'LEADER',       action = act.ActivatePaneDirection 'Up' },
	{ key = 'j', mods = 'LEADER',       action = act.ActivatePaneDirection 'Down' },
	-- Create/close panes.
	{ key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
	{ key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
	{ key = 'x', mods = 'LEADER',       action = act.CloseCurrentPane { confirm = true } },
	-- Move between tabs.
	{ key = '1', mods = 'LEADER',       action = act.MoveTab(1 - 1) },
	{ key = '1', mods = 'LEADER',       action = act.ActivateTab(1 - 1) },
	{ key = '2', mods = 'LEADER',       action = act.MoveTab(2 - 1) },
	{ key = '2', mods = 'LEADER',       action = act.ActivateTab(2 - 1) },
	{ key = '3', mods = 'LEADER',       action = act.MoveTab(3 - 1) },
	{ key = '3', mods = 'LEADER',       action = act.ActivateTab(3 - 1) },
	{ key = '4', mods = 'LEADER',       action = act.MoveTab(3 - 1) },
	{ key = '4', mods = 'LEADER',       action = act.ActivateTab(4 - 1) },
	{ key = '5', mods = 'LEADER',       action = act.MoveTab(5 - 1) },
	{ key = '5', mods = 'LEADER',       action = act.ActivateTab(5 - 1) },
	{ key = '6', mods = 'LEADER',       action = act.MoveTab(6 - 1) },
	{ key = '6', mods = 'LEADER',       action = act.ActivateTab(6 - 1) },
	{ key = '7', mods = 'LEADER',       action = act.MoveTab(7 - 1) },
	{ key = '7', mods = 'LEADER',       action = act.ActivateTab(7 - 1) },
	{ key = '8', mods = 'LEADER',       action = act.MoveTab(8 - 1) },
	{ key = '8', mods = 'LEADER',       action = act.ActivateTab(8 - 1) },
	{ key = '9', mods = 'LEADER',       action = act.MoveTab(9 - 1) },
	{ key = '9', mods = 'LEADER',       action = act.ActivateTab(9 - 1) },
	{ key = 'p', mods = 'LEADER',       action = act.MoveTabRelative(-1) },
	{ key = 'p', mods = 'LEADER',       action = act.ActivateTabRelative(-1) },
	{ key = 'n', mods = 'LEADER',       action = act.MoveTabRelative(1) },
	{ key = 'n', mods = 'LEADER',       action = act.ActivateTabRelative(1) },
	-- Create/close tabs.
	{ key = 'c', mods = 'LEADER',       action = act.SpawnTab 'CurrentPaneDomain' },
	{ key = 'x', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab { confirm = true } },
	-- Copy/paste.
	{ key = 'c', mods = 'SHIFT|CTRL',   action = act.CopyTo 'ClipboardAndPrimarySelection' },
	{ key = 'v', mods = 'SHIFT|CTRL',   action = act.PasteFrom 'Clipboard' },
	-- Launcher.
	{ key = "s", mods = "LEADER",       action = act.ShowLauncher },
	-- Search.
	{ key = '/', mods = 'LEADER',       action = act.Search 'CurrentSelectionOrEmptyString' },
	-- Workspaces.
	{
    key = 'f',
    mods = 'LEADER',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
  {
		-- Prompt for a name to use for a new workspace and switch to it.
    key = 'w',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },

}
config.key_tables = {
	search_mode = {
		{ key = 'Escape',   mods = 'NONE', action = act.CopyMode 'Close' },
		{ key = 'n',        mods = 'CTRL', action = act.CopyMode 'NextMatch' },
		{ key = 'p',        mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
		{ key = 'r',        mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
		{ key = 'u',        mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
		{ key = 'PageUp',   mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
		{ key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
	},
}

------------------------------------
-- General
------------------------------------
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"

return config

