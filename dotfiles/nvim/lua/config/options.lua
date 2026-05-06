-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Default 2 space tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

-- Override 4 space tabs for Rust
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Make yank use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Remove end of buffer highlight
vim.opt.fillchars = { eob = " " }

-- Remove sign column
vim.diagnostic.config({virtual_text = true, signs = false})

-- Enable line softwrap
vim.opt.wrap = true
vim.opt.linebreak = true
