-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_augroup("ValidateGitlabCIfiles", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    require("validate-gitlab-ci.validate-gitlab-ci").validate()
  end,
  group = "ValidateGitlabCIfiles",
  desc = "Validate Gitlab CI  files on save",
  pattern = ".gitlab-ci.yml",
})
