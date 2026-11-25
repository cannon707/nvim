vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		data = {
			run = function(_)
				vim.cmd("TSUpdate")
			end,
		},
	},
})

local parsers = {
	"vimdoc",
	"javascript",
	"typescript",
	"c",
	"lua",
	"rust",
	"java",
	"jsdoc",
	"bash",
	"json5",
}

local filetypes = {}
for _, lang in ipairs(parsers) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        table.insert(filetypes, ft)
    end
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function(args)
        pcall(vim.treesitter.start(), args.buf)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
