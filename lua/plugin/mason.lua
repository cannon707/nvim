vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

local lsp_servers = {
	"lua_ls",
	"yamlls", -- yaml-language-server yamlls (keywords: yaml)
	"marksman",
}

local mason_package_names = {
	"lua-language-server", --depends on node
	"yaml-language-server", --depends on node
	"stylua", --depends on unzip
	"google-java-format",
}

local servers = vim.list_extend(vim.list_extend({}, lsp_servers), mason_package_names)

require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:crashdummyy/mason-registry",
	},
})

require("mason-lspconfig").setup({
	automatic_enable = false,
})
require("mason-tool-installer").setup({
	ensure_installed = servers,
})
