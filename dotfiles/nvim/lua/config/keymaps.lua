-- Oil.nvim
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })

-- Telescope.nvim
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", { desc = "Live grep" })
