-- why packadd vs vim.pack.add
-- some plugins come "builtin" you just have to activate them
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)
