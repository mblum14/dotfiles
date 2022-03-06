# ./conf/nvim/after/plugin/bufferline.rc.lua

```lua
local present, bufferline = pcall(require, "bufferline")
require("utils")

if (not present) then return end

local default = {
   colors = require("colors").get(),
}

default = {
   options = {
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      buffer_close_icon = "",
      modified_icon = "",
      close_icon = "",
      show_close_icon = true,
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      diagnostics = false,
      custom_filter = function(buf_number)
         -- Func to filter out our managed/persistent split terms
         local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, "term_type")
         end)

         if present_type then
            if type == "vert" then
               return false
            elseif type == "hori" then
               return false
            end
            return true
         end

         return true
      end,
   },

   highlights = {
      background = {
         guifg = default.colors.grey_fg,
         guibg = default.colors.black2,
      },

      -- buffers
      buffer_selected = {
         guifg = default.colors.white,
         guibg = default.colors.black,
         gui = "bold",
      },
      buffer_visible = {
         guifg = default.colors.light_grey,
         guibg = default.colors.black2,
      },

      -- for diagnostics = "nvim_lsp"
      error = {
         guifg = default.colors.light_grey,
         guibg = default.colors.black2,
      },
      error_diagnostic = {
         guifg = default.colors.light_grey,
         guibg = default.colors.black2,
      },

      -- close buttons
      close_button = {
         guifg = default.colors.light_grey,
         guibg = default.colors.black2,
      },
      close_button_visible = {
         guifg = default.colors.light_grey,
         guibg = default.colors.black2,
      },
      close_button_selected = {
         guifg = default.colors.red,
         guibg = default.colors.black,
      },
      fill = {
         guifg = default.colors.grey_fg,
         guibg = default.colors.black2,
      },
      indicator_selected = {
         guifg = default.colors.black,
         guibg = default.colors.black,
      },

      -- modified
      modified = {
         guifg = default.colors.red,
         guibg = default.colors.black2,
      },
      modified_visible = {
         guifg = default.colors.red,
         guibg = default.colors.black2,
      },
      modified_selected = {
         guifg = default.colors.green,
         guibg = default.colors.black,
      },

      -- separators
      separator = {
         guifg = default.colors.black2,
         guibg = default.colors.black2,
      },
      separator_visible = {
         guifg = default.colors.black2,
         guibg = default.colors.black2,
      },
      separator_selected = {
         guifg = default.colors.black2,
         guibg = default.colors.black2,
      },

      -- tabs
      tab = {
         guifg = default.colors.light_grey,
         guibg = default.colors.one_bg3,
      },
      tab_selected = {
         guifg = default.colors.black2,
         guibg = default.colors.nord_blue,
      },
      tab_close = {
         guifg = default.colors.red,
         guibg = default.colors.black,
      },
   },
}

map("n", '<TAB>', ":BufferLineCycleNext<CR>")
map("n", '<S-TAB>', ":BufferLineCyclePrev<CR>")

bufferline.setup(default)
```


# ./conf/nvim/after/plugin/cmp.rc.lua

```lua
local present_cmp, cmp = pcall(require, "cmp")
local present_lspkind, lspkind = pcall(require, "lspkind")
if (not present_cmp) then return end
if (not present_lspkind) then return end

vim.lsp.set_log_level("debug")

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  path = "[Path]",
  look = "[Look]",
  spell = "[Spell]",
  calc = "[Calc]",
  emoji = "[Emoji}",
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'spell' },
    { name = 'calc' },
    { name = 'emoji' },
  }),
  formatting = {
    format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
			local menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. " " .. menu
				end
				vim_item.kind = ""
			end
			vim_item.menu = menu
			return vim_item
		end,
  }
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
```
# ./conf/nvim/after/plugin/colorizer.rc.lua
```lua
local present, colorizer = pcall(require, "colorizer")
if (not present) then return end

local colorizer_conf = {
  filetypes = {
    "*",
  },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

    -- Available modes: foreground, background
    mode = "background", -- Set the display mode.
  },
}
colorizer.setup(colorizer_conf["filetypes"], colorizer_conf["user_default_options"])
--vim.cmd "ColorizerReloadAllBuffers"
```

