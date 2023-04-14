local colors = {
	white = '#ffffdd',
	black = '#000000',
	gray = '#585858',
}

return {
	-- The default background color
	background = colors.white,

	-- The default text color
	foreground = colors.black,

	-- Colors of the cursor
	cursor_bg = colors.black,
	cursor_fg = colors.white,
	cursor_border = colors.black,

	-- The color of selected text
	selection_fg = colors.white,
	selection_bg = colors.black,

	-- A list of 8 colors corresponding to the basic ANSI palette
	ansi = {
		colors.black, -- ?
  	colors.black, -- git modified file / deleted in diff, _w_ for group/other
  	colors.black, -- __x for root, git added in diff, known command in terminal, Size unit in ls
  	colors.black, -- r__ for non-root
  	colors.black, -- Date + Modified, branch
  	colors.black, -- ?
  	colors.black, -- git @@dif
  	colors.black, -- ?
	},

	-- A list of 8 colors corresponding to bright versions of the ANSI palette
	brights = {
    colors.black, -- auto-completion preview in terminal
    colors.black, -- _w_ for root
    colors.black, -- executable files, Size (excluding unit), __x for non-root
    colors.black, -- r__ for root, User (non-root), Some files?
    colors.black, -- d___, directories
    colors.black, -- ?
    colors.black, -- ?
    colors.black, -- ?
  },

	-- A map for setting arbitrary colors ranging from 16 to 256 in the color palette
	indexed = {},

	 -- Configure the colors and styling of the tab bar
	tab_bar = {},

	-- The color of the "thumb" of the scrollbar; the segment that represents the current viewable area
	scrollbar_thumb = colors.black,

	-- The color of the split line between panes
	split = colors.gray,

	-- The color of the visual bell. If unspecified, the foreground
	visual_bell = colors.black,

	-- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = colors.black,

	-- Colors for copy_mode and quick_select
	-- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
	copy_mode_active_highlight_bg = { Color = colors.white },
	copy_mode_active_highlight_fg = { Color = colors.black },
	copy_mode_inactive_highlight_bg = { Color = colors.gray },
	copy_mode_inactive_highlight_fg = { Color = colors.black },

	quick_select_label_bg = { Color = colors.white },
	quick_select_label_fg = { Color = colors.black },
	quick_select_match_bg = { Color = colors.gray },
	quick_select_match_fg = { Color = colors.black },
}