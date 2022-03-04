local present, lspconfig = pcall(require, "lspconfig")
local protocol = require'vim.lsp.protocol'
if (not present) then return end

vim.lsp.set_log_level("debug")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap("n", 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", 'gk', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", '<leader>wa', "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", '<leader>wr', "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", '<leader>wl', "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", '<leader>D', "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", '<leader>ra', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", 'ge', "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", '[d', "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", ']d', "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", '<leader>q', "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", '<leader>fm', "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- formatting
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

  --protocol.SymbolKind = { }
  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
end

local function config(_config)
  capabilities = vim.lsp.protocol.make_client_capabilities()
  return vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  }, _config or {})
end


servers = {
  ['awk_ls'] = {},
  ['bashls'] = {},
  ['cssmodules_ls'] = {},
  ['diagnosticls'] = {
    filetypes = { 'ruby', 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'pandoc' },
    init_options = {
      linters = {
        reek = {
          command = 'reek',
          debounce = 100,
          args = {
            'exec',
            'reek',
            '--format',
            'json',
            '--force-exclusion',
            '--stdin-filename',
            '%filepath',
          },
          parseJson = {
            line = 'lines[0]',
            endLine = 'lines[1]',
            message = '[reek] [${smell_type}] ${message}',
          },
          securities = { undefined = 'info' },
        },
        eslint = {
          command = 'eslint_d',
          rootPatterns = { '.git' },
          debounce = 100,
          args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
          sourceName = 'eslint_d',
          parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[eslint] ${message} [${ruleId}]',
            security = 'severity'
          },
          securities = {
            [2] = 'error',
            [1] = 'warning'
          }
        },
      },
      filetypes = {
        javascript = 'eslint',
        javascriptreact = 'eslint',
        typescript = 'eslint',
        typescriptreact = 'eslint',
        ruby = 'reek',
      },
      formatters = {
        eslint_d = {
          command = 'eslint_d',
          rootPatterns = { '.git' },
          args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
          rootPatterns = { '.git' },
        },
        prettier = {
          command = 'prettier_d_slim',
          rootPatterns = { '.git' },
          -- requiredFiles: { 'prettier.config.js' },
          args = { '--stdin', '--stdin-filepath', '%filename' }
        }
      },
      formatFiletypes = {
        css = 'prettier',
        javascript = 'prettier',
        javascriptreact = 'prettier',
        json = 'prettier',
        scss = 'prettier',
        less = 'prettier',
        typescript = 'prettier',
        typescriptreact = 'prettier',
        json = 'prettier',
      }
    }
  },
  ['dockerls'] = {},
  ['elixirls'] = {
    cmd = { "elixir-ls" }
  },
  ['emmet_ls'] = {},
  ['flow'] = {},
  ['gopls'] = {},
  ['graphql'] = {},
  ['html'] = {},
  ['jsonls'] = {},
  ['pyright'] = {},
  ['rust_analyzer'] = {
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  },
  ['solargraph'] = {},
  ['terraform_lsp'] = {},
  ['tsserver'] = {},
  ['vimls'] = {},
  ['yamlls'] = {},
}

for lsp, _config in pairs(servers) do
  lspconfig[lsp].setup(config(_config or {}))
end

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)