# ./conf/nvim/after/plugin/devicons.rc.lua

```lua
local present, icons = pcall(require, "nvim-web-devicons")
if (not present) then return end

local default = {
   colors = require("colors").get(),
}

default = {
   override = {
      c = {
         icon = "",
         color = default.colors.blue,
         name = "c",
      },
      css = {
         icon = "",
         color = default.colors.blue,
         name = "css",
      },
      deb = {
         icon = "",
         color = default.colors.cyan,
         name = "deb",
      },
      Dockerfile = {
         icon = "",
         color = default.colors.cyan,
         name = "Dockerfile",
      },
      html = {
         icon = "",
         color = default.colors.baby_pink,
         name = "html",
      },
      jpeg = {
         icon = "",
         color = default.colors.dark_purple,
         name = "jpeg",
      },
      jpg = {
         icon = "",
         color = default.colors.dark_purple,
         name = "jpg",
      },
      js = {
         icon = "",
         color = default.colors.sun,
         name = "js",
      },
      kt = {
         icon = "󱈙",
         color = default.colors.orange,
         name = "kt",
      },
      lock = {
         icon = "",
         color = default.colors.red,
         name = "lock",
      },
      lua = {
         icon = "",
         color = default.colors.blue,
         name = "lua",
      },
      mp3 = {
         icon = "",
         color = default.colors.white,
         name = "mp3",
      },
      mp4 = {
         icon = "",
         color = default.colors.white,
         name = "mp4",
      },
      out = {
         icon = "",
         color = default.colors.white,
         name = "out",
      },
      png = {
         icon = "",
         color = default.colors.dark_purple,
         name = "png",
      },
      py = {
         icon = "",
         color = default.colors.cyan,
         name = "py",
      },
      ["robots.txt"] = {
         icon = "ﮧ",
         color = default.colors.red,
         name = "robots",
      },
      toml = {
         icon = "",
         color = default.colors.blue,
         name = "toml",
      },
      ts = {
         icon = "ﯤ",
         color = default.colors.teal,
         name = "ts",
      },
      ttf = {
         icon = "",
         color = default.colors.white,
         name = "TrueTypeFont",
      },
      rb = {
         icon = "",
         color = default.colors.pink,
         name = "rb",
      },
      rpm = {
         icon = "",
         color = default.colors.orange,
         name = "rpm",
      },
      vue = {
         icon = "﵂",
         color = default.colors.vibrant_green,
         name = "vue",
      },
      woff = {
         icon = "",
         color = default.colors.white,
         name = "WebOpenFontFormat",
      },
      woff2 = {
         icon = "",
         color = default.colors.white,
         name = "WebOpenFontFormat2",
      },
      xz = {
         icon = "",
         color = default.colors.sun,
         name = "xz",
      },
      zip = {
         icon = "",
         color = default.colors.sun,
         name = "zip",
      },
   },
}

icons.setup(default)
```

# ./conf/nvim/after/plugin/diagnosticls.rc.lua

```lua
-- Gutter Signs
local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true, -- underline offending tex
    signs = true,     -- gutter
    virtual_text = {  -- (i.e., codesense)
      spacing = 2,
      prefix = ''
    }
  }
)
```

# ./conf/nvim/after/plugin/indent_blankline.rc.lua

```lua

local present, indent_blankline = pcall(require, "indent_blankline")
if (not present) then return end

indent_blankline.setup {
  indentLine_enabled = 1,
  char = "▏",
  filetype_exclude = {
    "help",
    "terminal",
    "alpha",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "nvchad_cheatsheet",
    "lsp-installer",
    "",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
}
```

# ./conf/nvim/after/plugin/lsp_colors.rc.lua

```lua
local present, lspcolors = pcall(require, "lsp-colors")
if (not present) then return end

lspcolors.setup({
  Error = "#fb4934",
  Warning = "#fabd2f",
  Information = "#83a598",
  Hint = "#fbf1c7",
})
```

