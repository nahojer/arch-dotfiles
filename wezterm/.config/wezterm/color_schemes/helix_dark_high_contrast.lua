local colors = {
	black = '#000000',
	white = '#ffffff',
	gray = '#585858',
	blue = "#66a4ff",
	deep_blue = "#142743",
	dark_blue = "#0d1a2d",
	aqua = "#6fc3df",
	purple = "#c586c0",
	red = "#b65f5f",
	pink = "#ff5c8d",
	orange = "#f38518",
	brown = "#ce9178",
	yellow = "#cedc84",
	green = "#427a2d",
	emerald_green = "#4ec9b0",
	todo = "#fb71c9",
}

return {
	-- The default background color
	background = colors.black,

	-- The default text color
	foreground = colors.white,

	-- Colors of the cursor
	cursor_bg = colors.white,
	cursor_fg = colors.black,
	--cursor_border  '',

	-- The color of selected text
	selection_fg = colors.black,
	selection_bg = colors.white,

	-- A list of 8 colors corresponding to the basic ANSI palette
	ansi = {
		colors.todo, -- ?
  	colors.red, -- git modified file / deleted in diff, _w_ for group/other
  	colors.green, -- __x for root, git added in diff, known command in terminal, Size unit in ls
  	colors.white, -- r__ for non-root
  	colors.brown, -- Date + Modified, branch
  	colors.todo, -- ?
  	colors.aqua, -- git @@dif
  	colors.todo, -- ?
	},

	-- A list of 8 colors corresponding to bright versions of the ANSI palette
	brights = {
    colors.gray, -- auto-completion preview in terminal
    colors.brown, -- _w_ for root
    colors.yellow, -- executable files, Size (excluding unit), __x for non-root
    colors.blue, -- r__ for root, User (non-root), Some files?
    colors.aqua, -- d___, directories
    colors.todo, -- ?
    colors.todo, -- ?
    colors.todo, -- ?
  },

	-- A map for setting arbitrary colors ranging from 16 to 256 in the color palette
	indexed = {},

	 -- Configure the colors and styling of the tab bar
	tab_bar = {},

	-- The color of the "thumb" of the scrollbar; the segment that represents the current viewable area
	scrollbar_thumb = colors.white,

	-- The color of the split line between panes
	split = colors.gray,

	-- The color of the visual bell. If unspecified, the foreground
	visual_bell = colors.white,

	-- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = colors.white,

	-- Colors for copy_mode and quick_select
	-- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
	copy_mode_active_highlight_bg = { Color = colors.black },
	copy_mode_active_highlight_fg = { Color = colors.white },
	copy_mode_inactive_highlight_bg = { Color = colors.gray },
	copy_mode_inactive_highlight_fg = { Color = colors.white },

	quick_select_label_bg = { Color = colors.black },
	quick_select_label_fg = { Color = colors.white },
	quick_select_match_bg = { Color = colors.gray },
	quick_select_match_fg = { Color = colors.white },
}