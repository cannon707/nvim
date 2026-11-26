vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/folke/trouble.nvim" },
})

require("nvim-web-devicons").setup({
	color_icons = true,
	default = true,
})

require("trouble").setup({
	color_icons = true,
	default = true,
})

local trouble = require("trouble")

vim.keymap.set( "n", "<leader>xx", function()
    trouble.toggle("diagnostics")
end, { desc = "Diagnostics (Trouble)" })

vim.keymap.set( "n", "<leader>xX", function()
	trouble.toggle("diagnostics", { filter = { buf = 0 } })
end, { desc = "Buffer Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>cs", function()
	trouble.toggle("symbols")
end, { desc = "Document symbols (Trouble)" })

vim.keymap.set("n", "<leader>cl", function()
	trouble.toggle("lsp")
end, { desc = "LSP definitions/references (Trouble)" })

vim.keymap.set("n", "<leader>xL", function()
	trouble.toggle("loclist")
end, { desc = "Location list (Trouble)" })

vim.keymap.set("n", "<leader>xQ", function()
	trouble.toggle("qflist")
end, { desc = "Quickfix list (Trouble)" })
