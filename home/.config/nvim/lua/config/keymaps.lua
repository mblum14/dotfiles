-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "Jj", "<Esc>")
vim.keymap.set("i", "uuu", "_")
vim.keymap.set("i", "hhh", "=>")
vim.keymap.set("i", "aaa", "@", {})

-- yank to end of line from current position
vim.keymap.set("n", "Y", "y$", { remap = false })

vim.keymap.set("n", "]q", ":cnext<CR>zz", { remap = false })
vim.keymap.set("n", "[q", ":cprev<CR>zz", { remap = false })
vim.keymap.set("n", "]l", ":lnext<CR>zz", { remap = false })
vim.keymap.set("n", "[l", ":lprev<CR>zz", { remap = false })

vim.keymap.set("n", "<leader>h", ":nohl<CR>")

-- keeping it centered
vim.keymap.set("n", "n", "nzzzv", { remap = false })
vim.keymap.set("n", "N", "Nzzzv", { remap = false })
vim.keymap.set("n", "J", "mzJ`z", { remap = false })
vim.keymap.set("n", "<C-j>", ":cnext<CR>zzzv", { remap = false })

-- tmux
vim.keymap.set("n", "<c-h>", ":NvimTmuxNavigateLeft<CR>", { remap = false })
vim.keymap.set("n", "<c-j>", ":NvimTmuxNavigateDown<CR>", { remap = false })
vim.keymap.set("n", "<c-k>", ":NvimTmuxNavigateUp<CR>", { remap = false })
vim.keymap.set("n", "<c-l>", ":NvimTmuxNavigateRight<CR>", { remap = false })
