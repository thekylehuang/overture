return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    config = function()
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
          a = {bg = colors.cardgray, fg = colors.white, gui = 'bold'},
          b = {bg = colors.inactivegray, fg = colors.white},
          c = {bg = colors.inactivegray, fg = colors.white},
        },
      }
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
    end
  }
}
