-- Install LuaRocks and tiktoken_core:
-- sudo apt install -y luarocks
--
-- IMPORTANT: sudo uses a restricted environment and does not inherit
-- your user's Rustup configuration (RUSTUP_HOME, CARGO_HOME, PATH).
-- This can cause tiktoken_core compilation to fail because it requires Cargo.
--
-- Install using your existing user Rust toolchain:
-- sudo env \
--   RUSTUP_HOME="$HOME/.rustup" \
--   CARGO_HOME="$HOME/.cargo" \
--   PATH="$HOME/.cargo/bin:$PATH" \
--   luarocks install --lua-version 5.1 tiktoken_core

-- this is to require the make if the package has updated
local function build_tiktoken(spec)
	local result = vim.system({ "make", "tiktoken" }, { cwd = spec.path, text = true }):wait()

	if result.code ~= 0 then
		vim.notify(result.stderr or result.stdout or "Build failed", vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind, spec = ev.data.spec.name, ev.data.kind, ev.data.spec

		if name == "CopilotChat.nvim" and (kind == "update" or kind == "install") then
			vim.notify("Building CopilotChat tiktoken...")
			build_tiktoken(spec)
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
})

-- github.com/settings/copilot/features
require("CopilotChat").setup({
	model = "gpt-5.6-luna",

	headers = {
		user = "👤 You",
		assistant = "🤖 Copilot",
		tool = "🔧 Tool",
	},

	-- Tool permissions (default: require approval)
	trusted_tools = nil,

	-- Trust all functions in a group:
	-- trusted_tools = "copilot",

	-- Trust specific functions or groups:
	-- trusted_tools = { "file", "glob", "grep" },

	-- Trust every enabled tool:
	-- trusted_tools = true,
})

vim.api.nvim_set_hl(0, "CopilotChatHeader", {
	fg = "#7C3AED",
	bold = true,
})

vim.api.nvim_set_hl(0, "CopilotChatSeparator", {
	fg = "#374151",
})
