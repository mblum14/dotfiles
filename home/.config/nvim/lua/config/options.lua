-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- turn off swapfiles
vim.opt.swapfile    = false
vim.opt.backup      = false
vim.opt.writebackup = false

--persistent undo
vim.opt.undodir     = "/alt/.local/state/nvim/backups"
vim.opt.undofile    = true
vim.opt.undolevels  = 1000
vim.opt.undoreload  = 10000
