local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

indent_blankline.setup {
  char = "▏",
  char_blankline = "▏",
  filetype_exclude = {
    "help",
    "markdown",
    "Trouble",
    "NvimTree",
    "neogitstatus",
    "dashboard",
    "packer",
    "startify",
    "text",
    "terminal",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "FALLBACK",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = true,
  show_first_indent_level = false,
  show_end_of_line = false,
}
