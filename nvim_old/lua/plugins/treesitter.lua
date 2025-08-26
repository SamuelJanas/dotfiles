return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
        ensure_installed = {"c", "c_sharp", "lua", "vim", "html", "python", "go", "markdown", "sql", "yaml", "dockerfile", },
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    })
  end
}
