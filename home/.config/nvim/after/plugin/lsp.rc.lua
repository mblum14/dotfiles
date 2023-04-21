local present, lspconfig = pcall(require, "lspconfig")
local wk = require'which-key'
local protocol = require'vim.lsp.protocol'
if (not present) then return end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buffer=bufnr, noremap=true, silent=true }
  wk.register({
    g = {
      name = "lsp goto",
      d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition" },
      D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
      td = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto type definition" },
      i = { "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
      k = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "open signature help" },
      r = { "<Cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
      e = { "<Cmd>TroubleToggle<CR>", "Open quickfix" },
    },
    ["<leader>"] = {
      name = "lsp action",
      w = {
        name = "workspace",
        a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
        r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace folder" },
        l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folders" },
      },
      rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Set location list" },
      fm = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
    },
    K = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Show definition" },
    ["<c-k>"] = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Documentation" },
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "goto previous" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "goto next" },
    ["<leader>e"] = {"<cmd>lua vim.diagnostic.open_float()<CR>", "Open diagnostics in float" },
  }, opts)


  -- formatting
  if client.name == 'tsserver' then
    client.server_capabilities.document_formatting = false
  end

  if client.server_capabilities.document_formatting then
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
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
  }, _config or {})
end


servers = {
  ['awk_ls'] = {},
  ['bashls'] = {},
  ['cssmodules_ls'] = {},
  ['diagnosticls'] = {
    filetypes = {
      'ruby',
      'javascript',
      'javascriptreact',
      'python',
      'typescript',
      'typescriptreact',
      'sh',
      'json',
      'yaml',
      'css',
      'less',
      'scss',
      'pandoc',
    },
    init_options = {
      linters = {
        shellcheck = {
          sourceName = 'shellcheck',
          command = 'shellcheck',
          debounce = 100,
          ignore = { ".git", "dist/" },
          args = { '--format', 'json1', '-' },
          parseJson = {
            errorsRoot = 'comments',
            sourceName = 'file',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            security = 'level',
            message = '[shellcheck] ${message} [SC${code}]',
          },
          securities = {
            error = 'error',
            warning = 'warning',
            info = 'info',
            style = 'hint',
          },
        },
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
        rubocop = {
          sourceName = 'rubocop',
          command = 'rubocop',
          debounce = 100,
          args = {
            'exec',
            'rubocop',
            '--format',
            'json',
            '--force-exclusion',
            '--stdin',
            '%filepath',
          },
          parseJson = {
            errorsRoot = 'files[0].offenses',
            line = 'location.start_line',
            endLine = 'location.last_line',
            column = 'location.start_column',
            endColumn = 'location.end_column',
            message = '[rubocop] [${cop_name}] ${message}',
            security = 'severity',
          },
          securities = {
            fatal = 'error',
            error = 'error',
            warning = 'warning',
            convention = 'info',
            refactor = 'info',
            info = 'info',
          },
        },
        eslint = {
          command = 'eslint_d',
          rootPatterns = {
            '.eslintrc',
            '.eslintrc.cjs',
            '.eslintrc.js',
            '.eslintrc.json',
            '.eslintrc.yaml',
            '.eslintrc.yml',
          },
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
        flake8 = {
          sourceName = 'flake8',
          command = 'flake8',
          args = { [[--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s]], '-' },
          debounce = 100,
          offsetLine = 0,
          offsetColumn = 0,
          formatLines = 1,
          formatPattern = {
            [[(\d+),(\d+),([A-Z]),(.*)(\r|\n)*$]],
            { line = 1, column = 2, security = 3, message = { '[flake8] ', 4 } },
          },
          securities = {
            W = 'warning',
            E = 'error',
            F = 'error',
            C = 'error',
            N = 'error',
          },
        },
        pylint = {
          sourceName = 'pylint',
          command = 'pylint',
          args = {
            '--output-format',
            'text',
            '--score',
            'no',
            '--msg-template',
            [['{line}:{column}:{category}:{msg} ({msg_id}:{symbol})']],
            '%file',
          },
          offsetColumn = 1,
          formatLines = 1,
          formatPattern = {
            [[^(\d+?):(\d+?):([a-z]+?):(.*)$]],
            { line = 1, column = 2, security = 3, message = { '[pylint] ', 4 } },
          },
          securities = {
            informational = 'hint',
            refactor = 'info',
            convention = 'info',
            warning = 'warning',
            error = 'error',
            fatal = 'error',
          },
          rootPatterns = { '.git', 'pyproject.toml', 'setup.py' },
        }
      },
      flow = {
        sourceName = 'flow',
        command = 'flow',
        debounce = 100,
        args = { 'check-contents', '--json', '<', '%filepath' },
        parseJson = {
          errorsRoot = 'errors',
          line = 'message[0].loc.start.line',
          column = 'message[0].loc.start.column',
          endLine = 'message[0].loc.end.line',
          endColumn = 'message[0].loc.end.column',
          message = '[flow] ${message[0].descr}',
          security = 'level',
        },
        securities = { error = 'error', warning = 'warning' },
        rootPatterns = { '.flowconfig', '.git' },
      },
      filetypes = {
        sh = 'shellcheck',
        javascript = {'eslint', 'flow'},
        javascriptreact = 'eslint',
        typescript = 'eslint',
        typescriptreact = 'eslint',
        ruby = {'reek', 'rubocop'},
        python = {'flake8', 'pylint'},
      },
      formatters = {
        eslint_d = {
          sourceName = 'eslint_d_fmt',
          command = 'eslint_d',
          args = {
            '--fix-to-stdout',
            '--stdin',
            '--stdin-filename',
            '%filepath',
          },
          rootPatterns = {
            '.eslintrc',
            '.eslintrc.cjs',
            '.eslintrc.js',
            '.eslintrc.json',
            '.eslintrc.yaml',
            '.eslintrc.yml',
          },
        },
        prettier = {
          command = 'prettier_d_slim',
          args = { '--stdin', '--stdin-filepath', '%filepath' },
          rootPatterns = { '.git' },
          -- requiredFiles: { 'prettier.config.js' },
          args = { '--stdin', '--stdin-filepath', '%filename' },
        },
        autoflake = {
          sourceName = 'autoflake',
          command = 'autoflake',
          args = { '--in-place', '%file' },
          isStderr = false,
          isStdout = false,
          doesWriteToFile = true,
          rootPatterns = { '.git' },
        },
        autopep8 = {
          sourceName = 'autopep8',
          command = 'autopep8',
          args = { '-' },
          rootPatterns = { 'requirements.txt', '.git' },
        },
        black = {
          sourceName = 'black',
          command = 'black',
          args = { '--quiet', '-' },
          rootPatterns = {
            '.git',
            'pyproject.toml',
            'setup.py',
          },
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
        python = { 'black', 'autopep8' },
      }
    }
  },
  ['flow'] = {},
  ['gopls'] = {},
  ['graphql'] = {},
  ['html'] = {},
  --['jdtls'] = {},
  ['pyright'] = {},
  ['rust_analyzer'] = {
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  },
  ['solargraph'] = {},
  ['terraformls'] = {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform" },
  },
  ['tsserver'] = {},
  ['vimls'] = {},
  ['yamlls'] = {},
}

require("mason").setup {
}
require("mason-lspconfig").setup {
  automatic_installation = true,
  ensure_installed = {
    "awk_ls",
    "angularls",
    "ansiblels",
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "diagnosticls",
    "dockerls",
    "elixirls",
    "emmet_ls",
    --"erlang_ls",
    "gopls",
    "graphql",
    "groovyls",
    "html",
    "jsonls",
    "jdtls",
    "tsserver",
    "ltex",
    --"sumneko_lua",
    "zk",
    "pyright",
    "solargraph",
    "rust_analyzer",
    "taplo",
    "terraformls",
    "tflint",
    "tsserver",
    "yamlls",
    --"flake8",
    --"golangci-lint",
    --"pylama",
    --"markdownlint",
    --"pylint",
    "rome",
    --"xo",
    --"yamllint",
    --"shellharden",
    --"rubocop",
    --"shellcheck",
    "eslint"
  },
}

for lsp, _config in pairs(servers) do
  lspconfig[lsp].setup(config(_config or {}))
end

