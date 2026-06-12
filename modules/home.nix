{ pkgs, ... }:
let
  cole = {
    bg = "#0c0c0c";
    fg = "#f2e6cf";
    fgMuted = "#858585";
    gray = "#121212";
    brightGray = "#1c1c1c";
    darkGray = "#0f0f0f";
    border = "#5b5b5b";
    black = "#101010";
    red = "#cc5d4b";
    green = "#2e9969";
    yellow = "#b38d59";
    blue = "#6179c2";
    purple = "#ab78ab";
    cyan = "#33919c";
    white = "#a5a5a5";
    brightBlack = "#3d3d3d";
    brightRed = "#d96857";
    brightGreen = "#66cc69";
    brightYellow = "#cc9b52";
    brightBlue = "#5582c2";
    brightPurple = "#bf86bf";
    brightCyan = "#73bfbf";
    brightWhite = "#cdcdcd";
  };
in
{
  home.stateVersion = "26.05";
  home.username = "kylehuang";
  home.homeDirectory = "/Users/kylehuang";
  home.enableNixpkgsReleaseCheck = false;
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
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
    signing = {
      key = "848B77EBF40D45C8EB95679D2FFB6BEF80136423";
      signByDefault = true;
    };
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

  programs.gpg.enable = true;
 
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      blink-cmp
      nvim-lspconfig
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
        nix
        python
        rust
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

      local cole = {
        normal = {
          a = {bg = "${cole.blue}", fg = "${cole.black}", gui = 'bold'},
          b = {bg = "${cole.gray}", fg = "${cole.fg}"},
          c = {bg = "${cole.gray}", fg = "${cole.fg}"},
        },
        insert = {
          a = {bg = "${cole.green}", fg = "${cole.black}", gui = 'bold'},
          b = {bg = "${cole.gray}", fg = "${cole.fg}"},
          c = {bg = "${cole.gray}", fg = "${cole.fg}"},
        },
        visual = {
          a = {bg = "${cole.yellow}", fg = "${cole.black}", gui = 'bold'},
          b = {bg = "${cole.gray}", fg = "${cole.fg}"},
          c = {bg = "${cole.gray}", fg = "${cole.fg}"},
        },
        replace = {
          a = {bg = "${cole.red}", fg = "${cole.black}", gui = 'bold'},
          b = {bg = "${cole.gray}", fg = "${cole.fg}"},
          c = {bg = "${cole.gray}", fg = "${cole.fg}"},
        },
        command = {
          a = {bg = "${cole.purple}", fg = "${cole.black}", gui = 'bold'},
          b = {bg = "${cole.gray}", fg = "${cole.fg}"},
          c = {bg = "${cole.gray}", fg = "${cole.fg}"},
        },
        inactive = {
          a = {bg = "${cole.brightGray}", fg = "${cole.fg}", gui = 'bold'},
          b = {bg = "${cole.darkGray}", fg = "${cole.fg}"},
          c = {bg = "${cole.darkGray}", fg = "${cole.fg}"},
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
              desc = "Open Config",
              key = "c",
              key_format = " %s",
              action = "e ~/.config/overture/modules/home.nix"
            }
          },
          footer = { "\"One is not born, but rather becomes, a rustacean.\"" },
          vertical_center = true,
        },
      }

      vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "${cole.yellow}", bold = true })
      vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "${cole.fg}"})
      vim.api.nvim_set_hl(0, "DashboardKey", { fg = "${cole.red}"})
      vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "${cole.purple}", italic = true })

      require("blink.cmp").setup {
        keymap = { preset = "default" },
        appearance = { nerd_font_variant = "mono" },
        completion = { documentation = { auto_show = false } },
        snippets = { preset = "default" },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
      }
      
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
        astro = {
          binary = "astro-ls",
          init_options = tsdk_path and {
            typescript = { tsdk = tsdk_path }
          } or nil
        },
        pyright = { binary = "pyright" },
        rust_analyzer = { binary = "rust-analyzer" },
        tinymist = { binary = "tinymist" },
        ts_ls = {
          binary = "typescript-language-server",
          init_options = tsdk_path and {
            typescript = { tsdk = tsdk_path }
          } or nil
        },

        lua_ls = {
          binary = "lua-language-server",
          settings = {
            Lua = { diagnostics = { globals = { "vim" } } }
          }
        },
      }
      local active_servers = {}
      
      for server_name, config in pairs(servers) do
        if vim.fn.executable(config.binary) == 1 then
          table.insert(active_servers, server_name)

          vim.lsp.config(server_name, {
            capabilities = capabilities,
            settings = config.settings or nil,
            init_options = config.init_options or nil,
          })
        end
      end
      
      if #active_servers > 0 then
        vim.lsp.enable(active_servers)
      end
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
        style = "${cole.fg}";
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };
      git_branch = {
        format = "[git:$branch](${cole.fgMuted}) ";
      };
      git_status = {
        style = "${cole.fgMuted}";
      };
      character = {
        format = "$symbol ";
        success_symbol = "[󰘧](${cole.yellow}) ";
        error_symbol = "[󱄅](${cole.red}) ";
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
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
      cole = pkgs.writeTextDir "flavor.toml" ''
        [app]
        overall = { bg = "${cole.bg}" }
         
        [mgr]
        cwd = { fg = "${cole.yellow}" }
        hovered = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
        preview_hovered = { underline = true }
         
        find_keyword = { fg = "${cole.fg}", bg = "${cole.yellow}", bold = true }
        find_position = { fg = "${cole.blue}", bg = "reset", italic = true }
         
        symlink_target = { fg = "${cole.brightBlack}", italic = true }
         
        marker_copied = { fg = "${cole.green}", bg = "${cole.green}" }
        marker_cut = { fg = "${cole.red}", bg = "${cole.red}" }
        marker_marked = { fg = "${cole.blue}", bg = "${cole.blue}" }
        marker_selected = { fg = "${cole.yellow}", bg = "${cole.yellow}" }
        marker_symbol = "│"
         
        count_copied = { fg = "${cole.bg}", bg = "${cole.green}" }
        count_cut = { fg = "${cole.bg}", bg = "${cole.red}" }
        count_selected = { fg = "${cole.bg}", bg = "${cole.yellow}" }
         
        border_symbol = "╎"
        border_style = { fg = "${cole.border}" }
         
        [indicator]
        current = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
        parent = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
        preview = { fg = "${cole.bg}", bg = "${cole.yellow}", underline = true }
        padding = { open = "", close = "" }
         
        [mode]
        normal_main = { fg = "${cole.bg}", bg = "${cole.blue}", bold = true }
        normal_alt = { fg = "${cole.fg}", bg = "${cole.brightBlack}" }
         
        select_main = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
        select_alt = { fg = "${cole.fg}", bg = "${cole.brightBlack}" }
         
        unset_main = { fg = "${cole.bg}", bg = "${cole.red}", bold = true }
        unset_alt = { fg = "${cole.fg}", bg = "${cole.brightBlack}" }
         
        [tabs]
        active = { fg = "${cole.gray}", bg = "${cole.yellow}" }
        inactive = { fg = "${cole.fg}", bg = "${cole.gray}" }
        sep_inner = { open = " ", close = " " }
        sep_outer = { open = " ", close = " " }
         
        [status]
        overall = { fg = "${cole.fg}", bg = "${cole.gray}" }
        sep_left = { open = "", close = "" }
        sep_right = { open = "", close = "" }
         
        progress_label = { fg = "${cole.fg}", bold = true }
        progress_normal = { fg = "${cole.yellow}", bg = "${cole.brightBlack}" }
        progress_error = { fg = "${cole.red}", bg = "${cole.brightBlack}" }
         
        perm_type = { fg = "${cole.yellow}" }
        perm_read = { fg = "${cole.blue}" }
        perm_write = { fg = "${cole.red}" }
        perm_exec = { fg = "${cole.green}" }
        perm_sep = { fg = "${cole.brightBlack}" }
         
        [confirm]
        border = { fg = "${cole.border}" }
        title = { fg = "${cole.yellow}" }
        body = {}
        list = {}
        btn_yes = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
        btn_no = {}
        btn_labels = [ "  [Y]es  ", "  (N)o  " ]
         
        [spot]
        border = { fg = "${cole.border}" }
        title = { fg = "${cole.yellow}" }
        tbl_col = { fg = "${cole.blue}" }
        tbl_cell = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
         
        [pick]
        border = { fg = "${cole.border}" }
        active = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
        inactive = { fg = "${cole.brightBlack}" }
         
        [input]
        border = { fg = "${cole.border}" }
        title = { fg = "${cole.yellow}" }
        value = {}
        selected = { fg = "${cole.bg}", bg = "${cole.yellow}" }
         
        [cmp]
        border = { fg = "${cole.border}" }
        active = { fg = "${cole.bg}", bg = "${cole.yellow}" }
        inactive = {}
        icon_file = "  "
        icon_folder = "  "
        icon_command = "  "
         
        [tasks]
        border = { fg = "${cole.border}" }
        title = { fg = "${cole.yellow}" }
        hovered = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
         
        [which]
        cols = 3
        mask = { bg = "${cole.gray}" }
        cand = { fg = "${cole.yellow}" }
        rest = { fg = "${cole.brightBlack}" }
        desc = { fg = "${cole.blue}" }
        separator = "  "
        separator_style = { fg = "${cole.brightBlack}" }
         
        [help]
        on = { fg = "${cole.yellow}" }
        run = { fg = "${cole.blue}" }
        desc = {}
        hovered = { fg = "${cole.bg}", bg = "${cole.yellow}", bold = true }
        footer = { fg = "${cole.bg}", bg = "${cole.white}" }
         
        [notify]
        title_info = { fg = "${cole.green}" }
        title_warn = { fg = "${cole.yellow}" }
        title_error = { fg = "${cole.red}" }
        icon_info = ""
        icon_warn = ""
        icon_error = ""
         
        [filetype]
        rules = [
          { url = "*/", fg = "${cole.fg}" },
         
          { mime = "image/*", fg = "${cole.purple}" },
          { mime = "video/*", fg = "${cole.purple}" },
          { mime = "audio/*", fg = "${cole.purple}" },
         
          { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio}", fg = "${cole.yellow}" },
         
          { mime = "application/{pdf,doc,rtf}", fg = "${cole.red}" },
         
          { mime = "text/*", fg = "${cole.fg}" },
          { mime = "application/json", fg = "${cole.yellow}" },
          { mime = "application/javascript", fg = "${cole.yellow}" },
          { mime = "application/xml", fg = "${cole.yellow}" },
         
          { url = "*", is = "exec", fg = "${cole.green}" },
          { url = "*", is = "orphan", bg = "${cole.red}" },
         
          { url = "*", fg = "${cole.fg}" },
        ]

        [icon]
        dirs = [
          { name = ".config", text = "", fg = "${cole.blue}" },
          { name = ".git", text = "", fg = "${cole.red}" },
          { name = ".github", text = "", fg = "${cole.blue}" },
          { name = ".npm", text = "", fg = "${cole.cyan}" },
          { name = "Desktop", text = "", fg = "${cole.yellow}" },
          { name = "dev", text = "", fg = "${cole.cyan}" },
          { name = "Documents", text = "", fg = "${cole.yellow}" },
          { name = "Downloads", text = "", fg = "${cole.yellow}" },
          { name = "Books", text = "", fg = "${cole.yellow}" },
          { name = "Movies", text = "", fg = "${cole.purple}" },
          { name = "Music", text = "", fg = "${cole.purple}" },
          { name = "Pictures", text = "", fg = "${cole.purple}" },
          { name = "Public", text = "", fg = "${cole.yellow}" },
          { name = "Videos", text = "", fg = "${cole.purple}" },
        ]

        prepend_conds = [
          { if = "orphan", text = "", fg = "${cole.red}" },
          { if = "link", text = "", fg = "${cole.white}" },
          { if = "block", text = "", fg = "${cole.blue}" },
          { if = "char", text = "", fg = "${cole.blue}" },
          { if = "fifo", text = "", fg = "${cole.blue}" },
          { if = "sock", text = "", fg = "${cole.blue}" },
          { if = "sticky", text = "", fg = "${cole.blue}" },
          { if = "dummy", text = "", fg = "${cole.red}" },
          { if = "dir", text = "", fg = "${cole.yellow}" },
          { if = "exec", text = "", fg = "${cole.green}" },
          { if = "!dir", text = "", fg = "${cole.fgMuted}" },
        ]

        prepend_exts = [
          { name = "js", text = "", fg = "${cole.yellow}" },
          { name = "ts", text = "", fg = "${cole.blue}" },
          { name = "jsx", text = "", fg = "${cole.cyan}" },
          { name = "tsx", text = "", fg = "${cole.cyan}" },
          { name = "json", text = "", fg = "${cole.yellow}" },
          { name = "toml", text = "", fg = "${cole.yellow}" },
          { name = "yml", text = "", fg = "${cole.yellow}" },
          { name = "yaml", text = "", fg = "${cole.yellow}" },
          { name = "md", text = "", fg = "${cole.yellow}" },
          { name = "mdx", text = "", fg = "${cole.yellow}" },
          { name = "sh", text = "", fg = "${cole.green}" },
          { name = "py", text = "", fg = "${cole.blue}" },
          { name = "rs", text = "", fg = "${cole.red}" },
          { name = "go", text = "", fg = "${cole.cyan}" },
          { name = "lua", text = "", fg = "${cole.red}" },
          { name = "zip", text = "", fg = "${cole.yellow}" },
          { name = "pdf", text = "", fg = "${cole.red}" },
          { name = "png", text = "", fg = "${cole.purple}" },
          { name = "jpg", text = "", fg = "${cole.purple}" },
          { name = "jpeg", text = "", fg = "${cole.purple}" },
          { name = "svg", text = "󰜡", fg = "${cole.yellow}" },
          { name = "mp4", text = "", fg = "${cole.purple}" },
        ]
      '';
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
  };
}
