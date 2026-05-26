vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars = { eob = " " }

vim.diagnostic.config({virtual_text = true, signs = false})

vim.opt.wrap = true
vim.opt.linebreak = true

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/thekylehuang/cole.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/chomosuke/typst-preview.nvim",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvimdev/dashboard-nvim",
  "https://github.com/karb94/neoscroll.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/folke/snacks.nvim",
})

local colors = {
  black = "#101010",
  red = "#cc5d4b",
  green = "#2e9969",
  yellow = "#b38d59",
  blue = "#6179c2",
  magenta = "#ab78ab",
  white = "#f2e6cf",
  gray = "#121212",
  lightgray = "#1c1c1c",
  inactivegray = "#0f0f0f"
}

local cole = {
  normal = {
    a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.white},
    c = {bg = colors.gray, fg = colors.white},
  },
  insert = {
    a = {bg = colors.green, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.white},
    c = {bg = colors.gray, fg = colors.white},
  },
  visual = {
    a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.white},
    c = {bg = colors.gray, fg = colors.white},
  },
  replace = {
    a = {bg = colors.red, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.white},
    c = {bg = colors.gray, fg = colors.white},
  },
  command = {
    a = {bg = colors.magenta, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.white},
    c = {bg = colors.gray, fg = colors.white},
  },
  inactive = {
    a = {bg = colors.lightgray, fg = colors.white, gui = 'bold'},
    b = {bg = colors.inactivegray, fg = colors.white},
    c = {bg = colors.inactivegray, fg = colors.white},
  },
}

local dashArt = [[
 ██████╗ ██╗   ██╗███████╗██████╗ ████████╗██╗   ██╗██████╗ ███████╗
██╔═══██╗██║   ██║██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔════╝
██║   ██║██║   ██║█████╗  ██████╔╝   ██║   ██║   ██║██████╔╝█████╗  
██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗   ██║   ██║   ██║██╔══██╗██╔══╝  
╚██████╔╝ ╚████╔╝ ███████╗██║  ██║   ██║   ╚██████╔╝██║  ██║███████╗
 ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝
]]

vim.cmd.colorscheme("cole")

vim.keymap.set("n", "<leader>ff", function() require("fzf-lua").files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() require("fzf-lua").live_grep() end, { desc = "Live grep" })

require("mini.icons").setup()
require("mini.pairs").setup()
require("neoscroll").setup()

require("lualine").setup {
  options = {
    theme = cole,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"filename"},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {"location"},
    lualine_z = {"filetype"}
  },
  inactive_sections = {
    lualine_a = {"filetype"},
    lualine_b = {"encoding"},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
}

require("oil").setup {
  view_options = { show_hidden = true }
}

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })

require("dashboard").setup {
  theme = "doom",
  config = {
    header = vim.split(dashArt, "\n"),
    center = {
      {
        desc = "New file",
        key = "e",
        key_format = " %s",
        action = "enew"
      },
      {
        desc = "Update Native Plugins",
        key = "u",
        key_format = " %s",
        action = "packupdate"
      },
      {
        desc = "Open Config",
        key = "c",
        key_format = " %s",
        action = "e ~/.config/nvim/init.lua"
      }
    },
    footer = { "\"One is not born, but rather becomes, a rustacean.\"" },
    vertical_center = true,
  },
}

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = colors.yellow, bold = true })
vim.api.nvim_set_hl(0, "DashboardDesc", { fg = colors.white })
vim.api.nvim_set_hl(0, "DashboardKey", { fg = colors.red })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = colors.magenta, italic = true })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
    },
  },
})
vim.lsp.enable({
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "ts_ls",
  "tinymist"
})

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site"
})
require("nvim-treesitter").install {
  "lua",
  "rust",
  "python",
  "typescript",
}

require("blink.cmp").setup {
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    documentation = { auto_show = false }
  },
  snippets = {
    preset = "default"
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning"
  }
}

require("snacks.input").enable {
  icon = " ",
  icon_hl = "SnacksInputIcon",
  icon_pos = "left",
  prompt_pos = "title",
  expand = true,
  win = {
    style = "input",
    backdrop = false,
    position = "float",
    border = "rounded",
    title_pos = "center",
    height = 1,
    width = 60,
    relative = "editor",
    row = 2,
    wo = {
      winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
      cursorline = false,
    },
    b = {
      completion = false,
    }
  },
}
