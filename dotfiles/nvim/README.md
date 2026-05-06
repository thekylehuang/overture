# Overture.nvim

![Dashboard Screenshot](https://github.com/thekylehuang/nvim/releases/download/media/dashboard.png)

A minimal Neovim configuration for my web development and Rust workflows. This is built on top of [Lazy.nvim](https://github.com/LazyVim/LazyVim). The colorscheme used is Cole.

## Plugins Used

- blink.cmp
- dashboard-nvim
- nvim-lspconfig
- mason
- lualine
- oil.nvim
- mini.pairs
- smear-cursor
- telescope.nvim
- nvim-treesitter
- nvim-notify

## Installation

To get Overture.nvim on Linux/MacOS, run the following command to clone the repo:

```bash
git clone https://github.com/thekylehuang/nvim.git ~/.config/nvim
```

Then delete the .git folder so you can make your own variants.

```bash
rm -rf .git
```

Then simply run `nvim` to automatically install all the plugins used in Overture.nvim. Happy programming!
