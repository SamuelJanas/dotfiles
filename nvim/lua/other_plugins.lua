return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        file_ignore_patterns = { ".git", "node_modules", ".venv", "requirements.txt", ".lock" },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
  },
}
