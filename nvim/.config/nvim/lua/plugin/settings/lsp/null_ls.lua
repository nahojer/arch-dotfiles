local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- The with_diagnostic_code function configures the diagnostic message format.
-- #{m} displays the message, and #{c} displays the code if available.
local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    -- Formatting
    formatting.prettierd,
    formatting.black.with { extra_args = { "--fast" } },
    formatting.shfmt,
    formatting.fixjson,
    formatting.stylua,
    formatting.goimports,

    -- Diagnostics
    diagnostics.write_good,
    diagnostics.eslint_d,
    diagnostics.flake8,
    diagnostics.golangci_lint,
    with_diagnostics_code(diagnostics.shellcheck),
  },
}
