return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    lazy = false,
    build = ":TSUpdate",
  },
}
