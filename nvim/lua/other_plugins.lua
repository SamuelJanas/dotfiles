return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      local ok, parsers = pcall(require, "nvim-treesitter.parsers")
      if ok and not parsers.ft_to_lang then
        parsers.ft_to_lang = function(ft)
          return vim.treesitter.language.get_lang(ft) or ft
        end
      end

      require("telescope").setup(opts)
    end,
    opts = {
      defaults = {
        file_ignore_patterns = { ".git", "node_modules", ".venv", "requirements.txt", ".lock" },
        preview = {
          treesitter = false,
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
  },
}