# ./conf/nvim/after/plugin/lsp.rc.lua

```lua
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
  buf_set_keymap("n", 'ge', "<cmd>TroubleToggle<CR>", opts)
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
    filetypes = {
      'ruby',
      'javascript',
      'javascriptreact',
      'python',
      'typescript',
      'typescriptreact',
      'bash',
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
        bash = 'shellcheck',
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
```

# ./conf/nvim/after/plugin/lspkind.rc.lua

```lua
local present, lspkind = pcall(require, "lspkind")

if (not present) then return end

lspkind.init({
  mode = 'symbol_text',
  preset = 'codicons',
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
  }
})
```

# ./conf/nvim/after/plugin/statusline.rc.lua

```lua
local present, feline = pcall(require, "feline")
if (not present) then return end

local default = {
   colors = require("colors").get(),
   lsp = require "feline.providers.lsp",
   lsp_severity = vim.diagnostic.severity,
   config = {
     hidden = {
       "help",
       "NvimTree",
       "terminal",
       "alpha"
     },
     shown = {},
     shortline = true,
     style = "arrow"
   }
}

default.icon_styles = {
   default = {
      left = "",
      right = " ",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },
   arrow = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },

   block = {
      left = " ",
      right = " ",
      main_icon = "   ",
      vi_mode_icon = "  ",
      position_icon = "  ",
   },

   round = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },

   slant = {
      left = " ",
      right = " ",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },
}

-- statusline style
default.statusline_style = default.icon_styles[default.config.style]

-- show short statusline on small screens
default.shortline = default.config.shortline == false and true

-- Initialize the components table
default.components = {
   active = {},
}

default.main_icon = {
   provider = default.statusline_style.main_icon,

   hl = {
      fg = default.colors.statusline_bg,
      bg = default.colors.nord_blue,
   },

   right_sep = {
      str = default.statusline_style.right,
      hl = {
         fg = default.colors.nord_blue,
         bg = default.colors.lightbg,
      },
   },
}

default.file_name = {
   provider = function()
      local filename = vim.fn.expand "%:t"
      local extension = vim.fn.expand "%:e"
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      if icon == nil then
         icon = " "
         return icon
      end
      return " " .. icon .. " " .. filename .. " "
   end,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = {
      fg = default.colors.white,
      bg = default.colors.lightbg,
   },

   right_sep = {
      str = default.statusline_style.right,
      hl = { fg = default.colors.lightbg, bg = default.colors.lightbg2 },
   },
}

default.dir_name = {
   provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
   end,

   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
   end,

   hl = {
      fg = default.colors.grey_fg2,
      bg = default.colors.lightbg2,
   },
   right_sep = {
      str = default.statusline_style.right,
      hi = {
         fg = default.colors.lightbg2,
         bg = default.colors.statusline_bg,
      },
   },
}

default.diff = {
   add = {
      provider = "git_diff_added",
      hl = {
         fg = default.colors.grey_fg2,
         bg = default.colors.statusline_bg,
      },
      icon = " ",
   },

   change = {
      provider = "git_diff_changed",
      hl = {
         fg = default.colors.grey_fg2,
         bg = default.colors.statusline_bg,
      },
      icon = "  ",
   },

   remove = {
      provider = "git_diff_removed",
      hl = {
         fg = default.colors.grey_fg2,
         bg = default.colors.statusline_bg,
      },
      icon = "  ",
   },
}

default.git_branch = {
   provider = "git_branch",
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = {
      fg = default.colors.grey_fg2,
      bg = default.colors.statusline_bg,
   },
   icon = "  ",
}

default.diagnostic = {
   error = {
      provider = "diagnostic_errors",
      enabled = function()
         return default.lsp.diagnostics_exist(default.lsp_severity.ERROR)
      end,

      hl = { fg = default.colors.red },
      icon = "  ",
   },

   warning = {
      provider = "diagnostic_warnings",
      enabled = function()
         return default.lsp.diagnostics_exist(default.lsp_severity.WARN)
      end,
      hl = { fg = default.colors.yellow },
      icon = "  ",
   },

   hint = {
      provider = "diagnostic_hints",
      enabled = function()
         return default.lsp.diagnostics_exist(default.lsp_severity.HINT)
      end,
      hl = { fg = default.colors.grey_fg2 },
      icon = "  ",
   },

   info = {
      provider = "diagnostic_info",
      enabled = function()
         return default.lsp.diagnostics_exist(default.lsp_severity.INFO)
      end,
      hl = { fg = default.colors.green },
      icon = "  ",
   },
}

default.lsp_progress = {
   provider = function()
      local Lsp = vim.lsp.util.get_progress_messages()[1]

      if Lsp then
         local msg = Lsp.message or ""
         local percentage = Lsp.percentage or 0
         local title = Lsp.title or ""
         local spinners = {
            "",
            "",
            "",
         }

         local success_icon = {
            "",
            "",
            "",
         }

         local ms = vim.loop.hrtime() / 1000000
         local frame = math.floor(ms / 120) % #spinners

         if percentage >= 70 then
            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
         end

         return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end

      return ""
   end,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
   end,
   hl = { fg = default.colors.green },
}

default.lsp_icon = {
   provider = function()
      if next(vim.lsp.buf_get_clients()) ~= nil then
         return "  LSP"
      else
         return ""
      end
   end,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
   end,
   hl = { fg = default.colors.grey_fg2, bg = default.colors.statusline_bg },
}

default.mode_colors = {
   [110] = { "NORMAL", default.colors.red},
   [105] = { "INSERT", default.colors.dark_purple },
   [99] = { "COMAND", default.colors.pink },
   [116] = { "TERMINAL", default.colors.green },
   [118] = { "VISUAL", default.colors.cyan },
   [22] = { "V-BLOCK", default.colors.cyan },
   [86] = { "V_LINE", default.colors.cyan },
   [82] = { "REPLACE", default.colors.orange },
   [115] = { "SELECT", default.colors.nord_blue },
   [83] = { "S-LINE", default.colors.nord_blue },
}

local mode = function(n)
  return default.mode_colors[vim.fn.mode():byte()][n]
end

default.chad_mode_hl = function()
   return {
      fg = mode(2),
      bg = default.colors.one_bg,
   }
end

default.empty_space = {
   provider = " " .. default.statusline_style.left,
   hl = {
      fg = default.colors.one_bg2,
      bg = default.colors.statusline_bg,
   },
}

-- this matches the vi mode color
default.empty_spaceColored = {
   provider = default.statusline_style.left,
   hl = function()
      return {
         fg = mode(2),
         bg = default.colors.one_bg2,
      }
   end,
}

default.mode_icon = {
   provider = default.statusline_style.vi_mode_icon,
   hl = function()
      return {
         fg = default.colors.statusline_bg,
         bg = mode(2),
      }
   end,
}

default.empty_space2 = {
   provider = function()
      return " " .. mode(1) .. " "
   end,
   hl = default.chad_mode_hl,
}

default.separator_right = {
   provider = default.statusline_style.left,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   end,
   hl = {
      fg = default.colors.grey,
      bg = default.colors.one_bg,
   },
}

default.separator_right2 = {
   provider = default.statusline_style.left,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   end,
   hl = {
      fg = default.colors.green,
      bg = default.colors.grey,
   },
}

default.position_icon = {
   provider = default.statusline_style.position_icon,
   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   end,
   hl = {
      fg = default.colors.black,
      bg = default.colors.green,
   },
}

default.current_line = {
   provider = function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      if current_line == 1 then
         return " Top "
      elseif current_line == vim.fn.line "$" then
         return " Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return " " .. result .. "%% "
   end,

   enabled = default.shortline or function(winid)
      return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
   end,

   hl = {
      fg = default.colors.green,
      bg = default.colors.one_bg,
   },
}

local function add_table(a, b)
   table.insert(a, b)
end

-- components are divided in 3 sections
default.left = {}
default.middle = {}
default.right = {}

-- left
add_table(default.left, default.main_icon)
add_table(default.left, default.file_name)
add_table(default.left, default.dir_name)
add_table(default.left, default.diff.add)
add_table(default.left, default.diff.change)
add_table(default.left, default.diff.remove)
add_table(default.left, default.diagnostic.error)
add_table(default.left, default.diagnostic.warning)
add_table(default.left, default.diagnostic.hint)
add_table(default.left, default.diagnostic.info)

add_table(default.middle, default.lsp_progress)

-- right
add_table(default.right, default.lsp_icon)
add_table(default.right, default.git_branch)
add_table(default.right, default.empty_space)
add_table(default.right, default.empty_spaceColored)
add_table(default.right, default.mode_icon)
add_table(default.right, default.empty_space2)
add_table(default.right, default.separator_right)
add_table(default.right, default.separator_right2)
add_table(default.right, default.position_icon)
add_table(default.right, default.current_line)

default.components.active[1] = default.left
default.components.active[2] = default.middle
default.components.active[3] = default.right

feline.setup {
   theme = {
      bg = default.colors.statusline_bg,
      fg = default.colors.fg,
   },
   components = default.components,
}
```

