return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
	options = {
	  theme = "gruvbox_dark",
	  component_separators = "|",
	  section_separators = { left = "", right = "" },
	  global_status = true,
	},
	sections = {
	    lualine_a = {
		{ "mode", separator = { left = "" }, right_padding = 2 },
	    },
	    lualine_b = { {"filename", path=1}, "branch" },
	    lualine_c = { "fileformat" },
	    lualine_x = {},
	    lualine_y = { "filetype", "progress" },
	    lualine_z = {
		{ "location", separator = { right = "" }, left_padding = 2 },
	    },
	},
	inactive_sections = {
	    lualine_a = { "filename" },
	    lualine_b = {},
	    lualine_c = {},
	    lualine_x = {},
	    lualine_y = {},
	    lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
    }
    end,
}
