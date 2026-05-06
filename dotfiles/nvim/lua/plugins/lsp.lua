return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
          -- Frontend essentials
          "ts_ls",
					"html",
					"cssls",
          "tailwindcss",

          -- Systems programming
          "rust_analyzer",
          "clangd",

          -- Config files
          "lua_ls",
          "jsonls"
				},
				automatic_installation = true,
			})

			local lspconfig = require("lspconfig")
		end
	},
}