# ./conf/nvim/after/plugin/treesitter.rc.lua

```lua
local present, treesitter = pcall(require, "nvim-treesitter.configs")
if (not present) then return end

treesitter.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "clojure",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "elixir",
    "erlang",
    "fish",
    "go",
    "graphql",
    "hcl",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "latex",
    "lua",
    "make",
    "perl",
    "python",
    "regex",
    "ruby",
    "scala",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  autotag = {
    enable = true,
  },
  matchup = {
    enable = true,
    disable = { },
  }
}

local parser_configs = require "nvim-treesitter.parsers".get_parser_configs()
parser_configs.tsx.used_by = { "javascript", "typescript.tsx" }
```

# ./conf/nvim/after/plugin/trouble.rc.lua

```lua
local present, trouble = pcall(require, "trouble")
if (not present) then return end

trouble.setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
}
```

# ./conf/nvim/lua/colors.lua

```lua
local M = {}
local cmd = vim.cmd

local colors = {
  white = "#c7b89c",
  darker_black = "#1e2122",
  black = "#222526", -- nvim bg
  black2 = "#26292a",
  one_bg = "#2b2e2f",
  one_bg2 = "#2f3233",
  one_bg3 = "#313435",
  grey = "#46494a",
  grey_fg = "#5d6061",
  grey_fg2 = "#5b5e5f",
  light_grey = "#585b5c",
  red = "#ec6b64",
  baby_pink = "#ce8196",
  pink = "#ff75a0",
  line = "#2c2f30", -- for lines like vertsplit
  green = "#89b482",
  vibrant_green = "#a9b665",
  nord_blue = "#6f8faf",
  blue = "#6d8dad",
  yellow = "#d6b676",
  sun = "#d1b171",
  purple = "#b4bbc8",
  dark_purple = "#cc7f94",
  teal = "#7f9689",
  orange = "#e78a4e",
  cyan = "#82b3a8",
  statusline_bg = "#252829",
  lightbg = "#2d3139",
  lightbg2 = "#262a32",
  pmenu_bg = "#89b482",
  folder_bg = "#6d8dad",
  base00 = "282828",
  base01 = "3c3836",
  base02 = "504945",
  base03 = "665c54",
  base04 = "bdae93",
  base05 = "d5c4a1",
  base06 = "ebdbb2",
  base07 = "fbf1c7",
  base08 = "fb4934",
  base09 = "fe8019",
  base0A = "fabd2f",
  base0B = "b8bb26",
  base0C = "8ec07c",
  base0D = "83a598",
  base0E = "d3869b",
  base0F = "d65d0e",
}

M.init = function()
  local black = colors.black
  local black2 = colors.black2
  local blue = colors.blue
  local darker_black = colors.darker_black
  local folder_bg = colors.folder_bg
  local green = colors.green
  local grey = colors.grey
  local grey_fg = colors.grey_fg
  local light_grey = colors.light_grey
  local line = colors.line
  local nord_blue = colors.nord_blue
  local one_bg = colors.one_bg
  local one_bg2 = colors.one_bg2
  local pmenu_bg = colors.pmenu_bg
  local purple = colors.purple
  local red = colors.red
  local white = colors.white
  local yellow = colors.yellow
  local orange = colors.orange
  local one_bg3 = colors.one_bg3
  
  -- functions for setting highlights
  local fg = function(group, col)
     cmd("hi " .. group .. " guifg=" .. col)
  end
  local fg_bg = function(group, fgcol, bgcol)
     cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
  end
  local bg = function(group, col)
     cmd("hi " .. group .. " guibg=" .. col)
  end
  
  -- Comments
  fg("Comment", grey_fg)
  
  -- Disable cursor line
  cmd "hi clear CursorLine"
  -- Line number
  fg("cursorlinenr", white)
  
  -- same it bg, so it doesn't appear
  fg("EndOfBuffer", black)
  
  -- For floating windows
  fg("FloatBorder", blue)
  bg("NormalFloat", darker_black)
  
  -- Pmenu
  bg("Pmenu", one_bg)
  bg("PmenuSbar", one_bg2)
  bg("PmenuSel", pmenu_bg)
  bg("PmenuThumb", nord_blue)
  fg("CmpItemAbbr", white)
  fg("CmpItemAbbrMatch", white)
  fg("CmpItemKind", white)
  fg("CmpItemMenu", white)
  
  -- misc
  
  -- inactive statuslines as thin lines
  fg("StatusLineNC", one_bg3 .. " gui=underline")
  
  fg("LineNr", grey)
  fg("NvimInternalError", red)
  fg("VertSplit", one_bg2)
  
  -- transparency
  bg("Normal", "NONE")
  bg("Folded", "NONE")
  fg("Folded", "NONE")
  fg("Comment", grey)
  -- telescope
  bg("TelescopeBorder", "NONE")
  bg("TelescopePrompt", "NONE")
  bg("TelescopeResults", "NONE")
  bg("TelescopePromptBorder", "NONE")
  bg("TelescopePromptNormal", "NONE")
  bg("TelescopeNormal", "NONE")
  bg("TelescopePromptPrefix", "NONE")
  fg("TelescopeBorder", one_bg)
  fg_bg("TelescopeResultsTitle", black, blue)
  
  -- [[ Plugin Highlights
  
  -- Dashboard
  fg("AlphaHeader", grey_fg)
  fg("AlphaButtons", light_grey)
  
  -- Git signs
  fg_bg("DiffAdd", blue, "NONE")
  fg_bg("DiffChange", grey_fg, "NONE")
  fg_bg("DiffChangeDelete", red, "NONE")
  fg_bg("DiffModified", red, "NONE")
  fg_bg("DiffDelete", red, "NONE")
  
  -- Indent blankline plugin
  fg("IndentBlanklineChar", line)
  fg("IndentBlanklineSpaceChar", line)
  
  -- Lsp diagnostics
  
  fg("DiagnosticHint", purple)
  fg("DiagnosticError", red)
  fg("DiagnosticWarn", yellow)
  fg("DiagnosticInformation", green)
  
  -- Telescope
  fg_bg("TelescopeBorder", darker_black, darker_black)
  fg_bg("TelescopePromptBorder", black2, black2)
  
  fg_bg("TelescopePromptNormal", white, black2)
  fg_bg("TelescopePromptPrefix", red, black2)
  
  bg("TelescopeNormal", darker_black)
  
  fg_bg("TelescopePreviewTitle", black, green)
  fg_bg("TelescopePromptTitle", black, red)
  fg_bg("TelescopeResultsTitle", darker_black, darker_black)
  
  bg("TelescopeSelection", black2)
  
  local section_title_colors = {
     white,
     blue,
     red,
     green,
     yellow,
     purple,
     orange,
  }
  for i, color in ipairs(section_title_colors) do
     vim.cmd("highlight CheatsheetTitle" .. i .. " guibg = " .. color .. " guifg=" .. black)
  end
end

M.get = function()
  return colors
end

return M
```

