local present, lspconfig = pcall(require, "lspconfig")
require('utils')

if not present then
   return
end

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map("n", 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  map("n", 'gk', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  map("n", '<leader>wa', "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  map("n", '<leader>wr', "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  map("n", '<leader>wl', "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  map("n", '<leader>D', "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  map("n", '<leader>ra', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  map("n", '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  map("n", 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  map("n", 'ge', "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  map("n", '[d', "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  map("n", ']d', "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  map("n", '<leader>q', "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  map("n", '<leader>fm', "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

lspconfig.tsserver.setup {
  on_attach = on_attach
}
