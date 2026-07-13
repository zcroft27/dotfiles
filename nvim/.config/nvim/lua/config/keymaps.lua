-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>e", "<cmd>lua Snacks.explorer({ cwd = vim.fn.getcwd() })<CR>", { desc = "Explorer (cwd)" })
vim.keymap.set("n", "<leader>E", "<cmd>lua Snacks.explorer()<CR>", { desc = "Explorer (root)" })
