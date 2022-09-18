local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
	return
end

-- `ys{motion}{char}` in normal mode and S{motion}{char} for selected text in visual mode.
surround.setup()
