vim.pack.add({
	{
		src = "https://github.com/stevearc/conform.nvim",
	},
})

require("conform").setup({
	formatters_by_ft = {
		-- ['html.handlebars'] = config,
		-- ['javascript.glimmer'] = config,
		-- ['typescript.glimmer'] = config,
		-- handlebars = config,
		-- html = config,
		java = { "google-java-format" },
		-- javascript = config,
		lua = { "stylua" },
		-- sh = { "shfmt" },
		-- typescript = config,
		-- xml = { "xmlformat" },
		yaml = { "yamlfix" },
	},
})

-- I hate auto format. I will format when I mean to (which is after I'm
-- done with my current implementation
vim.keymap.set("n", "<leader>f", function()
	local filetype = vim.bo.filetype
	local conform_filetypes = {
		-- "handlebars",
		-- "html.handlebars",
		"java",
		-- "javascript",
		-- "javascript.glimmer",
		"lua",
		-- "sh",
		-- "typescript",
		-- "typescript.glimmer",
		-- "xml",
		"yaml",
	}

	-- check if I have a conform formatter set
	local use_conform = false
	for _, ft in ipairs(conform_filetypes) do
		if filetype == ft then
			use_conform = true
			break
		end
	end

	if use_conform then
		require("conform").format({ async = true, lsp_fallback = true })
	else
		vim.lsp.buf.format()
	end
end)