# ./conf/nvim/lua/utils.lua

```lua
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
```

# ./conf/nvim/plugin/conf.vim

```vim
" ================ General Config ====================

behave mswin
syntax on
set number
set history=1000
set showcmd
set showmode
set visualbell
set autoread
set shell=/bin/bash
set tags=./tags
set hidden


" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" ================ Search Settings  =================

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowritebackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.local/backups > /dev/null 2>&1
set undodir=~/.local/backups
set undofile
set undolevels=1000
set undoreload=10000

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set cindent
set cinwords=if,else,while,do,for,switch,case,module,def,class,elsif

set nowrap
set linebreak
set nojoinspaces

" ================ Trailing Whitespace ==============
set list
set listchars=
set listchars+=tab:→\ 
set listchars+=trail:·
set listchars+=extends:»              " show cut off when nowrap
set listchars+=precedes:«
set listchars+=nbsp:⣿

" ================ Folds ============================

set foldmethod=indent
set foldnestmax=3
set nofoldenable

" ================ Window Splitting =================

set splitbelow
set splitright
set fillchars=vert:│                  " Vertical sep between windows (unicode)
set hidden                            " remember undo after quitting
" reveal already opened files from the quickfix window instead of opening new
" buffers
set switchbuf=useopen
set nostartofline                     " don't jump to col1 on switch buffer

" ================ Completion =======================

set completeopt=menu,menuone,noselect
set spelllang=en_us

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*sass-cache*
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=/node_modules/*
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so
set wildignore+=*.swp
set wildignore+=*.zip

" ================ Colors ===========================
set termguicolors
set background=dark
colorscheme gruvbox
let colorcolumn="120"
highlight colorcolumn ctermbg='0'
set syntax=automatic
set cursorline
highlight clear SignColumn
highlight clear LineNr

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set cmdheight=2
set shortmess+=c
```

