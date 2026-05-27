{ pkgs, ... }: {
  home.stateVersion = "26.05";
  home.username = "kylehuang";
  home.homeDirectory = "/Users/kylehuang";

  home.packages = [
    pkgs.fnm
  ];
 
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        color = {
          keys = "yellow";
          title = "39";
          separator = "yellow";
        };
      };
      logo = {
        source = "nixos";
        padding = {
          right = 6;
          top = 1;
        };
      };
      modules = [
        "break"
        "break"
        "break"
        "break"
        "break"
        "title"
        "separator"
        "os"
        "kernel"
        "uptime"
        "shell"
        "de"
        "terminal"
        "cpu"
        "gpu"
        "break"
        "colors"
      ];
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kyle Huang";
        email = "kyle@thekylehuang.org";
      };

      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.iamb = {
    enable = true;
    settings = {
      profiles.user = {
        user_id = "@thekylehuang:matrix.org";
      };
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      blink-cmp
      nvim-lspconfig
      nvim-treesitter
      cole-nvim
      lualine-nvim
      oil-nvim
      typst-preview-nvim
      fzf-lua
      dashboard-nvim
      friendly-snippets
      mini-nvim

      (nvim-treesitter.withPlugins (p: with p; [
        lua
        rust
        python
        typescript
      ]))
    ];
    initLua = ''
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

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      vim.opt.clipboard = "unnamedplus"
      vim.opt.fillchars = { eob = " " }

      vim.diagnostic.config({virtual_text = true, signs = false})

      vim.opt.wrap = true
      vim.opt.linebreak = true

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

      require("blink.cmp").setup {
        keymap = { preset = "default" },
        appearance = { nerd_font_variant = "mono" },
        completion = { documentation = { auto_show = false } },
        snippets = { preset = "default" },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
      }
      
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })
      local servers = { "pyright", "rust_analyzer", "ts_ls", "tinymist" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end
      vim.lsp.enable(servers)
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = ''
      $directory$git_branch$git_status
      $character
      '';
      directory = {
        style = "#f2e6cf";
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };
      git_branch = {
        format = "[git:$branch](#858585) ";
      };
      git_status = {
        style = "#858585";
      };
      character = {
        format = "$symbol ";
        success_symbol = "[󰘧](#b38d59) ";
        error_symbol = "[󱄅](#cc5d4b) ";
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    extraConfig = ''
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'thekylehuang/cole-tmux'
        
      unbind '"'
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind H resize-pane -L 5
      bind J resize-pane -D 5
      bind K resize-pane -U 5
      bind L resize-pane -R 5

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
  
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    flavors = {
      cole = ../dotfiles/yazi/flavors/cole.yazi;
    };

    theme = {
      flavor = {
        dark = "cole";
      };
    };

    settings = {
      mgr = {
        show_symlink = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initContent = ''
      eval "$(fnm env --use-on-cd --shell zsh)" 
    '';
  };
}
