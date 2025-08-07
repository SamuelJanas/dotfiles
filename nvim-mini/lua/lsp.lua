local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Mason + LSPConfig
add({
  source = 'williamboman/mason.nvim',
  depends = { 'nvim-lua/plenary.nvim' },
  hooks = {
    post_checkout = function()
      require('mason').setup()
    end,
  },
})

add({
  source = 'williamboman/mason-lspconfig.nvim',
  depends = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
})

add({
  source = 'neovim/nvim-lspconfig',
})

later(function()
  local mason_lspconfig = require('mason-lspconfig')

  local servers = {
    lua_ls = {},
    pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "off",
          },
        },
      },
    },
    omnisharp = {},
  }

  require('mason').setup()

  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
  })
end)

