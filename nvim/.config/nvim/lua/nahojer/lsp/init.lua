-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "nahojer.lsp.handlers" -- override lsp handlers

-----------------------------------------
-- Custom on_attach
-----------------------------------------

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-f>", "<cmd>vim.lsp.buf.format()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-a>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
end

local function lsp_highlight_document(client)
  if client.server_capabilities.document_highlight then
    local status_illuminate_ok, illuminate = pcall(require, "illuminate")
    if not status_illuminate_ok then
      return
    end
    illuminate.on_attach(client)
  end
end

-- we typically disable any formatting capabilities of the builtin
-- LSP if we want our own formatter, e.g. using our own prettierd
-- formatter for tsserver, or goimports for Go.
local function lsp_disable_formatting_capabilities(client)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end

local function custom_on_attach_func(opts)
  opts = opts or {}
  return function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
    if opts["disable_lsp_formatting"] then
      lsp_disable_formatting_capabilities(client)
    end
  end
end

-----------------------------------------
-- Custom capabilities
-----------------------------------------

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()

-- Completion configuration
require("cmp_nvim_lsp").default_capabilities(custom_capabilities)
custom_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

custom_capabilities.textDocument.codeLens = { dynamicRegistration = false }

-----------------------------------------
-- Setup Go
-----------------------------------------

lspconfig.gopls.setup {
  on_attach = custom_on_attach_func {
    -- turn off builtin lsp formatting and use our own formatting setup
    disable_lsp_formatting = true,
  },
  capabilities = custom_capabilities,
  settings = {
    gopls = {
      codelenses = { test = true },
    },
  },

  flags = {
    debounce_text_changes = 200,
  },
}

local function goimports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.go",
  callback = function()
    if vim.fn.executable "goimports" == 0 then
      vim.lsp.buf.format()
    else
      vim.lsp.buf.format()
      goimports(1000)
    end
  end,
})

-----------------------------------------
-- Setup Lua
-----------------------------------------

lspconfig.sumneko_lua.setup {
  on_attach = custom_on_attach_func {
    -- turn off builtin lsp formatting and use our own formatting setup
    disable_lsp_formatting = true,
  },
  capabilities = custom_capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.lua",
  callback = function()
    if vim.fn.executable "stylua" == 0 then
      vim.lsp.buf.format()
    else
      require("nahojer.stylua").format()
    end
  end,
})
