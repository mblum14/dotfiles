local present, lspcolors = pcall(require, "lsp-colors")
if (not present) then return end

lspcolors.setup({
  Error = "#fb4934",
  Warning = "#fabd2f",
  Information = "#83a598",
  Hint = "#fbf1c7",
})
