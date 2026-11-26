--ripgrep dependency

local function build_fzf_native(spec)
	local result = vim.system({ "make" }, { cwd = spec.path, text = true }):wait()

	if result.code ~= 0 then
		vim.notify(result.stderr or result.stdout or "Build failed", vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind, spec = ev.data.spec.name, ev.data.kind, ev.data.spec
		if name == "telescope-fzf-native.nvim" and (kind == "update" or kind == "install") then
			vim.notify("Building telescope-fzf-native...")
			build_fzf_native(spec)
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		version = "v0.2.2",
	},
	{
		src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	},
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
})

require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- Additional dropdown options
			}),
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
