local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

wk.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
		spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	[";"] = { "<cmd>Alpha<CR>", "Dashboard" },
	["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
	["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
	["h"] = {
		name = "Help",
		t = { "<cmd>:Telescope builtin<CR>", "Telescope" },
		c = { "<cmd>:Telescope commands<CR>", "Commands" },
		h = { "<cmd>:Telescope help_tags<CR>", "Help Pages" },
		m = { "<cmd>:Telescope man_pages<CR>", "Man Pages" },
		k = { "<cmd>:Telescope keymaps<CR>", "Key Maps" },
		s = { "<cmd>:Telescope highlights<CR>", "Search Highlight Groups" },
		l = { [[<cmd>TSHighlightCapturesUnderCursor<CR>]], "Highlight Groups at cursor" },
		f = { "<cmd>:Telescope filetypes<CR>", "File Types" },
		o = { "<cmd>:Telescope vim_options<CR>", "Options" },
		a = { "<cmd>:Telescope autocommands<CR>", "Auto Commands" },
	},
	["b"] = {
		name = "Buffers",
		c = { '<cmd>lua require("plugin.settings.bufferline").buf_kill("bd")<CR>', "Close" },
		j = { "<cmd>BufferLinePick<cr>", "Jump" },
		f = { "<cmd>Telescope buffers<cr>", "Find" },
		p = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
		e = {
			"<cmd>BufferLinePickClose<cr>",
			"Pick which buffer to close",
		},
		h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
		l = {
			"<cmd>BufferLineCloseRight<cr>",
			"Close all to the right",
		},
		D = {
			"<cmd>BufferLineSortByDirectory<cr>",
			"Sort by directory",
		},
		L = {
			"<cmd>BufferLineSortByExtension<cr>",
			"Sort by language",
		},
	},
	["s"] = {
		name = "Search",
		p = { ":lua require('telescope').extensions.project.project{}<CR>", "Projects" },
		f = {
			"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--fixed-strings<CR>",
			"Files",
		},
		g = { "<cmd>Telescope git_files<CR>", "Git files" },
		b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current buffer" },
		B = { "<cmd>Telescope buffersCR>", "Buffers" },
		t = {
			"<cmd>Telescope live_grep vimgrep_arguments=rg,--color=never,--no-heading,--hidden,--with-filename,--line-number,--column,--smart-case,--fixed-strings,--multiline<CR>",
			"Text",
		},
		c = {
			"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>",
			"Colorscheme with preview",
		},
		m = { "<cmd>Telescope marks<CR>", "Marks" },
		h = { "<cmd>Telescope help_tags<CR>", "Help" },
		M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
		r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
		R = { "<cmd>Telescope registers<CR>", "Registers" },
		j = { "<cmd>Telescope jumplist<CR>", "Jumplist" },
		x = { '<cmd>lua require("telescope").extensions.media_files.media_files()<CR>', "Media files" },
	},
	-- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	["l"] = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
		d = { "<cmd>lua vim.lsp.definition()<CR>", "Definition" },
		D = { "<cmd>lua vim.lsp.declaration()<CR>", "Declaration" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Rename" },
		R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		b = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer diagnostics" },
		w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		f = { "<cmd>lua require('plugin.settings.lsp.utils').format()<CR>", "Format" },
		H = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
		l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open float" },
		I = { '<cmd>lua require("plugin.settings.lsp.handlers").implementation()<CR>', "Implementation" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<cr>",
			"Next diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Previous diagnostic",
		},
		p = {
			name = "Peek",
			d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<CR>", "Definition" },
			t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<CR>", "Type definition" },
			i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<CR>", "Implementation" },
		},
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		e = { "<cmd>Telescope quickfix<CR>", "Quickfix" },
		x = {
			name = "Info",
			x = { "<cmd>LspInfo<CR>", "LSP" },
			i = { "<cmd>LspInstallInfo<CR>", "Installer" },
		},
	},
	["g"] = {
		name = "Git",
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
	},
	["q"] = {
		name = "Quit",
		q = { "<cmd>:qa<CR>", "Quit" },
		["!"] = { "<cmd>:qa!<CR>", "Quit without saving" },
	},
}

local vmappings = {
	["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
}

wk.register(mappings, opts)
wk.register(vmappings, vopts)
