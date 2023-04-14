local colors = {
	black = '#000000',
	white = '#ffffff',
	gray = '#585858',
}

return {
	-- The default background color
	background = colors.black,

	-- The default text color
	foreground = colors.white,

	-- Colors of the cursor
	cursor_bg = colors.white,
	cursor_fg = colors.black,
	cursor_border = colors.white,

	-- The color of selected text
	selection_fg = colors.black,
	selection_bg = colors.white,

	-- A list of 8 colors corresponding to the basic ANSI palette
	ansi = {
		colors.white, -- ?
  	colors.white, -- git modified file / deleted in diff, _w_ for group/other
  	colors.white, -- __x for root, git added in diff, known command in terminal, Size unit in ls
  	colors.white, -- r__ for non-root
  	colors.white, -- Date + Modified, branch
  	colors.white, -- ?
  	colors.white, -- git @@dif
  	colors.white, -- ?
	},

	-- A list of 8 colors corresponding to bright versions of the ANSI palette
	brights = {
    colors.white, -- auto-completion preview in terminal
    colors.white, -- _w_ for root
    colors.white, -- executable files, Size (excluding unit), __x for non-root
    colors.white, -- r__ for root, User (non-root), Some files?
    colors.white, -- d___, directories
    colors.white, -- ?
    colors.white, -- ?
    colors.white, -- ?
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