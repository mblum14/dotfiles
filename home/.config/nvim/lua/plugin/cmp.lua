local cmp = require "cmp"
local lspkind = require "lspkind"

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }, _config or {})
end

lspkind.init({
  mode = 'symbol_text',
  preset = 'codicons',
})

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
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      before = function (entry, vim_item)
        return vim_item
      end
    })
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

-- Setup lspconfig.
snippet_support = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true
      }
    }
  }
}
require('lspconfig').awk_ls.setup(config({}))
require('lspconfig').bashls.setup(config({}))
require('lspconfig').cssmodules_ls.setup(config({}))
require('lspconfig').diagnosticls.setup(config({}))
require('lspconfig').dockerls.setup(config({}))
require('lspconfig').elixirls.setup(config({
  cmd = { "elixir-ls" }
}))
require('lspconfig').emmet_ls.setup(config({}))
require('lspconfig').eslint.setup(config({}))
require('lspconfig').gopls.setup(config({}))
require('lspconfig').graphql.setup(config({}))
require('lspconfig').html.setup(config(snippet_support))
require('lspconfig').jedi_language_server.setup(config({}))
require('lspconfig').jsonls.setup(config(snippet_support))
require('lspconfig').pyright.setup(config({}))
require('lspconfig').rust_analyzer.setup(config({
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
}))
require('lspconfig').solargraph.setup(config({}))
require('lspconfig').terraform_lsp.setup(config({}))
require('lspconfig').tsserver.setup(config({}))
require('lspconfig').vimls.setup(config({}))
require('lspconfig').yamlls.setup(config({
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      }
    }
  }
}))