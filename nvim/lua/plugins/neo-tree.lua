return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"s1n7ax/nvim-window-picker",
	},
	config = function()
		-- Configure window picker
		require("window-picker").setup({
			autoselect_one = true,
			include_current = false,
			filter_rules = {
				-- filter using buffer options
				bo = {
					-- if the file type is one of following, the window will be ignored
					filetype = { "neo-tree", "neo-tree-popup", "notify" },
					-- if the buffer type is one of following, the window will be ignored
					buftype = { "terminal", "quickfix" },
				},
			},
		})

		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			view = {
				preserve_window_proportions = true,
			},
			window = {
				position = "right",
				width = 30,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
			},
                        actions = {
                            open_file = {
                                resize_window = true,
                            },
                        },
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
				follow_current_file = {enabled=True},
				use_libuv_file_watcher = true,
				window = {
					mappings = {
						["<cr>"] = "open_with_window_picker",
					},
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})

		-- Key mapping to toggle NeoTree with <leader>e
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {
			noremap = true,
			silent = true,
			desc = "Toggle NeoTree",
		})
	end,
}
