vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

local lsp_servers = {
	"lua_ls",
	"yamlls", -- yaml-language-server yamlls (keywords: yaml)
}

local mason_formatters = {
	"lua-language-server",
	"yaml-language-server",
	"stylua",
	"google-java-format",
}

local servers = vim.list_extend(vim.list_extend({}, lsp_servers), mason_formatters)

require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:crashdummyy/mason-registry",
	},
})

require("mason-lspconfig").setup({ automatic_enable = {
	exclude = {
		"jdtls",
	},
} })
require("mason-tool-installer").setup({
	ensure_installed = servers,
})
