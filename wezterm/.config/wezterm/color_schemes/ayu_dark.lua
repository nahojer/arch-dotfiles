local colors = {
	background = '#0f1419',
	foreground = '#bfbdb6',
	white = '#ffffff',
	black = '#131721',
	blue = '#59c2ff',
	dark_gray = '#2d3640',
	cyan = '#73b8ff',
	gray = '#5c6773',
	green = '#aad94c',
	magenta = '#d2a6ff',
	orange = '#ff8f40',
	red = '#f07178',
	yellow = '#e6b450',
}

return {
	-- The default background color
	background = colors.background,

	-- The default text color
	foreground = colors.foreground,

	-- Colors of the cursor
	cursor_bg = colors.foreground,
	cursor_fg = colors.background,
	cursor_border = colors.foreground,

	-- The color of selected text
	selection_fg = colors.background,
	selection_bg = colors.foreground,

	-- A list of 8 colors corresponding to the basic ANSI palette
	ansi = {
		colors.black,
  	colors.red,
  	colors.green,
  	colors.yellow,
  	colors.blue,
  	colors.red,
  	colors.cyan, 
  	colors.white,
	},

	-- A list of 8 colors corresponding to bright versions of the ANSI palette
	brights = {
    colors.dark_gray, 
    colors.red, 
    colors.green, 
    colors.yellow, 
    colors.magenta, 
    colors.red, 
    colors.cyan, 
    colors.white, 
  },

	-- A map for setting arbitrary colors ranging from 16 to 256 in the color palette
	indexed = {},

	 -- Configure the colors and styling of the tab bar
	tab_bar = {},

	-- The color of the "thumb" of the scrollbar; the segment that represents the current viewable area
	scrollbar_thumb = colors.foreground,

	-- The color of the split line between panes
	split = colors.gray,

	-- The color of the visual bell. If unspecified, the foreground
	visual_bell = colors.foreground,

	-- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = colors.foreground,

	-- Colors for copy_mode and quick_select
	-- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
	copy_mode_active_highlight_bg = { Color = colors.background },
	copy_mode_active_highlight_fg = { Color = colors.foreground },
	copy_mode_inactive_highlight_bg = { Color = colors.gray },
	copy_mode_inactive_highlight_fg = { Color = colors.foreground },

	quick_select_label_bg = { Color = colors.background },
	quick_select_label_fg = { Color = colors.foreground },
	quick_select_match_bg = { Color = colors.gray },
	quick_select_match_fg = { Color = colors.foreground },
}