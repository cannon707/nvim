vim.pack.add({
	{
		src = "https://github.com/mfussenegger/nvim-lint",
		name = "lint",
	},
})

require("lint").linters_by_ft = {
	markdown = { "markdownlint-cli2" }, --found in mason.lua
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

vim.api.nvim_create_autocmd({
    "TextChanged",
    "InsertLeave",
    "BufWritePost",
}, {
    callback = function(args)
        if vim.bo[args.buf].filetype:match("markdown") then
            require("lint").try_lint()
        end
    end,
})

vim.keymap.set("n", "<leader>ll", function()
	require("lint").try_lint()
end, { desc = "Run Linter" })
