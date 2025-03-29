if vim.g.vscode then
  require("config.vscode_keymaps")

else
	require("config.lazy")
	require("config.keymaps")

	vim.cmd("set number")
	vim.cmd("set relativenumber")
	vim.cmd("set scrolloff=12")
	vim.cmd("set shiftwidth=4 smarttab")
	-- vim.cmd("set expandtab")
	-- vim.cmd("set laststatus=3")

	vim.g.lazyvim_cmp = "auto"

	local isLspDiagnosticsVisible = true
	vim.keymap.set("n", "<leader>lx", function()
		isLspDiagnosticsVisible = not isLspDiagnosticsVisible
		vim.diagnostic.config({
			virtual_text = isLspDiagnosticsVisible,
			underline = isLspDiagnosticsVisible,
		})
	end)
end

