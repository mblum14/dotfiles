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
