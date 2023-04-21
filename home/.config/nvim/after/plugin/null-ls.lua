local present, null_ls = pcall(require, "null-ls")
if (not present) then return end

null_ls.setup({
    sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.cfn_lint,
        null_ls.builtins.diagnostics.eslint,
    },
})
