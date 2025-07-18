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
    require("window-picker").setup({
	    autoselect_one = true,
	    include_current = false,
	    filter_rules = {
		bo = {
		    filetype = { "neo-tree", "neo-tree-popup", "notify" },
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
		follow_current_file = { enabled=false },
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
    end,
}
