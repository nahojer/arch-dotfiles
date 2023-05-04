local lsp = require 'lsp-zero'

lsp.preset 'recommended'

lsp.ensure_installed {
  'tsserver',
  'rust_analyzer',
  'zls',
  'gopls',
  'lua_ls',
  'pylsp',
  'cssls',
  'html',
  'terraformls',
}

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm { select = true },
  ['<C-Space>'] = cmp.mapping.complete(),
}

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp {
  mapping = cmp_mappings,
}

lsp.set_preferences {
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I',
  },
}

lsp.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set('n', 'gy', function()
    vim.lsp.buf.type_definition()
  end, opts)
  vim.keymap.set('n', 'gi', function()
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(0, 'textDocument/implementation', params, function(err, result, ctx, config)
      if result == nil then
        return
      end

      local ft = vim.api.nvim_buf_get_option(ctx.bufnr, 'filetype')

      -- In Go code, I do not like to see any mocks for impls...
      if ft == 'go' then
        local new_result = vim.tbl_filter(function(v)
          return not (string.find(v.uri, 'mock_') or string.find(v.uri, 'mock/') or string.find(v.uri, 'mocks/'))
        end, result)

        if #new_result > 0 then
          result = new_result
        end
      end

      vim.lsp.handlers['textDocument/implementation'](err, result, ctx, config)
      vim.cmd [[normal! zz]]
    end)
  end, opts)
  vim.keymap.set('n', 'gr', function()
    vim.lsp.buf.references()
  end, opts)

  vim.keymap.set('n', '<leader>a', function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set('n', '<leader>k', function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set('n', '<leader>r', function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
  vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics<CR>', opts)
  vim.keymap.set('n', '<leader>s', '<cmd>Telescope lsp_document_symbols<CR>', opts)
  vim.keymap.set('n', '<leader>S', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', opts)

  vim.keymap.set('n', '[d', function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.goto_prev()
  end, opts)
end)

lsp.format_on_save {
  format_opts = {
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'lua', 'go', 'rust', 'python', 'zig' },
  },
}

lsp.format_mapping('<leader>=', {
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = {
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'lua',
      'go',
      'rust',
      'python',
      'zig',
      'terraform',
      'tf',
      'terraform-vars',
      'hcl',
      'scss',
      'less',
      'css',
      'sass',
      'txt',
      'markdown',
      'html',
      'json',
      'yaml',
      'xml',
      'zsh',
      'bash',
      'sh',
      'sql',
      'pgsql',
      'graphql',
    },
  },
})

lsp.setup()

vim.diagnostic.config {
  virtual_text = true,
}

local Job = require 'plenary.job'
local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
    -- Formatting
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.pg_format,
    -- null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.zigfmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.hclfmt,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.eslint_d.with {
      on_attach = function()
        Job:new({ command = 'eslint_d', args = { 'restart' } }):sync()
      end,
    },

    -- Diagnostics
    null_ls.builtins.diagnostics.eslint_d.with {
      on_attach = function()
        Job:new({ command = 'eslint_d', args = { 'restart' } }):sync()
      end,
      condition = function(utils)
        return utils.root_has_file { '.eslintrc' }
      end,
    },
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.staticcheck,
    null_ls.builtins.diagnostics.staticcheck,
    null_ls.builtins.diagnostics.terraform_validate,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.zsh,

    -- Code actions
    null_ls.builtins.code_actions.eslint_d,
  },
}

require('mason-null-ls').setup {
  ensure_installed = nil,
  automatic_installation = true,
}
