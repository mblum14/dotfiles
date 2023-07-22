-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ================ Turn Off Swap Files ==============

vim.opt.history = 1000
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- ================ Persistent Undo ==================
-- Keep undo history across sessions, by storing in file.
-- Only works all the time.
vim.opt.undodir = "~/.local/backups"
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- ================ Trailing Whitespace ==============
--vim.opt.list = true
--vim.opt.listchars
--vim.opt.listchars+=tab:→\
--vim.opt.listchars+=trail:·
--vim.opt.listchars+=extends:»              " show cut off when nowrap
--vim.opt.listchars+=precedes:«
--vim.opt.listchars+=nbsp:⣿