# ./conf/nvim/plugin/fzf.vim

```vim
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

nnoremap <c-p> :GFiles<CR>

inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

augroup fzf
  autocmd! FileType fzf
  autocmd! FileType fzf set laststatus=0 noshowmode noruler nonu
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_git_files_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'

nmap <space>s [fzf-s]
xmap <space>s [fzf-s]c
nnoremap <silent> [fzf-s]/ :Rg<CR>
nnoremap <c-p>/ :Rg<CR>
nnoremap <silent> [fzf-s]r :Rg<CR>
nnoremap <silent> [fzf-s]p  :GFiles<CR>

nmap <space>f [fzf-f]
xmap <space>f [fzf-f]

nnoremap <silent> [fzf-f]p     :<C-u>FzfPreviewFromResourcesRpc project_mru git<CR>
nnoremap <silent> [fzf-f]gs    :<C-u>FzfPreviewGitStatusRpc<CR>
nnoremap <silent> [fzf-f]ga    :<C-u>FzfPreviewGitActionsRpc<CR>
nnoremap <silent> [fzf-f]b     :<C-u>FzfPreviewBuffersRpc<CR>
nnoremap <silent> [fzf-f]B     :<C-u>FzfPreviewAllBuffersRpc<CR>
nnoremap <silent> [fzf-f]o     :<C-u>FzfPreviewFromResourcesRpc buffer project_mru<CR>
nnoremap <silent> [fzf-f]<C-o> :<C-u>FzfPreviewJumpsRpc<CR>
nnoremap <silent> [fzf-f]g;    :<C-u>FzfPreviewChangesRpc<CR>
nnoremap <silent> [fzf-f]/     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-f]*     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-f]gr    :<C-u>FzfPreviewProjectGrepRpc<Space>
xnoremap          [fzf-f]gr    "sy:FzfPreviewProjectGrepRpc<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-f]t     :<C-u>FzfPreviewBufferTagsRpc<CR>
nnoremap <silent> [fzf-f]q     :<C-u>FzfPreviewQuickFixRpc<CR>
nnoremap <silent> [fzf-f]l     :<C-u>FzfPreviewLocationListRpc<CR>
```
