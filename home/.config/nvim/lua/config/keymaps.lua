-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", ":<C-U>TmuxNavigateLeft", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", ":<C-U>TmuxNavigateDown", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", ":<C-U>TmuxNavigateUp", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", ":<C-U>TmuxNavigateRight", { desc = "Go to right window", remap = true })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Esc" })
vim.keymap.set("i", "Jj", "<Esc>", { desc = "Esc" })
vim.keymap.set("i", "uuu", "_", { desc = "Insert underscore" })
vim.keymap.set("i", "hhh", "=>", { desc = "Insert hash rocket" })
vim.keymap.set("i", "aaa", "@", { desc = "Insert @" })

vim.keymap.set("i", "<C-t>", ":tabnew<CR>", { desc = "Create tab" })
vim.keymap.set("n", "<C-t>", "<Esc>:tabnew<CR>", { desc = "Create tab" })

-- turn off highlighting
vim.keymap.set("n", "<leader>h", ":nohl<CR>", { desc = "turn off highlighting" })
